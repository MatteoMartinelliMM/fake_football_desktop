import 'dart:convert';
import 'dart:io';

import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/sport_match.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:fake_football_desktop/utils/ext.dart';

class TrackingDatabase {
  static final TrackingDatabase _instance = TrackingDatabase._getInstance();
  static Isar? _db;

  factory TrackingDatabase() {
    getApplicationDocumentsDirectory().then((path) {
      if (_db == null || !_db!.isOpen || Isar.instanceNames.isEmpty) {
        if (Platform.isWindows) {
          String dbImportedPath = [
            path.path,
            ROOT_DIR_NO_SLASH,
            TRACKING_DB_DIR,
          ].buildFilePath();
          if (Directory(dbImportedPath).existsSync()) {
            Isar.open([
              SportMatchSchema,
              EventSchema,
            ], directory: path.path, inspector: true)
                .then((currentDb) {
              String matchTablePath = [dbImportedPath, SPORT_MATCHES_JSON].buildFilePath();
              String? matchTableJson = File(matchTablePath).getFileAsString();
              String eventsTablePath = [dbImportedPath, EVENTS_JSON].buildFilePath();
              String? eventsTableJson = File(eventsTablePath).getFileAsString();
              _db = currentDb;
              _db?.writeTxnSync(() {
                List<SportMatch> matches = [];
                List<Event> events = [];
                if (!matchTableJson.isNullOrEmpty()) {
                  _db!.sportMatchs.clearSync();
                  jsonDecode(matchTableJson!).forEach((m) => matches.add(SportMatch.fromJson(m)));
                }
                _db!.sportMatchs.putAllSync(matches);
                if (!eventsTableJson.isNullOrEmpty()) {
                  _db!.events.clearSync();
                  jsonDecode(eventsTableJson!).forEach((m) => events.add(Event.fromJson(m)));
                  _db!.events.putAllSync(events);
                }
                matches.forEach(
                    (m) => m.events.addAll(events.where((e) => m.getPartita() == e.partita)));
                return _db!.sportMatchs.putAllSync(matches);
              });
              Directory(dbImportedPath).delete(recursive: true);
              return _db;
            });
          } else {
            Isar.open([
              SportMatchSchema,
              EventSchema,
            ], directory: path.path, inspector: true)
                .then((value) => _db = value);
          }
        } else {
          Isar.open([
            SportMatchSchema,
            EventSchema,
          ], directory: path.path, inspector: true)
              .then((value) => _db = value);
        }
      }
    });

    return _instance;
  }

  TrackingDatabase._getInstance() {}

  static Isar get db => _db!;

  void printHashCode() {
    print(_instance.hashCode);
  }

  Future<void> exportDatabase() async {
    String pathString;
    /*final path = await getApplicationDocumentsDirectory();
    pathString = path.path;*/
    //pathString = pathString.substring(1, pathString.toString().length - 1);
    /*if (!Platform.isAndroid) {
      final path = await getApplicationDocumentsDirectory();
      pathString = path.toString().split('Directory: ').last;
      pathString = pathString.substring(1, pathString.toString().length - 1);
    } else {
      final path = await getExternalStorageDirectory();
      String mainDir = path!.path.split('Android').first;
      pathString = mainDir.substring(0, mainDir.length - 1);
    }*/
    Directory d = PathProvider.getDirFromPath(
        [DateFormat('yyyy-MM-dd').format(DateTime.now()), TRACKING_DB_DIR])
      ..createIfNotExistsSync(recursive: true);
    print('Exporting db to: ${d.path}');
    String sportMatchesTableJson = jsonEncode(db.sportMatchs.where().findAllSync().toList());
    String eventsTableJson = jsonEncode(db.events.where().findAllSync().toList());
    File sportMatchFile = PathProvider.getFileFromPath(
        ([DateFormat('yyyy-MM-dd').format(DateTime.now()), TRACKING_DB_DIR, SPORT_MATCHES_JSON]))
      ..createSync(recursive: true);
    File eventsFile = PathProvider.getFileFromPath(
        ([DateFormat('yyyy-MM-dd').format(DateTime.now()), TRACKING_DB_DIR, EVENTS_JSON]))
      ..createSync(recursive: true);
    sportMatchFile.writeAsString(sportMatchesTableJson);
    eventsFile.writeAsString(eventsTableJson);
  }
}
