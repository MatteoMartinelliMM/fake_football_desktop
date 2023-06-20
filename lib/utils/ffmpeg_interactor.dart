import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:fake_football_desktop/utils/ffmpeg_constants.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';

class FfmpegInteractor {
  late String fileFormat;
  late String currWorkingDir;
  late int videoWidth;
  late int videoHeight;

  bool? needRender;

  void getRecordingInfo({required String recordingName, required String recordingFormat}) {
    fileFormat = recordingFormat;
    //TODO REPLACE CON FFDIRMANAGER
    currWorkingDir = PathProvider.getCompletePath([VIDEO, recordingName]);
    String filePath = PathProvider.getCompletePath([VIDEO, recordingName + fileFormat]);
    printCommand('executing $FFPROBE', '$_ffprobeJsonMetadata"$filePath"');
    Process.run('$_ffprobeJsonMetadata"$filePath"', []).then((result) {
      if (result.exitCode == 0) {
        needRender = false;
        final jsonData = jsonDecode(result.stdout);
        final streams = jsonData['streams'];

        // Check audio stream
        final audioStream =
            streams.firstWhere((stream) => stream['codec_type'] == 'audio', orElse: () => null);
        needRender = audioStream == null || needRender!;
        if (audioStream != null) {
          final String audioCodec = audioStream['codec_name'];
          final String audioBitRate = audioStream['bit_rate'];
          needRender = needRender! ||
              audioCodec != 'aac' ||
              (!audioBitRate.startsWith('19') || audioBitRate.length != 6);
          if (!needRender!) {
            print('Audio codec and bitrate match the desired values.');
          } else {
            print('Audio codec or bitrate does not match the desired values.');
          }
        } else {
          print('No audio stream found.');
        }
        // Check video stream
        final videoStream =
            streams.firstWhere((stream) => stream['codec_type'] == 'video', orElse: () => null);
        needRender = videoStream == null || needRender!;
        if (videoStream != null) {
          final String videoCodec = videoStream['codec_name'];
          final String videoBitRate = videoStream['bit_rate'];
          videoWidth = videoStream['width'];
          videoHeight = videoStream['height'];
          needRender = needRender! ||
              videoCodec != 'h264' ||
              (!videoBitRate.startsWith('50') || videoBitRate.length != 7) ||
              videoWidth != 1920 ||
              videoHeight != 1080;
          print('${videoWidth}x$videoHeight');
          if (!needRender!) {
            print('Video codec and bitrate match the desired values.');
          } else {
            print('Video codec or bitrate does not match the desired values.');
          }
        } else {
          videoHeight = 0;
          videoWidth = 0;
          print('No video stream found.');
        }
      } else {
        print('Error running FFprobe: ${result.stderr}');
        videoHeight = 0;
        videoWidth = 0;
        needRender = true;
      }
    });
  }

  Future<void>? clipSingleVideo({
    required Event event,
    required String fullVideoPath,
    required String dirPath,
    Function(int)? onComplete,
    Function(String)? stdInOut,
  }) {
    if (needRender != null) {
      String task =
          _getClippingFfmpegCommand(event: event, fullVideoPath: fullVideoPath, dirPath: dirPath);
      printCommand('executing $FFMPEG', task);
      return _writeAndRunBat(
          batContent: task,
          batName: '${event.fileName()}$BAT',
          onComplete: onComplete,
          stdInOut: stdInOut);
    } else {
      print('unexpected not knowing video info');
    }
    return null;
  }

  void printCommand(String command, String task) =>
      print('===== ===== ===== ===== $command ===== ===== ===== =====\n$task');

  Future<void>? clipEventList({
    required List<Event> eventList,
    required String fullVideoPath,
    required String dirPath,
    Function(int)? onComplete,
    Function(String)? stdInOut,
  }) {
    if (needRender != null) {
      String scriptEventi = '';
      eventList.forEach(
        (e) => scriptEventi +=
            _getClippingFfmpegCommand(event: e, fullVideoPath: fullVideoPath, dirPath: dirPath),
      );
      return _writeAndRunBat(
          batContent: scriptEventi,
          batName: 'clipEventList$BAT',
          onComplete: onComplete,
          stdInOut: stdInOut);
    }
    return null;
  }

  String _getClippingFfmpegCommand(
      {required Event event, required String fullVideoPath, required String dirPath}) {
    return '$FFMPEG -$OVERWRITE_Y  -$INPUT_VIDEO "$fullVideoPath$fileFormat" -$SS ${event.startClip} '
        '-$TO ${event.endClip} -$C $COPY ${needRender! ? DEFAULT_VIDEO_ENCODING : ''} $RESET_TS -$MAP 0 "$dirPath\\${event.fileName()}$fileFormat"\n';
  }

  Future<void> _writeAndRunBat({
    required String batContent,
    required String batName,
    Function(int)? onComplete,
    Function(String)? stdInOut,
  }) async {
    String scriptPath = [currWorkingDir, 'scripts'].buildFilePath();
    Directory(scriptPath).createIfNotExistsSync(recursive: true);
    String batEventFileName = [scriptPath, batName].buildFilePath();
    File batEventi = File(batEventFileName);
    await batEventi.writeAsString(batContent);
    print('running $batEventFileName');
    final process = await Process.start(batEventFileName, []);

    StreamSubscription<String>? stdOutSub, stdErrSub;

    if (stdInOut != null) {
      stdOutSub = process.stdout.transform(utf8.decoder).listen((event) => stdInOut.call(event));
      stdErrSub = process.stderr.transform(utf8.decoder).listen((event) => stdInOut.call(event));
    }

    process.exitCode.then(
      (value) {
        stdOutSub?.cancel();
        stdErrSub?.cancel();
        batEventi.deleteIfExist();
        onComplete?.call(value);
      },
    );
  }

  Future<void> clipVideosIntoOne({
    required String txtVideoPath,
    required String outputPath,
    Function(int)? onComplete,
    Function(String)? stdInOut,
  }) {
    String task =
        '$FFMPEG -$OVERWRITE_Y -$F $CONCAT -$SAFE $FALSE_FFM -$INPUT_VIDEO "$txtVideoPath" -$C $COPY "$outputPath"';
    printCommand('executing $FFMPEG', task);
    return _writeAndRunBat(
        batContent: task, batName: 'clipEventList$BAT', onComplete: onComplete, stdInOut: stdInOut);
  }

//SYNC_FRAME_RATE -$VSYNC_VFR
  static String clipVideoIntoOneSync(String videoPath, String outputPath) =>
      '$FFMPEG -$OVERWRITE_Y -$ANALYZE_DURATION $SECONDS_45 -$PROBE_SIZE $MB_150 -$F $CONCAT -$SAFE $FALSE_FFM -$INPUT_VIDEO "$videoPath" -$CODEC_LIB_X264 -$PRESET $SLOW -$CRF 17 -vf fps=30 -$AUDIO_CODEC_AAC -$AUDIO_BIT_RATE_192_k  "$outputPath"';

  static String copyMetadataToJson(Event e, String jsonFile, String dirPath, String fileFormat) =>
      '$FFPROBE -$VERBOSE $QUIET -$PRINT_FORMAT $JSON_K_W -$SHOW_FORMAT -$SHOW_STREAMS "$dirPath\\${e.fileName()}$fileFormat" > "$jsonFile"';

  String _ffprobeJsonMetadata =
      '$FFPROBE -$VERBOSE $QUIET -$PRINT_FORMAT $JSON_K_W -$SHOW_FORMAT -$SHOW_STREAMS ';

  //

  static String copyMetadataToJsonDummy(
          String fileName, String jsonFile, String dirPath, String fileFormat) =>
      '$FFPROBE -$VERBOSE $QUIET -$PRINT_FORMAT $JSON_K_W -show_format -show_streams "$dirPath\\$fileName$fileFormat" > "$jsonFile"';

  static String clipVideosIntoOneFilterComplex(
      List<Event> events, String videoFile, String outputpath) {
    String complexFilter = _reclipAudioOrVideo(events, 'v');
    complexFilter += _reclipAudioOrVideo(events, 'a');
    complexFilter += __concatVideosAndAudios(events);
    return '$FFMPEG -$OVERWRITE_Y -$SAFE $FALSE_FFM -$INPUT $videoFile -filter_complex "$complexFilter" "$outputpath"';
  }

  static String getVideoWidth(String videoPath, String outputFile) =>
      '$FFPROBE -$VERBOSE error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$videoPath" > "$outputFile"';

  //ffmpeg -i faulty_video.mp4 -vf "setpts=PTS*(60/24)" -c:v libx264 -crf 23 -preset veryfast -c:a copy fixed_video.mp4

  static String changeVideoMetaData(
          String videoToChangeMetaData, String jsonMetaDataFileName, String changedVideoPath) =>
      '$FFMPEG -$OVERWRITE_Y -$INPUT_VIDEO "$videoToChangeMetaData" -$INPUT "$jsonMetaDataFileName" -map_metadata 1 -codec copy "$changedVideoPath"';

  static String _reclipAudioOrVideo(List<Event> events, String videoAudio) {
    String complexFilter = '';
    events.forEachIndexed((e, i) {
      Duration d = (Duration(milliseconds: e.endMillis) - Duration(milliseconds: e.startMillis)) -
          const Duration(milliseconds: 250);
      String newDuration = d.toFfmpegDuration();
      return complexFilter +=
          '[$i:$videoAudio]trim=duration=$newDuration,setpts=PTS-STARTPTS[$videoAudio$i]; \\';
    });
    return complexFilter;
  }

  static String __concatVideosAndAudios(List<Event> events) {
    String concat = '';
    events.forEachIndexed((_, i) {
      concat += '[v$i][a$i]';
    });
    concat += 'concat=n=${events.length}:v=1:a=1';
    return concat;
  }

  static String _buildInputVideos(List<String> videoPath) {
    String inputVideo = '';
    videoPath.forEach((e) => inputVideo += ' -i "$e"');
    return inputVideo;
  }

/*
   -preset medium -crf 23 -c:a aac -b:a 192k output.mp4
   */
}
