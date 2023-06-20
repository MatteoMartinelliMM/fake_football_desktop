// ignore_for_file: prefer_for_elements_to_map_fromiterable, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:fake_football_desktop/bloc/build_content/build_content_event.dart';
import 'package:fake_football_desktop/bloc/build_content/build_content_state.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/model/view_model/build_line_up_element.dart';
import 'package:fake_football_desktop/repository/convocations_repository.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:fake_football_desktop/bloc/build_content/build_content_event.dart';
import 'package:fake_football_desktop/bloc/build_content/build_content_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants.dart';

class BuildContentBloc extends Bloc<BuildGameContentEvent, BuildGameContentState> {
  ConvocationsRepository convocationsRepository;
  late List<Player> gialli, verdi;
  late List<Player> gialliRookies, verdiRookies;
  late Map<Player, bool> dontHaveCardsGialli, dontHaveCardsVerdi;
  late List<String> moduli;
  bool _openCards = false, _openModuli = false;
  late String _rootDirPath;
  String? moduloGialli, moduloVerdi;
  String? moduloTeam;
  bool _isOfficialMatch = false;
  Map<Player, List<Player>>? lineUpsGialli, lineUpsVerdi;

  BuildContentBloc({required this.convocationsRepository}) : super(LoadingContentState()) {
    on<LoadPageEvent>(_mapOnLoadPageEvent);
    on<ChooseModuloEvent>(_mapOnChooseModuloEvent);
    on<BuildContentDisposeEvent>(_mapOnBuildContentDisposeEvent);
    on<RefreshEvent>(_mapOnRefreshEvent);
    on<NextEvent>(_mapOnNextEvent);
  }

  FutureOr<void> _mapOnLoadPageEvent(
      LoadPageEvent event, Emitter<BuildGameContentState> emit) async {
    emit(LoadingContentState());
    List<List<Player>> squads = await convocationsRepository.getConvocati();
    List<String?> moduliSaved = await convocationsRepository.getSavedModuli();
    moduli = await convocationsRepository.getModuli();
    if (squads.first == squads.last) {
      _isOfficialMatch = true;
      moduloTeam = moduliSaved.first;
      gialli = squads.first;
      verdi = [];
    } else {
      gialli = squads.first;
      verdi = squads.last;
      moduloGialli = moduliSaved.first;
      moduloVerdi = moduliSaved.last;
    }
    if (!_isOfficialMatch) {
      if (moduloGialli.isNullOrEmpty() || moduloVerdi.isNullOrEmpty()) {
        await createNewPartitaDirectoryIfNotExists();
        LoadModuliAndConvocations state = LoadModuliAndConvocations();
        state.moduli = moduli;
        state.playersGialli = gialli.map((e) => e.distinta).toList().join(" ");
        state.playersVerdi = verdi.map((e) => e.distinta).toList().join(" ");
        state.moduloGialli = moduloGialli;
        state.moduloVerdi = moduloVerdi;
        emit(state);
      } else {
        BuildGameContentState b = await _analizeContentProgress();
        emit(b);
      }
    } else {
      if (moduloTeam.isNullOrEmpty()) {
        emit(LoadModuliAndConvocationsSingleTeam(moduli,
            gialli.map((e) => e.distinta).toList().join(" "), moduloTeam, gialli.first.isYellow));
      } else {
        BuildGameContentState b = await _analizeContentProgress();
        emit(b);
      }
    }
  }

  Future<void> createNewPartitaDirectoryIfNotExists() async {
    _rootDirPath = PathProvider.rootDirPath();
    await PathProvider.getDirFromPath([FOLDER_NEW_PARTITA]).createIfNotExists(recursive: true);
    /*if (!await Directory(_newPartitaDirPath).exists()) {
      await Directory('$_rootDirPath$FOLDER_NEW_PARTITA').create();
    }*/
  }

  String getSpinnerLabel(bool isYellow) => isYellow ? GIALLI : VERDI;

  Color getSpinnerLabelColor(bool isYellow) => isYellow ? Colors.yellow : Colors.green.shade500;

  Future<FutureOr<void>> _mapOnNextEvent(
      NextEvent event, Emitter<BuildGameContentState> emit) async {
    if (state is! BuildCardState) {
      PathProvider.getDirFromPath([FOLDER_PARTITA, FOLDER_FORMAZIONI])
          .deleteIfExistSync(recurisive: true);
      await PathProvider.getDirFromPath([FOLDER_PARTITA]).createIfNotExists(recursive: true);
      await PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI])
          .rename(PathProvider.getDirFromPath([FOLDER_PARTITA, FOLDER_FORMAZIONI]).path);
      PathProvider.getDirFromPath([FOLDER_NEW_PARTITA]).deleteFilesByExtension(CSV);
      convocationsRepository.markContentAsDone();
      emit(ThinsDoneState());
    } else {
      BuildLineUpState buildLineUpState = await _onBuildLineUpPhase();
      emit(buildLineUpState);
    }
  }

  Future<FutureOr<void>> _mapOnRefreshEvent(
      RefreshEvent event, Emitter<BuildGameContentState> emit) async {
    if (state is BuildCardState) {
      List<FileSystemEntity> filesAndSubDirsGiocatori =
          await PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_CARTE_MANCANTI])
              .list()
              .toList();

      List<File> filesGiocatori = filesAndSubDirsGiocatori.whereType<File>().toList();

      List<FileSystemEntity> filesAndSubPortireri =
          await PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_CARTE_MANCANTI, FOLDER_GK])
              .list()
              .toList();

      List<File> filesPortieri = filesAndSubPortireri.whereType<File>().toList();
      if (filesGiocatori.isNotEmpty) {
        List<File> portieriToMove =
            filesGiocatori.where((f) => f.path.contains(CARD_PORTIERE)).toList();
        if (!portieriToMove.isNotEmpty) {
          moveCardsFromTempToRoaster(filesGiocatori);
        } else {
          portieriToMove.forEach((f) => f.moveFile(PathProvider.getCompletePath([
                FOLDER_NEW_PARTITA,
                FOLDER_CARTE_MANCANTI,
                FOLDER_GK,
                f.path.split(Platform.isWindows ? r'\' : '/').last
              ])));
        }
      }
      if (filesPortieri.isNotEmpty) {
        moveCardsFromTempToRoaster(filesPortieri);
      }
      if (dontHaveCardsGialli.isNotEmpty) {
        Map<Player, bool> temp = {};
        dontHaveCardsGialli.forEach((p, value) {
          temp[p] = _checkIfCardExists(p);
        });
        dontHaveCardsGialli = temp;
      }
      if (dontHaveCardsVerdi.isNotEmpty) {
        Map<Player, bool> temp = {};
        dontHaveCardsVerdi.forEach((p, value) {
          temp[p] = _checkIfCardExists(p);
        });
        dontHaveCardsVerdi = temp;
      }
      bool thingsDone = checkIfCardsAreBuilded();
      if (thingsDone) {
        PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_CARTE_MANCANTI])
            .delete(recursive: true);
        await PathProvider.getFileFromPath([FOLDER_NEW_PARTITA, CARTE_GIALLE_CSV]).deleteIfExist();
        await PathProvider.getFileFromPath([FOLDER_NEW_PARTITA, CARTE_VERDI_CSV]).deleteIfExist();
        PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI])
            .createIfNotExistsSync(recursive: true);
      }
      emit(BuildCardState(dontHaveCardsGialli, dontHaveCardsVerdi, checkIfCardsAreBuilded()));
    } else {
      List<FileSystemEntity> filesAndSubDirsGiocatori =
          await PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI])
              .list()
              .toList();

      List<File> filesGiocatori = filesAndSubDirsGiocatori.whereType<File>().toList();
      if (filesGiocatori.isNotEmpty) {
        List<File> psdFiles = filesGiocatori.getFilesFromExtension(PSD);
        List<File> pngFiles = filesGiocatori.getFilesFromExtension(PNG);
        if (psdFiles.isNotEmpty && pngFiles.isNotEmpty) {
          psdFiles.forEach((f) => f.deleteSync());
        }

        if (pngFiles.isNotEmpty) {
          pngFiles.forEach((f) async =>
              await f.moveFile(PathProvider.getCompletePath([f.fromTempToFormazioniFolder()])));
        }
      }
      List<BuildLineUpObject> gialliLineUp = [];
      lineUpsGialli?.forEach((keeper, others) => gialliLineUp.add(BuildLineUpObject(
            keeper,
            others,
            PathProvider.checkIfTempFormazioneExist(keeper),
          )));
      List<BuildLineUpObject> verdiLineUp = [];
      lineUpsVerdi?.forEach((keeper, others) => verdiLineUp.add(BuildLineUpObject(
            keeper,
            others,
            PathProvider.checkIfTempFormazioneExist(keeper),
          )));
      emit(BuildLineUpState(
          gialliLineUp, verdiLineUp, checkIfFormazioniAreBuilded(gialliLineUp, verdiLineUp)));
    }
  }

  bool checkIfFormazioniAreBuilded(
          List<BuildLineUpObject> gialliLineUp, List<BuildLineUpObject> verdiLineUp) =>
      gialliLineUp.where((p) => !p.esito).isEmpty && verdiLineUp.where((p) => !p.esito).isEmpty;

  void moveCardsFromTempToRoaster(List<File> filesGiocatori) {
    List<File> psdFiles = filesGiocatori.getFilesFromExtension(PSD);
    List<File> pngFiles = filesGiocatori.getFilesFromExtension(PNG);

    if (psdFiles.isNotEmpty && pngFiles.isNotEmpty) {
      psdFiles.forEach((f) => f.deleteSync());
    }

    if (pngFiles.isNotEmpty) {
      pngFiles.forEach((f) async {
        await PathProvider.playerDirFromTempFile(f.path).createIfNotExists(recursive: true);
        await f.moveFile(PathProvider.playerFilePathFromTempFile(f.path));
      });
    }
  }

  Future<FutureOr<void>> _mapOnBuildContentDisposeEvent(
      BuildContentDisposeEvent event, Emitter<BuildGameContentState> emit) async {
    gialli = [];
    verdi = [];
    gialliRookies = [];
    verdiRookies = [];
    dontHaveCardsGialli = {};
    dontHaveCardsVerdi = {};
    moduli = [];
    moduloGialli = null;
    moduloVerdi = null;
    lineUpsGialli = null;
    lineUpsVerdi = null;
    _openCards = false;
    _openModuli = false;
  }

  Future<FutureOr<void>> _mapOnChooseModuloEvent(
      ChooseModuloEvent event, Emitter<BuildGameContentState> emit) async {
    event.isYellow ? moduloGialli = event.modulo : moduloVerdi = event.modulo;
    if (moduloGialli.isNullOrEmpty() || moduloVerdi.isNullOrEmpty()) {
      BuildGameContentState state;
      state = LoadModuliAndConvocations();
      state as LoadModuliAndConvocations;
      state.moduli = moduli;
      state.playersGialli = gialli.map((e) => e.distinta).toList().join(" ");
      state.playersVerdi = verdi.map((e) => e.distinta).toList().join(" ");
      state.moduloGialli = moduloGialli;
      state.moduloVerdi = moduloVerdi;
      emit(state);
    } else {
      emit(LoadingContentState());
      convocationsRepository.saveModuli(moduloGialli!, moduloVerdi!);
      BuildGameContentState b = await _analizeContentProgress();
      emit(b);
    }
  }

  FutureOr<void> checkWithContentHaveToBeCreated(
      LoadPageEvent event, Emitter<BuildGameContentState> emit) async {}

  bool haveRookies(List<Player> gialliRookies, List<Player> verdiRookies, Player? keeperGialli,
      Player? keeperVerdi) {
    return gialliRookies.isNotEmpty ||
        verdiRookies.isNotEmpty ||
        keeperGialli != null ||
        keeperVerdi != null;
  }

  String? spinnerValue(bool isYellow, String modulo) =>
      isYellow ? moduloGialli ?? modulo : moduloVerdi ?? modulo;

  String getStatus(bool result) => result ? CHECK_EMOJ : ERROR_EMOJ;

  bool haveToBuildRookiesCards(
          Map<String, bool> haveFilesByRookieGialli, Map<String, bool> haveFilesByRookieVerdi) =>
      haveFilesByRookieVerdi.values.where((b) => b == false).toList().isNotEmpty ||
      haveFilesByRookieGialli.values.where((b) => b == false).toList().isNotEmpty;

  Future<BuildGameContentState> _analizeContentProgress() async {
    await createNewPartitaDirectoryIfNotExists();
    dontHaveCardsGialli = {};
    dontHaveCardsVerdi = {};
    dontHaveCardsGialli = checkIfExistPlayerCardsAndDirectory(true);
    dontHaveCardsVerdi = checkIfExistPlayerCardsAndDirectory(false);
    if (dontHaveCardsGialli.isNotEmpty || dontHaveCardsVerdi.isNotEmpty) {
      //so già che ho dei rookie
      List<List<dynamic>> listGialliRookies = [CARD_HEADER], listVerdiRookies = [CARD_HEADER];
      dontHaveCardsGialli.forEach((p, exist) {
        if (!exist) {
          listGialliRookies.add([
            '${p.cardFormazioneWithoutExt}_${p.dirName}',
            p.name.toUpperCase(),
            p.number.toString()
          ]);
          listGialliRookies.add([
            '${p.cardPortiereWithoutExt}_${p.dirName}',
            p.name.toUpperCase(),
            p.number.toString()
          ]);
        }
      });
      dontHaveCardsVerdi.forEach((p, exist) {
        if (!exist) {
          listVerdiRookies.add([
            '${p.cardFormazioneWithoutExt}_${p.dirName}',
            p.name.toUpperCase(),
            p.number.toString()
          ]);
          listVerdiRookies.add([
            '${p.cardPortiereWithoutExt}_${p.dirName}',
            p.name.toUpperCase(),
            p.number.toString()
          ]);
        }
      });
      String csvGialliRookies = const ListToCsvConverter().convert(listGialliRookies);
      String csvVerdiRookies = const ListToCsvConverter().convert(listVerdiRookies);

      final File rookieGialli =
          PathProvider.getFileFromPath([FOLDER_NEW_PARTITA, CARTE_GIALLE_CSV]);
      final File rookieVerdi = PathProvider.getFileFromPath([FOLDER_NEW_PARTITA, CARTE_VERDI_CSV]);

      PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_CARTE_MANCANTI])
          .createIfNotExistsSync(recursive: true);
      PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_CARTE_MANCANTI, FOLDER_GK])
          .createIfNotExistsSync(recursive: true);

      await rookieGialli.writeAsString(csvGialliRookies);
      await rookieVerdi.writeAsString(csvVerdiRookies);
      await Clipboard.setData(ClipboardData(
          text: PathProvider.getCompletePath([FOLDER_NEW_PARTITA, FOLDER_CARTE_MANCANTI])));
      PathProvider.getCompletePath([ROOKIE_GIALLO_PSD]);
      if (!_openCards) {
        List<String> psdFilesToOpen = [];
        if (listGialliRookies.length > 1) {
          psdFilesToOpen.add('"${PathProvider.getCompletePath([ROOKIE_GIALLO_PSD])}"');
        }
        if (listVerdiRookies.length > 1) {
          psdFilesToOpen.add('"${PathProvider.getCompletePath([ROOKIE_VERDE_PSD])}"');
        }
        _openPhotoshop(psdFilesToOpen);
        _openCards = true;
      }
      return BuildCardState(dontHaveCardsGialli, dontHaveCardsVerdi, checkIfCardsAreBuilded());
    }
    return await _onBuildLineUpPhase();
  }

  void _openPhotoshop(List<String> fileList) {
    Process.run(
      '"${PathProvider.photoshopExePath()}"',
      ['-open']..addAll(fileList),
    );
  }

  Future<BuildLineUpState> _onBuildLineUpPhase() async {
    PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI])
        .createIfNotExistsSync(recursive: true);
    lineUpsGialli ??= _buildLineups(gialli);
    lineUpsVerdi ??= _buildLineups(verdi);
    List<BuildLineUpObject> gialliLineUp = [];
    lineUpsGialli?.keys.forEach((k) {
      Map<String, List<Player>> sortPlayersByLineUp = lineUpsGialli![k]!.sortPlayersByLineUp(moduloGialli!, false);
      List<Player> orderedList = [];
      ORDERED_FIELDS_ZONE.forEach((k) => orderedList.addAll(sortPlayersByLineUp[k]!));
      lineUpsGialli![k] = orderedList;
    });
    lineUpsVerdi?.keys.forEach((k) {
      Map<String, List<Player>> sortPlayersByLineUp = lineUpsVerdi![k]!.sortPlayersByLineUp(moduloVerdi!, false);
      List<Player> orderedList = [];
      ORDERED_FIELDS_ZONE.forEach((k) => orderedList.addAll(sortPlayersByLineUp[k]!));
      lineUpsVerdi![k] = orderedList;
    });
    lineUpsGialli?.forEach((keeper, others) =>
        gialliLineUp.add(BuildLineUpObject(keeper, others, false)));
    List<BuildLineUpObject> verdiLineUp = [];
    lineUpsVerdi?.forEach((keeper, others) =>
        verdiLineUp.add(BuildLineUpObject(keeper, others, false)));
    List<List<dynamic>> listGialli = [getLineUpHeaderByModulo(moduloGialli)],
        listVerdi = [getLineUpHeaderByModulo(moduloVerdi)];
    PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI])
        .createIfNotExistsSync(recursive: true);
    String formazioneGialli = '', formazioneVerdi = '';
    lineUpsGialli!.keys.forEach((k) {
      List<dynamic> rowElement = [];
      formazioneGialli += '${k.cambioLabel}|';
      PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI, k.dirNameFormazioni])
          .createIfNotExistsSync(recursive: true);
      rowElement.add('1_${k.dirNameFormazioni}');
      rowElement.add(PathProvider.getCardPortiere(k).path);
      lineUpsGialli![k]!.forEach((p) => rowElement.add(PathProvider.getCardFormazione(p).path));
      listGialli.add(rowElement);
    });

    lineUpsVerdi!.keys.forEach((k) {
      List<dynamic> rowElement = [];
      formazioneVerdi += '${k.cambioLabel}|';
      PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI, k.dirNameFormazioni])
          .createIfNotExistsSync(recursive: true);
      rowElement.add('2_${k.dirNameFormazioni}');
      rowElement.add(PathProvider.getCardPortiere(k).path);
      lineUpsVerdi![k]!.forEach((p) => rowElement.add(PathProvider.getCardFormazione(p).path));
      listVerdi.add(rowElement);
    });
    PathProvider.getDirFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI, CURRENT_FOLDER])
        .createIfNotExistsSync(recursive: true);

    String csvFormazioneGialli = const ListToCsvConverter().convert(listGialli);
    String csvFormazioneVerdi = const ListToCsvConverter().convert(listVerdi);

    await PathProvider.getFileFromPath([FOLDER_NEW_PARTITA, moduloGialli! + GIALLI_CSV])
        .writeAsString(csvFormazioneGialli);
    await PathProvider.getFileFromPath([FOLDER_NEW_PARTITA, moduloVerdi! + VERDI_CSV])
        .writeAsString(csvFormazioneVerdi);
    await PathProvider.getFileFromPath([FORMAZIONE_GIALLI_AHK])
        .writeAsString(formazioneGialli.substring(0, formazioneGialli.length - 1));
    await PathProvider.getFileFromPath([FORMAZIONE_VERDI_AHK])
        .writeAsString(formazioneVerdi.substring(0, formazioneVerdi.length - 1));

    await Clipboard.setData(
        ClipboardData(text: PathProvider.getCompletePath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI])));

    if (!_openModuli) {
      _openPhotoshop([
        PathProvider.getFormazioniPsdFile(moduloGialli!, true),
        PathProvider.getFormazioniPsdFile(moduloVerdi!, false)
      ]);
      _openModuli = true;
    }
    return BuildLineUpState(gialliLineUp, verdiLineUp, false);
  }

  bool checkIfCardsAreBuilded() =>
      !dontHaveCardsGialli.values.contains(false) && !dontHaveCardsVerdi.values.contains(false);

  Map<Player, List<Player>> _buildLineups(List<Player> players) => Map.fromIterable(
        players,
        key: (p) => p,
        value: (p) => players.where((p1) => p1 != p).toList(),
      );

  List<String> getLineUpHeaderByModulo(String? moduloGialli) {
    if (!moduloGialli.isNullOrEmpty()) {
      switch (moduloGialli) {
        case M_1_4_1:
          return LINE_UP_HEADER_1_4_1;
        case M_2_3_1:
          return LINE_UP_HEADER_2_3_1;
        case M_3_2_1:
          return LINE_UP_HEADER_3_2_1;
        case M_3_2_1_2:
          return LINE_UP_HEADER_3_2_1_2;
      }
    }
    return [];
  }

  Map<Player, bool> checkIfExistPlayerCardsAndDirectory(bool isYellow) {
    Map<Player, bool> map = {};
    if (isYellow) {
      gialli.forEach((r) => _checkExistingFolderAndCard(r, map));
    } else {
      verdi.forEach((r) => _checkExistingFolderAndCard(r, map));
    }
    return map;
  }

  void _checkExistingFolderAndCard(Player r, Map<Player, bool> map) {
    PathProvider.getPlayerDir(r);
    bool existsCard = _checkIfCardExists(r);
    if (!existsCard) {
      map[r] = existsCard;
    }
  }

  bool _checkIfCardExists(Player p) =>
      PathProvider.getCardFormazione(p).existsSync() &&
      PathProvider.getCardPortiere(p).existsSync();
}
