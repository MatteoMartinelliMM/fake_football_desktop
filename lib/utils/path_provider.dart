// ignore_for_file: prefer_for_elements_to_map_fromiterable, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class PathProvider {
  static final PathProvider _instance = PathProvider._getInstance();
  static Directory? _applicationDirectory;
  static SharedPreferences? _pref;
  static final List<String> _directories = [];
  static final List<String> _files = [];
  static final List<String> _videos = [];
  static final List<String> _imgs = [];
  static final List<String> _executables = [];

  static SharedPreferences get pref => _pref!;

  static Directory get dir => _applicationDirectory!;

  factory PathProvider() {
    initializeSharedPrefsAndWorkingDir(getApplicationDocumentsDirectory());
    return _instance;
  }

  static void initializeSharedPrefsAndWorkingDir(Future<Directory> directory) {
    directory.then((value) {
      _applicationDirectory = value;
      SharedPreferences.getInstance().then((value) {
        _pref = value;
        initializePreferenceFirstLaunch();
        return _pref;
      });
      return _applicationDirectory!;
    });
  }

  static void initializePreferenceFirstLaunch() {
    if (pref.getKeys().isEmpty) {
      pref.setInt(MAX_ROLE_PER_PLAYER, 5);
      pref.setString(ROOT_PATH, '');
      _directories.add(ROOT_PATH);
      pref.setString(VIDEO_READER_PATH, '');
      pref.setString(PS_PATH, '');
      _executables.add(VIDEO_READER_PATH);
      _executables.add(PS_PATH);
      pref.setString(PLACEHOLDER_PRIMO_TEMPO, '');
      pref.setString(PLACEHOLDER_SECONDO_TEMPO, '');
      pref.setString(PLACEHOLDER_FFMOMENTS, '');
      _videos.add(PLACEHOLDER_PRIMO_TEMPO);
      _videos.add(PLACEHOLDER_SECONDO_TEMPO);
      _videos.add(PLACEHOLDER_FFMOMENTS);
    }
  }

  PathProvider._getInstance();

  static bool pathThreeInitialized() {
    return !Platform.isWindows ||
        pref.getKeys().toList().countWhere((k) {
              Object? v = pref.get(k);
              return (v == null) ||
                  (v is String && v.isEmpty) ||
                  (v is double && v.isNaN) ||
                  (v is int && v.isNaN);
            }) ==
            0;
  }

  static Map<String, dynamic> getPathInfos() =>
      Map.fromIterable(pref.getKeys(), key: (e) => e, value: (e) => pref.get(e));

  static FileType? getFileType(String key) {
    if (_videos.contains(key)) {
      return FileType.video;
    }
    if (_imgs.contains(key)) {
      return FileType.image;
    }
    if (_files.contains(key)) {
      return FileType.any;
    }
    if (_executables.contains(key)) {
      return FileType.custom;
    }
    return null;
  }

  static Future<bool> saveSetting(String contentKey, String value) =>
      pref.setString(contentKey, value);

  static clearAll() {
    print('clearAll');
    pref.clear();
  }

  static String rootDirPath() => pref.getString(ROOT_PATH)!;

  static String photoshopExePath() => pref.getString(PS_PATH)!;

  static String getCompletePath([List<String>? relativeUrls]) {
    if (relativeUrls != null) return ([rootDirPath(), ...relativeUrls]).buildFilePath();
    return ([rootDirPath()]).buildFilePath();
  }

  static File getFileFromPath(List<String> list) => File(getCompletePath(list));

  static Directory getDirFromPath(List<String> list) => Directory(getCompletePath(list));

  static String getFormazioniPsdFile(String modulo, bool isYellow) =>
      getCompletePath([((isYellow ? PITCH_GIALLO_PSD : PITCH_VERDE_PSD) + modulo + PSD)]);

  static Directory getPlayerDir(Player p) => getDirFromPath([p.getRoasterDir(), p.dirName]);

  static bool checkIfTempFormazioneExist(Player p) =>
      getFileFromPath([FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI, p.dirNameFormazioni, p.formazione])
          .existsSync();

  static File getCardPortiere(Player p) =>
      getFileFromPath([p.getRoasterDir(), p.dirName, p.cardPortiere]);

  static File getCardFormazione(Player p) =>
      getFileFromPath([p.getRoasterDir(), p.dirName, p.cardFormazione]);

  static Directory playerDirFromTempFile(String path) {
    String fileNameAndFolder = path.split('\\').last;
    print('fileNameAndFolder: $fileNameAndFolder');
    List<String> folderAndFile = fileNameAndFolder.split('_');
    String ext = '.${folderAndFile.last.split('.').last}';
    print('ext $ext');
    String fileName = '${folderAndFile.first}$ext';
    print('fileName: $fileName');
    String playerDirName = folderAndFile.last.replaceAll('$COPIA_PH_REMOVE$ext', '');
    print('playerDirName: $playerDirName');
    bool isRookie = YELLOW_ROOKIES.contains(int.parse(playerDirName.split('-').first)) ||
        GREEN_ROOKIES.contains(int.parse(playerDirName.split('-').first)) ||
        GREEN_KEEPER == int.parse(playerDirName.split('-').first) ||
        YELLOW_KEEPER == int.parse(playerDirName.split('-').first);
    print('$isRookie');
    String squadDir = !isRookie ? SQUAD_DIR : ROOKIES_DIR;
    print('new path ${getCompletePath([ROASTER_DIR, squadDir, playerDirName, fileName])}');
    return getDirFromPath([ROASTER_DIR, squadDir, playerDirName]);
  }

  static String playerFilePathFromTempFile(String path) {
    String fileNameAndFolder = path.split('\\').last;
    print('fileNameAndFolder: $fileNameAndFolder');
    List<String> folderAndFile = fileNameAndFolder.split('_');
    String ext = '.${folderAndFile.last.split('.').last}';
    print('ext $ext');
    String fileName = '${folderAndFile.first}$ext';
    print('fileName: $fileName');
    String playerDirName = folderAndFile.last.replaceAll('$COPIA_PH_REMOVE$ext', '');
    print('playerDirName: $playerDirName');
    bool isRookie = YELLOW_ROOKIES.contains(int.parse(playerDirName.split('-').first)) ||
        GREEN_ROOKIES.contains(int.parse(playerDirName.split('-').first)) ||
        GREEN_KEEPER == int.parse(playerDirName.split('-').first) ||
        YELLOW_KEEPER == int.parse(playerDirName.split('-').first);
    print('$isRookie');
    String squadDir = !isRookie ? SQUAD_DIR : ROOKIES_DIR;
    print('new path ${getCompletePath([ROASTER_DIR, squadDir, playerDirName, fileName])}');
    return getCompletePath([ROASTER_DIR, squadDir, playerDirName, fileName]);
  }

  static Future<void> moveDirectory(Directory sourceDir, Directory destinationDir) async {
    List<FileSystemEntity> entities = await sourceDir.list().toList();
    entities.forEach((fe) async {
      String pathToMove = fe.uri.pathSegments.last;
      if (pathToMove.isEmpty) {
        // Remove the trailing slash and get the last segment
        pathToMove = fe.uri.pathSegments[fe.uri.pathSegments.length - 2];
      }
      String newPath = [destinationDir.path, pathToMove].buildFilePath();
      if (fe is Directory) {
        Directory newDir = Directory(newPath);
        await newDir.create(recursive: true);
        await moveDirectory(fe, newDir);
      }
      if (fe is File) await fe.rename(newPath);
    });
    await sourceDir.delete(recursive: true);
    return;
  }

  static int maxRolePerPlayer() => pref.getInt(MAX_ROLE_PER_PLAYER)!;

// {object.p.getRoasterDir()}${object.p.dirName}\\${object.p.cardPortiere

//'$dirPath$NEW_PARTITA$FOLDER_FORMAZIONI$dirNameFormazioni\\$formazione';
}
