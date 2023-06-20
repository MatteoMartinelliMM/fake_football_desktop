// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:io';


import 'package:fake_football_desktop/bloc/video_generator_bloc/video_generator_event.dart';
import 'package:fake_football_desktop/bloc/video_generator_bloc/video_generator_state.dart';
import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/event_status.dart';
import 'package:fake_football_desktop/model/event_type.dart';
import 'package:fake_football_desktop/model/sport_match.dart';
import 'package:fake_football_desktop/repository/video_generator_repository.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:fake_football_desktop/utils/ffmpeg_constants.dart';
import 'package:fake_football_desktop/utils/ffmpeg_interactor.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoGeneratorBloc extends Bloc<VideoGeneratorEvent, VideoGeneratorState> {
  VideoGeneratorRepository videoGeneratorRepository;
  FfmpegInteractor ffmpegInteractor;
  String partita = 'F:\\Users\\Teo\\Documents\\riprendimi\\partita_27_04.json';
  final RegExp _timeRegex = RegExp(r'\b\d{2}:\d{2}:\d{2}\b');
  late String basePath, currMatchDir, currMediaDir, mediaType, fullVideoPath, currFakeMomentsDir;
  late String videoExt;
  late EventType fakeMomentsCurrType;
  Map<String, String> extByFileName = {};
  late List<SportMatch> sportMatches;
  List<Event>? choosenFakeMoments;
  Map<EventType, List<Event>>? possibleFakeMoments;
  late List<Event> currHighlights;
  late List<Event> currEvents;
  List<Event> _removedEvents = [];
  bool finalResultViewed = false;
  SportMatch? currMatch;
  StreamSubscription<FileSystemEvent>? currDirListner;
  bool _isReclip = false;
  int _fileSaveProcess = 0;
  String? recordingWidth, recordingHeight;

  VideoGeneratorBloc({required this.videoGeneratorRepository, required this.ffmpegInteractor})
      : super(LoadPageState(LOAD_CONTENTS_MSG)) {
    basePath = PathProvider.getCompletePath([VIDEO]);
    /*getApplicationDocumentsDirectory().then((value) {
      return basePath = [value.path, ROOT_DIR_NO_SLASH, VIDEO].buildFilePath();
    });*/
    on<EnterPageEvent>(_mapOnEnterPageEvent);
    on<BackPressEvent>(_mapOnBackPressEvent);
    on<ErrorEvent>(_mapOnErrorEvent);
    on<LoadProgressEvent>(_mapOnLoadProgressEvent);
    on<SportMatchPickedEvent>(_mapOnSportMatchPickedEvent);
    on<MediaTypeSelectedEvent>(_mapOnMediaTypeSelectedEvent);
    on<VideoChangeEvent>(_mapOnVideoChangeEvent);
    on<ClipTimeChangeEvent>(_mapOnClipTimeChangeEvent);
    on<ReClipVideoEvent>(_mapOnReClipVideoEvent);
    on<MarkVideoAsFavouriteEvent>(_mapOnMarkVideoAsFavouriteEvent);
    on<RemoveClipEvent>(_mapOnRemoveClipEvent);
    on<OverflowMenuEvent>(_mapOnOverflowMenuEvent);
    on<VideoClickEvent>(_mapOnVideoClickEvent);
    on<FakeMomentsCheckedEvent>(_mapOnFakeMomentsCheckedEvent);
    on<NextEvent>(_mapOnNextEvent);
    on<FakeMomentsPickedEvent>(_mapOnFakeMomentsPickedEvent);
    on<HighlightsBuildedEvent>(_mapOnHighlightsBuildedEvent);
  }

  //region getters

  List<String> get removedVideos => _removedEvents.map((e) => e.fileName()).toList();

  int get videoLength {
    int templateTime = choosenFakeMoments.isNullOrEmpty() ? 4000 : 6000;
    print('call videoLength from state ${state.runtimeType.toString()}');
    switch (state.runtimeType) {
      case ChooseFakeMomentsEventsState:
        return templateTime +
            currHighlights.totEventsLength() +
            (choosenFakeMoments?.totEventsLength() ?? 0);
      case ChooseFakeMomentsState:
      case GeneratingMediaState:
      case LoadPageState:
        return templateTime +
            currEvents.totEventsLength() +
            (choosenFakeMoments?.totEventsLength() ?? 0);
      default:
        return 0;
    }
  }

  //endregion

  //region loading navigation and errors
  FutureOr<void> _mapOnEnterPageEvent(
      EnterPageEvent event, Emitter<VideoGeneratorState> emit) async {
    sportMatches = await videoGeneratorRepository.getAllSportMatches();
    Directory d = await PathProvider.getDirFromPath([VIDEO]).create(recursive: true);
    sportMatches.forEach((s) {
      FileSystemEntity? e = d.listSync().firstOrNullWhere((e) =>
          e.path.startsWith([basePath, s.dateTime!].buildFilePath()) && e.path.endsWith(MP4) ||
          e.path.endsWith(MKV));
      if (e != null && e.path.getFileExt() != null) {
        extByFileName[s.dateTime!] = e.path.getFileExt()!;
      }
    });
    emit(SportMatchesLoadedState(sportMatches, extByFileName));
  }

  FutureOr<void> _mapOnLoadProgressEvent(
      LoadProgressEvent event, Emitter<VideoGeneratorState> emit) async {
    if (state is LoadPageState) {
      int? lastPercentage = (state as LoadPageState).percentage;
      int percentage = (event.millis * 100) ~/ videoLength;
      if (percentage <= 100 && (lastPercentage == null || lastPercentage < percentage)) {
        String msg = (state as LoadPageState).msg.split('(').first += ' ($percentage %)';
        emit(LoadPageState(msg, percentage: percentage));
      }
    }
  }

  FutureOr<void> _mapOnErrorEvent(ErrorEvent event, Emitter<VideoGeneratorState> emit) async {
    emit(ErrorState(event.errorMsg));
  }

  FutureOr<void> _mapOnBackPressEvent(
      BackPressEvent event, Emitter<VideoGeneratorState> emit) async {
    switch (state.runtimeType) {
      case SportMatchesLoadedState:
        emit(CloseState());
        break;
      case SingleMatchLoadedState:
        emit(SportMatchesLoadedState(sportMatches, extByFileName));
        break;
      case GeneratingMediaState:
        List<String> actions = await _getActionsForMatch();
        emit(SingleMatchLoadedState(currMatch!, actions, videoExt));
        break;
      case ChooseFakeMomentsState:
      case ShowHighlightsState:
        currEvents = currHighlights;
        createOpenAndListenDir(currMediaDir);
        emit(GeneratingMediaState(currEvents, currMatch!, videoExt, videoLength, removedVideos));
        break;
      case ChooseFakeMomentsEventsState:
        currEvents = currHighlights;
        emit(ChooseFakeMomentsState(possibleFakeMoments!, currMatch!, videoExt, videoLength));
        break;
    }
  }

  //endregion

  FutureOr<void> _mapOnSportMatchPickedEvent(
      SportMatchPickedEvent event, Emitter<VideoGeneratorState> emit) async {
    currMatch = sportMatches[event.position];
    fullVideoPath = PathProvider.getCompletePath([VIDEO, currMatch!.dateTime!]);
    currMatchDir = PathProvider.getCompletePath([VIDEO, currMatch!.dateTime!]);
    Directory currentMatchDir = Directory(currMatchDir);
    currentMatchDir.createIfNotExistsSync(recursive: true);
    videoExt = extByFileName.containsKey(currMatch!.dateTime!)
        ? extByFileName[currMatch!.dateTime!]!
        : MKV;
    ffmpegInteractor.getRecordingInfo(
        recordingName: currMatch!.dateTime!,
        recordingFormat: extByFileName.containsKey(currMatch!.dateTime!)
            ? extByFileName[currMatch!.dateTime!]!
            : MP4);

    List<String> actions = await _getActionsForMatch();
    emit(SingleMatchLoadedState(currMatch!, actions, videoExt));
  }

  //region generating media
  FutureOr<void> _mapOnMediaTypeSelectedEvent(
      MediaTypeSelectedEvent event, Emitter<VideoGeneratorState> emit) async {
    mediaType = event.mediaType; //todo clean when close
    currMediaDir = [currMatchDir, event.mediaType].buildFilePath(); //todo clean when close
    if (currMatch != null) {
      switch (event.mediaType) {
        case VIOLENZA:
          currEvents = currMatch!.events.where((e) => e.type == EventType.BOTTE).toList();
          break;
        case PAPERE:
          currEvents = currMatch!.events.where((e) => e.type == EventType.PAPERE).toList();
          break;
        case AL_BARETTO:
          currEvents = currMatch!.events.where((e) => e.type == EventType.AL_BARETTO).toList();
          break;
        case FUNNY_MOMENTS_REGIA:
          currEvents = currMatch!.events.where((e) => e.type == EventType.LOL_REGIA).toList();
          break;
        case HIGHLIGHTS: //aggiungo durata degli header primo secondo tempo
          currEvents = currMatch!.events.where((e) => e.type == EventType.GOAL).toList();
          currEvents
              .addAll(currMatch!.events.where((e) => e.type == EventType.QUASI_GOAL).toList());
          choosenFakeMoments = currMatch!.events.where((e) => e.isFakeMoment).toList();
          Event? inizioPartita = currMatch!.events
              .toList()
              .firstOrNullWhere((e) => e.type == EventType.INIZIO_PARTITA);
          if (inizioPartita != null) {
            currEvents.add(inizioPartita);
          }
          Event? finePrimoTempo = currMatch!.events
              .toList()
              .firstOrNullWhere((e) => e.type == EventType.FINE_PRIMO_TEMPO);
          if (finePrimoTempo != null) {
            currEvents.add(finePrimoTempo);
          }
          currEvents.sort((a, b) => a.id.compareTo(b.id));
          break;
      }
      createOpenAndListenDir(currMediaDir);

      currEvents.removeWhere((e) {
        if (e.deleted) _removedEvents.add(e);
        return e.deleted;
      });

      _checkMissingVideoAndClipItIfNeeds(currMediaDir);

      emit(GeneratingMediaState(currEvents, currMatch!, videoExt, videoLength, removedVideos));
    }
  }

  FutureOr<void> _mapOnVideoChangeEvent(
      VideoChangeEvent event, Emitter<VideoGeneratorState> emit) async {
    emit(state.copy());
  }

  FutureOr<void> _mapOnClipTimeChangeEvent(
      ClipTimeChangeEvent event, Emitter<VideoGeneratorState> emit) async {
    int startClip = currEvents[event.position].startMillis;
    int endClip = currEvents[event.position].endMillis;
    if (_canChangeClipTime(event.startOrEnd, startClip, endClip, event.add)) {
      if (event.startOrEnd == START) {
        Duration start = Duration(milliseconds: currEvents[event.position].startMillis);
        event.add ? start += const Duration(seconds: 1) : start -= const Duration(seconds: 1);
        currEvents[event.position].startMillis = start.inMilliseconds;
        currEvents[event.position].startClip = start.toTimerValue();
      } else {
        Duration end = Duration(milliseconds: currEvents[event.position].endMillis);
        event.add ? end += const Duration(seconds: 1) : end -= const Duration(seconds: 1);
        currEvents[event.position].endMillis = end.inMilliseconds;
        currEvents[event.position].endClip = end.toTimerValue();
      }
      currEvents[event.position].status = EventStatus.NOT_EXIST;
      emit(state.copy());
    }
  }

  FutureOr<void> _mapOnReClipVideoEvent(
      ReClipVideoEvent event, Emitter<VideoGeneratorState> emit) async {
    _isReclip = true;
    Event e = currEvents[event.position];
    videoGeneratorRepository.saveEventSync(e);
    await _clipSingleVideo(e, state is GeneratingMediaState ? currMediaDir : currFakeMomentsDir);
    emit(state.copy());
  }

  FutureOr<void> _mapOnMarkVideoAsFavouriteEvent(
      MarkVideoAsFavouriteEvent event, Emitter<VideoGeneratorState> emit) async {
    switch (state.runtimeType) {
      case GeneratingMediaState:
        state as GeneratingMediaState;
        currEvents[event.position].isFavourite = !currEvents[event.position].isFavourite;
        videoGeneratorRepository.saveEventSync(currEvents[event.position]);
        emit(state.copy());
        break;
      case ChooseFakeMomentsEventsState:
        choosenFakeMoments ??= [];
        currEvents[event.position].isFavourite = !currEvents[event.position].isFavourite;
        choosenFakeMoments!.addOrRemove(currEvents[event.position]);
        videoGeneratorRepository.saveEventSync(currEvents[event.position]);
        emit(state.copy());
        break;
    }
  }

  FutureOr<void> _mapOnRemoveClipEvent(
      RemoveClipEvent event, Emitter<VideoGeneratorState> emit) async {
    Event e = currEvents[event.position]..deleted = true;
    videoGeneratorRepository.saveEventSync(currEvents[event.position]);
    _removedEvents.add(currEvents.removeAt(event.position));
    print('Removing video ${e.fileName()}$videoExt');
    await File([currMediaDir, e.fileName() + videoExt].buildFilePath()).deleteIfExist();
    emit(GeneratingMediaState(currEvents, currMatch!, videoExt, videoLength, removedVideos));
  }

  FutureOr<void> _mapOnOverflowMenuEvent(
      OverflowMenuEvent event, Emitter<VideoGeneratorState> emit) async {
    if (event.action != AGGIUNGI_AZIONE && state is GeneratingMediaState) {
      Event? e = _removedEvents.firstOrNullWhere((e) => e.fileName() == event.action);
      if (e != null) {
        e.deleted = false;
        _removedEvents.remove(e);
        currEvents.add(e);
        currEvents.sort((a, b) => a.id.compareTo(b.id));
        videoGeneratorRepository.saveEventSync(e);
        _clipSingleVideo(e, state is GeneratingMediaState ? currMediaDir : currFakeMomentsDir);
        emit(state.copy());
      } else {
        print('file non trovato');
      }
    }
    if (event.action != AGGIUNGI_AZIONE) {}
  }

  FutureOr<void> _mapOnVideoClickEvent(
      VideoClickEvent event, Emitter<VideoGeneratorState> emit) async {
    String videoPath;
    if (!event.isHighlights) {
      Event e = currEvents[event.position];
      print('mark current file ${e.fileName()}$videoExt as WATCHED');
      currEvents[event.position].status = EventStatus.WATCHED;
      videoGeneratorRepository.saveEventSync(e);
      String dir = _getVideoDirectory(
          e); /*e.evento != FINE_PRIMO_TEMPO
          ? currMediaDir
          : 'F:\\Users\\Teo\\Documents\\FakeFootball\\editing\\placeholders';*/
      videoPath = [dir, e.fileName() + videoExt].buildFilePath();
      print('opening video $videoPath');
      emit(state.copy());
    } else {
      videoPath = [currMediaDir, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt']
          .buildFilePath();
      finalResultViewed = true;
      emit(ShowHighlightsState(finalResultViewed));
    }
    Process.run('"F:\\Program\\VLC\\vlc.exe"', [videoPath]);
  }

  String _getVideoDirectory(Event e) {
    switch (state.runtimeType) {
      case GeneratingMediaState:
        return e.type != EventType.FINE_PRIMO_TEMPO
            ? currMediaDir
            : 'F:\\Users\\Teo\\Documents\\FakeFootball\\editing\\placeholders';
      case ChooseFakeMomentsEventsState:
        return [currMatchDir, e.type.enumName()].buildFilePath();
      default:
        return currMediaDir;
    }
  }

  FutureOr<void> _mapOnFakeMomentsCheckedEvent(
      FakeMomentsCheckedEvent event, Emitter<VideoGeneratorState> emit) async {
    choosenFakeMoments ??= [];
    currEvents[event.position].isFakeMoment = event.checked;
    videoGeneratorRepository.saveEventSync(currEvents[event.position]);
    event.checked
        ? choosenFakeMoments!.add(currEvents[event.position])
        : choosenFakeMoments!.remove(currEvents[event.position]);
    emit(state.copy());
  }

  bool _canChangeClipTime(String startOrEnd, int startClip, int endClip, bool add) {
    if (startOrEnd == START) {
      return add ? startClip + 1000 < endClip : startClip - 1000 > 0;
    } else {
      return !add ? endClip - 1000 > startClip : true;
    }
  }

  FutureOr<void> _mapOnHighlightsBuildedEvent(
      HighlightsBuildedEvent event, Emitter<VideoGeneratorState> emit) async {
    emit(ShowHighlightsState(finalResultViewed));
  }

  FutureOr<void> _mapOnFakeMomentsPickedEvent(
      FakeMomentsPickedEvent event, Emitter<VideoGeneratorState> emit) async {
    fakeMomentsCurrType = event.type;
    currHighlights = currEvents;
    currEvents = possibleFakeMoments![event.type]!;
    if (event.type != EventType.NONE) {
      currFakeMomentsDir = [currMatchDir, fakeMomentsCurrType.enumName()].buildFilePath();
      print('TE PREGO $currFakeMomentsDir');
      Directory currentMatchDir = Directory(currFakeMomentsDir);
      currentMatchDir.createIfNotExistsSync(recursive: true);
      Process.run('explorer', [currFakeMomentsDir]);
      currentMatchDir.watch(recursive: true).listen((event) async => _onDirChange(event));
      _checkMissingVideoAndClipItIfNeeds(currFakeMomentsDir);
    }
    emit(ChooseFakeMomentsEventsState(
        currEvents, fakeMomentsCurrType.getLabel(), currMatch!, videoExt, videoLength));
  }

  void createOpenAndListenDir(String dirPath) {
    Directory currentMatchDir = Directory(dirPath);
    currentMatchDir.createIfNotExistsSync(recursive: true);
    Process.run('explorer', [dirPath]);
    currDirListner?.cancel();

    currDirListner =
        currentMatchDir.watch(recursive: true).listen((event) async => _onDirChange(event));
  }

  void _onDirChange(FileSystemEvent event) {
    Event? eventToSave;
    switch (event.runtimeType) {
      case FileSystemCreateEvent:
        if (_isReclip) _fileSaveProcess++;
        break;
      case FileSystemModifyEvent:
        event as FileSystemModifyEvent;
        print('isReclip: $_isReclip fileProcess: $_fileSaveProcess');
        if (!_isFullHighlightsVideo(event.path)) {
          if (!_isReclip || _fileSaveProcess == 1) {
            _fileSaveProcess = 0;
            _isReclip = false;

            if (!event.isDirectory && !event.path.endsWith(BAT) && event.contentChanged) {
              int eventId =
                  int.parse(event.path.split('\\').last.split('.').first.split('_').first);
              eventToSave = currEvents.firstOrNullWhere((e) => e.id == eventId);
              if (eventToSave != null && eventToSave.status != EventStatus.WATCHED) {
                currEvents[currEvents.indexOf(eventToSave)].status = EventStatus.NOT_WATCHED;
              }
            }
          }
          if (_isReclip) _fileSaveProcess++;
        } else {
          add(HighlightsBuildedEvent());
        }
        break;
      case FileSystemDeleteEvent:
        if (!_isFullHighlightsVideo(event.path)) {
          if (!event.isDirectory && !event.path.endsWith(BAT)) {
            int eventId = int.parse(event.path.split('\\').last.split('.').first.split('_').first);
            eventToSave = currEvents.firstOrNullWhere((e) => e.id == eventId);
            if (eventToSave != null) {
              currEvents[currEvents.indexOf(eventToSave)].status = EventStatus.NOT_EXIST;
            }
          }
        }
        break;
    }
    if (eventToSave != null) videoGeneratorRepository.saveEventSync(eventToSave);
    print(event.toString());
    add(VideoChangeEvent());
  }

  FutureOr<void> _mapOnNextEvent(NextEvent event, Emitter<VideoGeneratorState> emit) async {
    switch (state.runtimeType) {
      case GeneratingMediaState:
        state as GeneratingMediaState;
        if (mediaType == HIGHLIGHTS) {
          if (possibleFakeMoments == null) {
            possibleFakeMoments = {};
            List<Event> papere =
                currMatch!.events.toList().where((e) => e.type == EventType.PAPERE).toList();
            if (papere.isNotEmpty) possibleFakeMoments![EventType.PAPERE] = papere;

            List<Event> baretto =
                currMatch!.events.toList().where((e) => e.type == EventType.AL_BARETTO).toList();
            if (baretto.isNotEmpty) possibleFakeMoments![EventType.AL_BARETTO] = baretto;

            List<Event> violenza =
                currMatch!.events.toList().where((e) => e.type == EventType.BOTTE).toList();
            if (violenza.isNotEmpty) possibleFakeMoments![EventType.BOTTE] = violenza;

            List<Event> lolRegia =
                currMatch!.events.toList().where((e) => e.type == EventType.LOL_REGIA).toList();
            if (lolRegia.isNotEmpty) possibleFakeMoments![EventType.LOL_REGIA] = lolRegia;

            List<Event> favourite = currEvents.where((e) => e.isFavourite).toList();
            if (favourite.isNotEmpty) possibleFakeMoments![EventType.NONE] = favourite;
          }
          if (!possibleFakeMoments.isNullOrEmpty()) {
            emit(ChooseFakeMomentsState(possibleFakeMoments!, currMatch!, videoExt, videoLength));
          } else {
            await _buildHighlights();
            emit(LoadPageState('Generazione ${mediaType.toLowerCase()} in corso...'));
          }
        } else {
          currEvents.forEach((e) => _moveFileIfIsFavouriteOrMoments(e, dir: currMediaDir));
          emit(CloseState());
        }
        break;
      case ChooseFakeMomentsState:
        await _buildHighlights();
        emit(LoadPageState('Generazione ${mediaType.toLowerCase()} in corso...'));
        break;
      case ChooseFakeMomentsEventsState:
        await _buildHighlights();
        emit(LoadPageState('Generazione ${mediaType.toLowerCase()} in corso...'));
        break;
      case ShowHighlightsState:
        currEvents.forEach((e) => _moveFileIfIsFavouriteOrMoments(e, dir: currMediaDir));
        choosenFakeMoments?.forEach((e) => _moveFileIfIsFavouriteOrMoments(e));
        String dirPath =
            ['F:\\Users\\Teo\\Documents\\FakeFootball\\editing', 'highlights'].buildFilePath();
        Directory(dirPath).createIfNotExistsSync(recursive: true);
        File([currMediaDir, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt']
                .buildFilePath())
            .moveFile([dirPath, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt']
                .buildFilePath());
        emit(CloseState());
        break;
    }
  }

  void _moveFileIfIsFavouriteOrMoments(Event e, {String? dir}) {
    if (e.isFavourite || e.isFakeMoment) {
      dir = dir ?? [currMatchDir, e.type.enumName()].buildFilePath();
      String filePosition = [dir, e.fileName() + videoExt].buildFilePath();
      print('$filePosition isFavourite');
      String dirPath = [
        'F:\\Users\\Teo\\Documents\\FakeFootball\\editing',
        e.type.enumName().toLowerCase()
      ].buildFilePath();
      Directory(dirPath).createIfNotExistsSync(recursive: true);
      String fileDest =
          [dirPath, '${currMatch!.dateTime!}_${e.fileName()}$videoExt'].buildFilePath();
      print('moving to $fileDest');
      File(filePosition).moveFile(fileDest);
    }
  }

  Future<void> _buildHighlights() async {
    File highLightsVideoTxt = File([
      currMatchDir,
      'scripts',
      '${HIGHLIGHTS_VIDEO_PREFIX}_${currMatch!.dateTime}$TXT'
    ].buildFilePath());

    await highLightsVideoTxt.create(recursive: true);
    String highlightsVideoContent = '';

    highlightsVideoContent +=
        '$FILE_K_W \'F:\\Users\\Teo\\Documents\\FakeFootball\\editing\\placeholders\\mimmo_primo.mp4\'\n';

    if (state is ChooseFakeMomentsEventsState) {
      currEvents = currHighlights;
    }
    currEvents.forEach((e) {
      String dir = e.type != EventType.FINE_PRIMO_TEMPO
          ? currMediaDir
          : 'F:\\Users\\Teo\\Documents\\FakeFootball\\editing\\placeholders';
      highlightsVideoContent += '$FILE_K_W \'${[dir, e.fileName() + videoExt].buildFilePath()}\'\n';
    });
    if (!choosenFakeMoments.isNullOrEmpty()) {
      highlightsVideoContent +=
          '$FILE_K_W \'F:\\Users\\Teo\\Documents\\FakeFootball\\editing\\placeholders\\mimmo_moments.mp4\'\n';

      choosenFakeMoments!.forEach((e) {
        String subDir = e.type != EventType.QUASI_GOAL && e.type != EventType.GOAL
            ? e.type.enumName()
            : HIGHLIGHTS;
        String dir = [currMatchDir, subDir].buildFilePath();
        highlightsVideoContent +=
            '$FILE_K_W \'${[dir, e.fileName() + videoExt].buildFilePath()}\'\n';
      });
    }
    await highLightsVideoTxt.writeAsString(highlightsVideoContent);
    await File([currMediaDir, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt']
            .buildFilePath())
        .deleteIfExist();
    ffmpegInteractor.clipVideosIntoOne(
      txtVideoPath: highLightsVideoTxt.path,
      outputPath: [currMediaDir, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt']
          .buildFilePath(),
      stdInOut: (line) {
        int? cmdTimeMillis = _getTimeFromCmd(line);
        if (cmdTimeMillis != null) add(LoadProgressEvent(cmdTimeMillis));
        print('stdout: ${line.toString().trim()}');
      },
      onComplete: (code) {
        if (code != 0) add(ErrorEvent('Errore nella generazione degli highlights'));
      },
    );
    /* await _writeAndRunBat(
          batContent: highlightsBatContent,
          batName: '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$BAT');

      ffmpegInteractor.clipVideosIntoOne(
        txtVideoPath: highLightsVideoTxt.path,
        outputPath: [currMediaDir, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt']
            .buildFilePath(),
        stdInOut: (line) {
          int? cmdTimeMillis = _getTimeFromCmd(line);
          if (cmdTimeMillis != null) add(LoadProgressEvent(cmdTimeMillis));
          print('stdout: ${line.toString().trim()}');
        },
        onComplete: (value) {
          if (value != 0) add(ErrorEvent('Errore nella generazione degli highlights'));
        },
      );*/
    /*final process = await Process.start(
          FfmpegUtils.clipVideoIntoOneSync(
              highLightsVideoTxt.path,
              [currMediaDir, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt']
                  .buildFilePath())
            ..printOutMsg('Executing command:\n'),
          []);
      _stdOut = process.stdout.transform(utf8.decoder).listen((event) {
        int? cmdTimeMillis = _getTimeFromCmd(event);
        if (cmdTimeMillis != null) add(LoadProgressEvent(cmdTimeMillis));
        print('stdout: ${event.toString().trim()}');
      });
      _stdErr = process.stderr.transform(utf8.decoder).listen((event) {
        int? cmdTimeMillis = _getTimeFromCmd(event);
        if (cmdTimeMillis != null) add(LoadProgressEvent(cmdTimeMillis));
        print('stderr: ${event.toString().trim()}');
      });
      process.exitCode.then((value) {
        print('exit code: $value');
        _stdErr?.cancel();
        _stdOut?.cancel();
        _stdOut = null;
        _stdErr = null;
        if (value != 0) add(ErrorEvent('Errore nella generazione degli highlights'));
      });*/
    //print('highlights ffmpeg command $highlightsBatContent');

    /*await _writeAndRunBat(
          batContent: highlightsBatContent,
          batName: '${HIGHLIGHTS_VIDEO_PREFIX}_${currMatch!.dateTime}$BAT',
          watch: true);*/
  }

  void _checkMissingVideoAndClipItIfNeeds(String dir) {
    List<Event> eventsToClip = currEvents.where((e) {
      if (!File([dir, e.fileName() + videoExt].buildFilePath()).existsSync() &&
          !e.isPlaceHolder()) {
        e.status = EventStatus.NOT_EXIST;
        return true;
      }
      return false;
    }).toList();
    if (eventsToClip.isNotEmpty) {
      videoGeneratorRepository.updateMatchesSync(currEvents);
      ffmpegInteractor.clipEventList(
          eventList: eventsToClip,
          fullVideoPath: fullVideoPath,
          dirPath: dir,
          stdInOut: (event) => print(event.toString().trim()));
    }
  }

  Future<List<String>> _getActionsForMatch() async {
    List<String> actions = [HIGHLIGHTS];
    if (currMatch!.events.isEmpty) {
      await currMatch!.events.load(overrideChanges: true);
    }
    if (currMatch!.events.where((element) => element.type == EventType.BOTTE).isNotEmpty) {
      actions.add(VIOLENZA);
    }
    if (currMatch!.events.where((element) => element.type == EventType.PAPERE).isNotEmpty) {
      actions.add(PAPERE);
    }
    if (currMatch!.events.where((element) => element.type == EventType.AL_BARETTO).isNotEmpty) {
      actions.add(AL_BARETTO);
    }
    if (currMatch!.events.where((element) => element.type == EventType.LOL_REGIA).isNotEmpty) {
      actions.add(FUNNY_MOMENTS_REGIA);
    }
    return actions;
  }

  /*Future<void> _writeRunButAndWait(
      {required Function(int) onComplete,
      required String batContent,
      required String batName}) async {
    String scriptPath = [currMatchDir, 'scripts'].buildFilePath();
    Directory(scriptPath).createIfNotExistsSync(recursive: true);
    String batEventFileName = [scriptPath, batName].buildFilePath();
    File batEventi = File(batEventFileName);
    await batEventi.writeAsString(batContent);
    final process = await Process.start(batEventFileName, []);
    int exitCode = await process.exitCode;
    onComplete.call(exitCode);
  }

  Future<void> _writeAndRunBat(
      {required String batContent, required String batName, bool loading = false}) async {
    String scriptPath = [currMatchDir, 'scripts'].buildFilePath();
    Directory(scriptPath).createIfNotExistsSync(recursive: true);
    String batEventFileName = [scriptPath, batName].buildFilePath();
    File batEventi = File(batEventFileName);
    await batEventi.writeAsString(batContent);
    print('running $batEventFileName');
    final process = await Process.start(batEventFileName, []);
    _stdOut = process.stdout.transform(utf8.decoder).listen((event) {
      if (loading) {
        int? cmdTimeMillis = _getTimeFromCmd(event);
        if (cmdTimeMillis != null) add(LoadProgressEvent(cmdTimeMillis));
      }
      print('stdout: ${event.toString().trim()}');
    });
    _stdErr = process.stderr.transform(utf8.decoder).listen((event) {
      if (loading) {
        int? cmdTimeMillis = _getTimeFromCmd(event);
        if (cmdTimeMillis != null) add(LoadProgressEvent(cmdTimeMillis));
      }
      print('stderr: ${event.toString().trim()}');
    });
    process.exitCode.then((value) {
      print('exit code: $value');
      _stdErr?.cancel();
      _stdOut?.cancel();
      _stdOut = null;
      _stdErr = null;
      if (value != 0) add(ErrorEvent('Errore nella generazione degli highlights'));
    });
  }*/

  int? _getTimeFromCmd(String cmd) {
    String? time = _timeRegex.firstMatch(cmd)?.group(0);
    if (!time.isNullOrEmpty()) {
      var split = time!.split(':');
      String hour = split.first;
      String minutes = split[1];
      String seconds = split.last;
      return Duration(
              hours: int.parse(hour), minutes: int.parse(minutes), seconds: int.parse(seconds))
          .inMilliseconds;
    }
    return null;
  }

  Future<void> _clipSingleVideo(Event e, String savingDir) async {
    print('Reclipping video from ${e.startClip} to ${e.endClip} at path: $savingDir');
    ffmpegInteractor.clipSingleVideo(
        event: e,
        fullVideoPath: fullVideoPath,
        dirPath: savingDir,
        stdInOut: (line) => print(line.toString().trim()));
    /*String singleClip = FfmpegInteractor.clipSingleVideoWithRender(
        e: e, fullVideoPath: fullVideoPath, dirPath: savingDir, fileFormat: videoExt);
    await _writeAndRunBat(batName: '${e.fileName().toLowerCase()}$BAT', batContent: singleClip);*/
  }

  bool _isFullHighlightsVideo(String path) =>
      [currMediaDir, '${HIGHLIGHTS_VIDEO_PREFIX}${currMatch!.dateTime}$videoExt'].buildFilePath() ==
      path;
}
