// ignore_for_file: curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls, prefer_for_elements_to_map_fromiterable

import 'dart:io';
import 'dart:math';
import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/event_status.dart';
import 'package:fake_football_desktop/model/event_team.dart';
import 'package:fake_football_desktop/model/event_type.dart';
import 'package:fake_football_desktop/model/match_status.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';

//region generics ext
extension ListUtils<T> on List<T> {
  T? firstOrNullWhere(Function(T) f) {
    var list = where((t) => f.call(t)).toList();
    return list.isNotEmpty ? list.first : null;
  }

  void addOrRemove(T t) => contains(t) ? remove(t) : add(t);

  int countWhere(Function(T) f) => where((t) => f.call(t)).toList().length;

  void forEachIndexed(Function(T, int) f) {
    int i = 0;
    forEach((e) {
      f.call(e, i);
      i++;
    });
  }
}

extension NullableListUtils<T> on List<T>? {
  bool isNullOrEmpty() => this != null ? this!.isEmpty : true;

  T? firstOrNull() => this != null && this!.isNotEmpty ? this!.first : null;
}

extension MapUtils<K, V> on Map<K, V> {
  String printMap() {
    String print = '';
    keys.forEach((k) => print += '$k - ${this[k]}\n');
    return print.trimRight();
  }

  Map<K, V> fromIterableWhere(Iterable<K> iterable,
      {required K Function(K) key, required V Function(K) value, required bool Function(K) where}) {
    iterable.forEach((e) {
      if (where(e)) this[key.call(e)] = value.call(e);
    });
    return this;
  }

  K? firstKeyWhere(bool Function(K, V?) where) {
    K? ret;
    for (K k in keys)
      if (where(k, this[k])) {
        ret = k;
      }
    return ret;
  }
}

extension NullableMapUtils<K, V> on Map<K, V>? {
  bool isNullOrEmpty() => this != null ? this!.isEmpty : true;
}
//end region

extension PlayerFinder on Player {
  String getPath(String file) {
    switch (file) {
      case CARD_FORMAZIONE:
        return '$BASE_PATH$dirName$cardFormazione$PNG';
      case CARD_PORTIERE:
        return '$BASE_PATH$dirName$cardPortiere$PNG';
      case CARD_SOCIAL:
        return '$BASE_PATH$dirName$cardSocial$PNG';
      case PLAYER_INTERO:
        return '$BASE_PATH$dirName$playerIntero$PNG';
      case PLAYER_MEZZO_BUSTO:
        return '$BASE_PATH$dirName$playerMezzoBusto$PNG';
      case PLAYER_TAGLIATO:
        return '$BASE_PATH$dirName$playerTagliato$PNG';
      case TESTA:
      default:
        return '$BASE_PATH$dirName$testa$PNG';
    }
  }

  String getRoasterDir() =>
      [ROASTER_DIR, (!this.isRookie ? SQUAD_DIR : ROOKIES_DIR)].buildFilePath();

  String getTeam() => isYellow ? 'GIALLI' : 'VERDI';

  bool isRookie() => isYellow
      ? YELLOW_ROOKIES.contains(number) || YELLOW_KEEPER == number
      : GREEN_ROOKIES.contains(number) || GREEN_KEEPER == number;

  Map<EventType, List<int>> riepilogoPartita() => {
        EventType.GOAL: [goalMatch, quasiGoalMatch],
        EventType.ASSIST: [assistMatch],
        EventType.RIGORI: [rigoriTiratiMatch, rigoriSegnatiMatch],
        EventType.AL_BARETTO: [andatoAlBarettoMatch, mandatiAlBarettoMatch],
        EventType.BOTTE: [violenzeSubiteMatch, violenzeCommesseMatch],
        EventType.PAPERE: [failMatch],
      };

  Map<EventType, List<int>> riepilogoStagione() => {
        EventType.PRESENZE: [appearances, mvp],
        EventType.GOAL: [goal],
        EventType.ASSIST: [assist],
        EventType.RIGORI: [rigoriTirati, rigoriSegnati],
        EventType.AL_BARETTO: [andatoAlBaretto, mandatiAlBaretto],
        EventType.BOTTE: [violenzeSubite, violenzeCommesse],
        EventType.PAPERE: [fail],
      };

  List<Shadow> textStrokeTeam() {
    Color color = isYellow ? Colors.black87 : Colors.white;
    return [
      Shadow(
        offset: const Offset(-1.5, -1.5),
        color: color,
      ),
      Shadow(
        offset: const Offset(1.5, -1.5),
        color: color,
      ),
      Shadow(
        offset: const Offset(1.5, 1.5),
        color: color,
      ),
      Shadow(
        offset: const Offset(-1.5, 1.5),
        color: color,
      ),
    ];
  }
}

extension PlayerCollectionUtils on List<Player> {
  List<Player> getRookies() {
    if (isNotEmpty) {
      List<int> rookiesNumbers = first.isYellow ? YELLOW_ROOKIES : GREEN_ROOKIES;
      return where((p) => rookiesNumbers.contains(p.number)).toList();
    }
    return [];
  }

  Player? getKeeper() {
    if (isNotEmpty) {
      int keeperNumber = first.isYellow ? YELLOW_KEEPER : GREEN_KEEPER;
      var list = where((element) => element.number == keeperNumber).toList();
      return list.isNotEmpty ? list.first : null;
    }
    return null;
  }

  bool haveRookies() {
    if (isNotEmpty) {
      return where((p) =>
          YELLOW_ROOKIES.contains(p.number) ||
          GREEN_ROOKIES.contains(p.number) ||
          YELLOW_KEEPER == p.number ||
          GREEN_KEEPER == p.number).toList().isNotEmpty;
    }
    return false;
  }

  Map<String, dynamic> toJsonConvocati() {
    Map<String, dynamic> map = {};
    forEach((p) => map.addAll(p.toJsonConvocati()));
    return map;
  }

  void sortByNumber() => sort((p1, p2) => p1.number.compareTo(p2.number));

  void marskAsGreenTeam() => forEach((p) => p.isYellow = false);

  void marskAsYellowTeam() => forEach((p) => p.isYellow = true);

  void sortByRole(String role) {
    sort((a, b) {
      var compareTo = a.roles.indexOf(role).compareTo(b.roles.indexOf(role));
      if (compareTo == 0) return a.roles.length.compareTo(b.roles.length);
      return compareTo;
    });
  }

  Map<String, List<Player>> sortPlayersByLineUp(String modulo, [bool? needKeeper]) {
    List<String> howManyPlayersPerRoleString = modulo.split(SECOND_VERSION).first.split('-');
    int i = 0;
    needKeeper = needKeeper ?? true;
    Map<String, int> howManyPlayersPerRole = Map.fromIterable(howManyPlayersPerRoleString,
        key: (k) {
          String role = i.toFieldZone();
          i++;
          return role;
        },
        value: (v) => int.parse(v));

    Map<String, List<Player>> playersPerRole = {};
    List<Player> temp = [...this];
    if (needKeeper) {
      Player? keeper = temp.firstOrNullWhere((p) => p.roles.contains(POR));
      keeper = keeper ?? temp.firstOrNullWhere((p) => p.isRookie);
      keeper ?? temp.shuffle(Random(7));
      keeper = keeper ?? temp.first;
      playersPerRole[POR] = [keeper];
      temp.remove(keeper);
    }

    howManyPlayersPerRole.keys.forEach(
      (role) {
        int playersAmount = howManyPlayersPerRole[role]!;
        List<Player> inRole = [];
        List<Player> canDoRole = temp.where((p) => p.roles.contains(role)).toList()
          ..sortByRole(role);
        int playersToTake = playersAmount != 3 && playersAmount != 4
            ? playersAmount
            : playersAmount - 2; //(fausto) le ali vengono gestite a parte
        if (canDoRole.isNotEmpty) {
          while (inRole.length != playersToTake) {
            if (canDoRole.isEmpty) break;
            Player p = canDoRole.first;
            canDoRole.remove(canDoRole.first);
            inRole.add(p);
            temp.remove(p);
          }
        }
        if (playersToTake != playersAmount) {
          List<Player> ali = temp.where((p) => p.roles.contains(ALA)).toList()..sortByRole(ALA);
          if (ali.length > 2) {
            temp.remove(ali.first);
            temp.remove(ali[1]);
            inRole.insert(0, ali.first);
            inRole.add(ali[1]);
          }
          if (ali.length == 2) {
            inRole.insert(0, ali.first);
            inRole.add(ali.last);
          }
        }
        playersPerRole[role] = inRole;
      },
    );
    if (temp.isNotEmpty) {
      howManyPlayersPerRole.keys.forEach((role) {
        int howManyPlayers = howManyPlayersPerRole[role]!;
        if (playersPerRole[role]!.length != howManyPlayers) {
          while (playersPerRole[role]!.length != howManyPlayers) {
            Player p = temp.first;
            playersPerRole[role]!.add(p);
            temp.remove(p);
          }
        }
      });
    }
    return playersPerRole;
  }
}

extension FileUtils on File {
  Future<File> moveFile(String newPath) async {
    try {
      return await rename(newPath);
    } on FileSystemException {
      final newFile = await copy(newPath);
      await delete();
      return newFile;
    }
  }

  String playerCardFromTempToRoaster() {
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
    print('new path $squadDir$playerDirName\\$fileName');
    return [ROASTER_DIR, squadDir, playerDirName, fileName].buildFilePath();
  }

  String fromTempToFormazioniFolder() {
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
    print('new path $FOLDER_NEW_PARTITA$FOLDER_FORMAZIONI$playerDirName\\$fileName');
    return [FOLDER_NEW_PARTITA, FOLDER_FORMAZIONI, playerDirName, fileName].buildFilePath();
  }

  String? getFileAsString() => existsSync() ? readAsStringSync() : null;

  Future<void> deleteIfExist() async {
    try {
      if (await exists()) {
        await delete();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

extension FilesUtils on List<File> {
  List<File> getFilesFromExtension(String ext) =>
      where((f) => f.path.split('.').last.toLowerCase() == ext.substring(1).toLowerCase()).toList();
}

extension MeasurmentsUtils on BuildContext {
  double getHeightWithoutAppbar() {
    final appBar = AppBar(); //Need to instantiate this here to get its size
    final appBarHeight = appBar.preferredSize.height + MediaQuery.of(this).padding.top;
    return MediaQuery.of(this).size.height - appBarHeight;
  }
}

extension TaglieNrBinding on int {
  String getTaglia() {
    switch (this) {
      case 20:
      case 33:
      case 69:
      case 74:
        return "M";
      case 44:
      case 90:
        return "L";
      default:
        return "S";
    }
  }

  String toFieldZone() {
    switch (this) {
      case 0:
        return DC;
      case 1:
        return CC;
      case 2:
        return ATT;
    }
    return '';
  }

  bool isYellow() => YELLOW_ROOKIES.contains(this);
}

extension BooleanExt on bool {
  Color getColor() => this ? Colors.yellow : const Color(0xFF238450);

  int getKeeperNumber() => this ? YELLOW_KEEPER : GREEN_KEEPER;
}

extension StringNullableUtils on String? {
  bool isNullOrEmpty() => this?.isEmpty ?? true;
}

extension StringListUtils on List<String> {
  String buildFilePath() => join(Platform.isWindows ? r'\' : '/');
}

extension StringUtils on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String? getFileExt() {
    if (RegExp(IS_FILE).hasMatch(this)) return '.${split('.').last}';
    return null;
  }

  double fieldPositionKByRole() {
    switch (this) {
      case POR:
        return 0.99;
      case DC:
        return 0.75;
      case CC:
        return 0.50;
      case ATT:
        return 0.25;
      default:
        return 0;
    }
  }

  void printOut() => print(this);

  void printOutMsg(String ms) => print(ms + this);

  Icon getIconBySettings() {
    switch (this) {
      case ROOT_PATH:
        return const Icon(
          Icons.folder,
          color: Colors.yellow,
          size: 48,
        );
      case VIDEO_READER_PATH:
        return const Icon(
          Icons.ondemand_video,
          color: Colors.white,
          size: 48,
        );
      case PS_PATH:
        return const Icon(
          Icons.adobe,
          color: Colors.white,
          size: 48,
        );
      case PLACEHOLDER_PRIMO_TEMPO:
      case PLACEHOLDER_SECONDO_TEMPO:
      case PLACEHOLDER_FFMOMENTS:
        return const Icon(
          Icons.video_file_outlined,
          color: Colors.white,
          size: 48,
        );
      default:
        return const Icon(
          Icons.file_open_outlined,
          color: Colors.white,
          size: 48,
        );
    }
  }
}

extension EventTypeUtils on EventType {
  Widget icon() {
    switch (this) {
      case EventType.PAPERE:
        return SizedBox(
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            'assets/svg/duck.svg',
            colorFilter: const ColorFilter.mode(Colors.yellow, BlendMode.srcIn),
          ),
        );
      case EventType.GOAL:
        return const Icon(
          Icons.sports_soccer,
          color: Colors.green,
        );
      case EventType.ASSIST:
        return const Icon(
          Icons.handshake_outlined,
          color: Colors.greenAccent,
        );
      case EventType.QUASI_GOAL:
        return const Icon(
          Icons.sports_soccer,
          color: Colors.red,
        );
      case EventType.LOL_REGIA:
        return const Icon(
          Icons.mic,
          color: Colors.green,
        );
      case EventType.BOTTE:
        return const Icon(
          Icons.sports_martial_arts,
          color: Colors.redAccent,
        );
      case EventType.AL_BARETTO:
        return SizedBox(
          width: 25,
          height: 25,
          child: SvgPicture.asset(
            'assets/svg/surf.svg',
            colorFilter: const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
          ),
        );
      case EventType.RIGORI:
        return SizedBox(
          width: 25,
          height: 25,
          child: SvgPicture.asset(
            'assets/svg/penalty.svg',
            colorFilter: const ColorFilter.mode(Colors.deepOrangeAccent, BlendMode.srcIn),
          ),
        );
      case EventType.NONE:
        return const Icon(
          Icons.star_outline,
          color: Colors.transparent,
        );
      case EventType.PRESENZE:
        return const Icon(
          Icons.hail,
          color: Colors.teal,
        );
      default:
        return const Icon(
          Icons.splitscreen,
          color: Colors.transparent,
        );
    }
  }

  String getLabel() => toString().split('.').last.replaceAll("_", " ");

  String getQuestions(int turn) {
    switch (this) {
      case EventType.GOAL:
        return turn == 0 ? 'Chi ha fatto goal?' : 'Chi ha fatto assist?';
      case EventType.QUASI_GOAL:
        return 'Chi stava per segnare?';
      case EventType.RIGORI:
        return turn == 0 ? 'Chi tira il rigore?' : 'Fatto gol?';
      case EventType.PAPERE:
        return 'Chi ha fatto la paperata?';
      case EventType.BOTTE:
        return turn == 0 ? 'Chi ha fatto Violenza?' : 'Chi ha subito violenza?';
      case EventType.AL_BARETTO:
        return turn == 0 ? 'Chi ha mandato al baretto?' : 'Chi è andato al baretto?';
      default:
        return 'metrooo';
    }
  }

  String getResumeLabelMatch(int i) {
    switch (this) {
      case EventType.GOAL:
        return i == 0 ? '(Segnati)' : '(Tiri)';
      case EventType.RIGORI:
        return i == 0 ? '(Tirati)' : '(Segnati)';
      case EventType.BOTTE:
        return i == 0 ? '(Ricevute)' : '(Date)';
      case EventType.AL_BARETTO:
        return i == 0 ? '(Mandati)' : '(Andato)';
      default:
        return '';
    }
  }

  String getResumeLabelSeason(int i) {
    switch (this) {
      case EventType.PRESENZE:
        return i == 0 ? '' : '(MVP)';
      case EventType.RIGORI:
        return i == 0 ? '(Tirati)' : '(Segnati)';
      case EventType.BOTTE:
        return i == 0 ? '(Ricevute)' : '(Date)';
      case EventType.AL_BARETTO:
        return i == 0 ? '(Mandati)' : '(Andato)';
      default:
        return '';
    }
  }

  String enumName() => toString().split('.').last;
}

extension EventTeamUtils on EventTeam {
  String enumName() => toString().split('.').last;
}

extension DirUtils on Directory {
  void createIfNotExistsSync({bool recursive = false}) =>
      !existsSync() ? createSync(recursive: recursive) : null;

  Future<void> createIfNotExists({bool recursive = false}) async =>
      !await exists() ? create(recursive: recursive) : null;

  void deleteIfExistSync({bool recurisive = false}) =>
      existsSync() ? deleteSync(recursive: true) : null;

  Future<void> moveDirectory(Directory destDir) async {
    List<FileSystemEntity> entities = await list().toList();
    entities.forEach((fe) async {
      String pathToMove = fe.uri.pathSegments.last;
      if (pathToMove.isEmpty) {
        // Remove the trailing slash and get the last segment
        pathToMove = fe.uri.pathSegments[fe.uri.pathSegments.length - 2];
      }
      print('path tho move: $pathToMove');
      String newPath = [destDir.path, pathToMove].buildFilePath();
      if (fe is Directory) {
        await fe.moveDirectory(Directory(newPath));
      }
      if (fe is File) {
        await File(newPath).create();
        await fe.rename(newPath);
      }
    });
    await delete(recursive: true);
    return;
  }

  void deleteFilesByExtension(String ext) => listSync()
      .whereType<File>()
      .toList()
      .forEach((f) => f.path.endsWith(ext) ? f.deleteSync() : null);
}

extension DurationUtils on Duration {
  String toTimerValue() =>
      '${inHours.toString().padLeft(2, '0')}:${(inMinutes % 60).toString().padLeft(2, '0')}:${(inSeconds % 60).toString().padLeft(2, '0')}';

  String toTabellinoValue() => '${inMinutes.toString()}\'';

  String toFfmpegDuration() => '$inSeconds.${(inMilliseconds % 1000) ~/ 100}';
}

extension EventStatusUtils on EventStatus {
  Color getLabelColor() {
    switch (value) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  String getLabel() => toString().split('.').last.replaceAll("_", " ");

  String enumName() => toString().split('.').last;
}

extension MatchStatusUtils on MatchState {
  String getLabel() => toString().split('.').last.replaceAll("_", " ");

  String? getAcronym() {
    switch (this) {
      case MatchState.FINE_PRIMO_TEMPO:
        return 'HALF TIME';
      case MatchState.FINE_PARTITA:
        return 'FULL TIME';
      default:
        return null;
    }
  }

  String enumName() => toString().split('.').last;
}

extension EventListUtils on List<Event> {
  int totEventsLength() {
    int totDuration = 0;
    forEach((e) {
      totDuration += (Duration(milliseconds: e.endMillis) - Duration(milliseconds: e.startMillis))
          .inMilliseconds;
    });
    return totDuration;
  }

  List<String> homeScorer() => where((e) =>
      !e.mainEventPlayer.isNullOrEmpty() &&
      (e.type == EventType.GOAL || e.type == EventType.RIGORI) &&
      EventTeam.HOME == e.team).map((e) => e.mainEventPlayer!).toSet().toList();

  List<String> awayScorer() => where((e) =>
      !e.mainEventPlayer.isNullOrEmpty() &&
      (e.type == EventType.GOAL || e.type == EventType.RIGORI) &&
      EventTeam.AWAY == e.team).map((e) => e.mainEventPlayer!).toList();
}
