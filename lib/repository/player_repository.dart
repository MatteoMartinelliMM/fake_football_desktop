// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_for_elements_to_map_fromiterable, curly_braces_in_flow_control_structures

import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/repository/api_firebase_service.dart';
import 'package:fake_football_desktop/utils/ext.dart';

class PlayerRepository {
  Future<List<Player>> getPlayersList() async {
    List<Player> players = [];
    Map<String, dynamic>? playersMap = await ApiFirebaseService().getFromUrl(path: [PLAYERS]);
    playersMap?.remove(CURRENT_INDEX);
    playersMap?.keys.forEach((k) => players.add(Player.fromJson(k, playersMap[k])));
    players.sort((a, b) => a.number.compareTo(b.number));
    return players;
  }

  Future<List<Player>> getRookiesList() async {
    List<Player> rookies = [];
    Map<String, dynamic>? rookiesMap = await ApiFirebaseService().getFromUrl(path: [ROOKIES]);
    rookiesMap?.remove(CURRENT_INDEX);
    rookiesMap?.keys
        .forEach((k) => rookies.add(Player.fromJson(k, rookiesMap[k])..isRookie = true));
    rookies.sort((a, b) => a.number.compareTo(b.number));
    return rookies;
  }

  Future<Map<int, List<Player>>> getAllRookiesAndIndex() async {
    Map<String, dynamic>? rookiesMap = await ApiFirebaseService().getFromUrl(path: [ROOKIES]);
    List<Player> rookies = [];
    int currIndex = 0;
    if (rookiesMap != null) {
      currIndex = rookiesMap.remove(CURRENT_INDEX);
      rookiesMap.keys.forEach((k) => rookies.add(Player.fromJson(k, rookiesMap[k])..playerId = k));
    }
    return {currIndex: rookies};
  }

  Future<void> saveConvocati(List<Player> gialli, List<Player> verdi, int footbalType) async {
    await ApiFirebaseService().putToUrl(
      [CURRENT_GAME],
      {
        CONTENT_DONE: false,
        OFFICIAL_MATCH_FB: false,
        GIALLI: gialli.toJsonConvocati(),
        VERDI: verdi.toJsonConvocati(),
        MATCH_TYPE: footbalType,
        MODULO_GIALLI: "",
        MODULO_VERDI: "",
      },
    );
  }

  Future<void> saveConvocatiOfficialMatch(
      List<Player> players, bool isYellow, int footbalType) async {
    String modulo = isYellow ? MODULO_GIALLI : MODULO_VERDI;
    String team = isYellow ? GIALLI : VERDI;

    await ApiFirebaseService().putToUrl(
      [CURRENT_GAME],
      {
        CONTENT_DONE: false,
        OFFICIAL_MATCH_FB: true,
        team: players.toJsonConvocati(),
        MATCH_TYPE: footbalType,
        modulo: "",
      },
    );
  }

  Future<void> deleteCurrentPartita() async {
    return;
  }

  Future<void> insertRookie(Player p, int index) async {
    await ApiFirebaseService().patchToUrl([ROOKIES], p.toJson()..addAll({CURRENT_INDEX: index}));
  }

  Future<void> updatePlayer(Player p) async =>
      await ApiFirebaseService().putToUrl([PLAYERS], p.toJson());

  Future<List<List<Player>>> getConvocatiAndIncrementPresenze() async {
    return [];
  }

  Future<List<List<Player>>> getConvocati() async {
    return [];
  }

  Future<void> updatePlayerStat(Player p, String statNode, int value) async {}

  Future<bool> haveConvocati() async {
    return false;
  }
}
