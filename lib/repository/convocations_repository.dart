// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_for_elements_to_map_fromiterable, curly_braces_in_flow_control_structures

import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/repository/api_firebase_service.dart';
import 'package:fake_football_desktop/utils/ext.dart';

import '../utils/constants.dart';

class ConvocationsRepository {
  Future<List<List<Player>>> getConvocati() async {
    List<Player> gialli = [], verdi = [];
    return ApiFirebaseService().getFromUrl(path: [CURRENT_GAME]).then(
      (currGame) {
        if (currGame != null) {
          return getPlayersList().then((allPlayers) async {
            int matchType = currGame[MATCH_TYPE];
            if (currGame[OFFICIAL_MATCH_FB] == true) {
              bool isYellow = currGame[JERSEY_COLOR] == GIALLI;
              Map<String, int> playersNumberById = Map.fromIterable(
                currGame[SQUAD].keys,
                key: (d) => d,
                value: (d) {
                  return currGame[SQUAD][d][NUMBER];
                },
              );
              for (Player p in allPlayers) {
                checkIfPlayerConvocato(playersNumberById, p, gialli);
                if (gialli.length == matchType) break;
              }

              int howManyRookies = matchType - playersNumberById.keys.length;
              if (howManyRookies != 0) {
                List<Player> allRookies = await getRookiesList();
                for (Player r in allRookies) {
                  howManyRookies =
                      checkIfRookieConvocato(playersNumberById, r, gialli, howManyRookies);
                  if (howManyRookies == 0) break;
                }
              }
              if (!isYellow) gialli.marskAsGreenTeam();
              return [gialli];
            }
            Map<String, int> gialliNumbersById = Map.fromIterable(
              currGame[GIALLI].keys,
              key: (d) => d,
              value: (d) {
                return currGame[GIALLI][d][NUMBER];
              },
            );
            Map<String, int> verdiNumbersById = Map.fromIterable(
              currGame[VERDI].keys,
              key: (d) => d,
              value: (d) {
                return currGame[VERDI][d][NUMBER];
              },
            );

            for (Player p in allPlayers) {
              checkIfPlayerConvocato(gialliNumbersById, p, gialli);
              checkIfPlayerConvocato(verdiNumbersById, p, verdi);
              if (gialli.length == matchType && verdi.length == matchType) break;
            }

            //case when rookies are in convocations
            int howManyRookies = gialliNumbersById.keys.length + verdiNumbersById.keys.length;
            if (howManyRookies != 0) {
              List<Player> allRookies = await getRookiesList();
              for (Player r in allRookies) {
                howManyRookies =
                    checkIfRookieConvocato(gialliNumbersById, r, gialli, howManyRookies);
                howManyRookies = checkIfRookieConvocato(verdiNumbersById, r, verdi, howManyRookies);
                if (howManyRookies == 0) break;
              }
            }
            return [
              gialli..sortByNumber(),
              verdi
                ..marskAsGreenTeam()
                ..sortByNumber()
            ];
          });
        } else {
          return [
            gialli..sortByNumber(),
            verdi
              ..marskAsGreenTeam()
              ..sortByNumber()
          ];
        }
      },
    );
  }

  Future<List<List<Player>>> getConvocatiP() async {
    Map<String, dynamic>? currGame = await ApiFirebaseService().getFromUrl(path: [CURRENT_GAME]);
    List<Player> allPlayers = await getPlayersList();
    List<Player> gialli = [], verdi = [];
    if (currGame != null) {
      int matchType = currGame[MATCH_TYPE];
      if (currGame[OFFICIAL_MATCH_FB] == true) {
        bool isYellow = currGame[JERSEY_COLOR] == GIALLI;
        Map<String, int> playersNumberById = Map.fromIterable(
          currGame[SQUAD].keys,
          key: (d) => d,
          value: (d) {
            return currGame[SQUAD][d][NUMBER];
          },
        );
        for (Player p in allPlayers) {
          checkIfPlayerConvocato(playersNumberById, p, gialli);
          if (gialli.length == matchType) break;
        }

        int howManyRookies = matchType - playersNumberById.keys.length;
        if (howManyRookies != 0) {
          List<Player> allRookies = await getRookiesList();
          for (Player r in allRookies) {
            howManyRookies = checkIfRookieConvocato(playersNumberById, r, gialli, howManyRookies);
            if (howManyRookies == 0) break;
          }
        }
        if (!isYellow) gialli.marskAsGreenTeam();
        return [gialli];
      }
      Map<String, int> gialliNumbersById = Map.fromIterable(
        currGame[GIALLI].keys,
        key: (d) => d,
        value: (d) {
          return currGame[GIALLI][d][NUMBER];
        },
      );
      Map<String, int> verdiNumbersById = Map.fromIterable(
        currGame[VERDI].keys,
        key: (d) => d,
        value: (d) {
          return currGame[VERDI][d][NUMBER];
        },
      );

      for (Player p in allPlayers) {
        checkIfPlayerConvocato(gialliNumbersById, p, gialli);
        checkIfPlayerConvocato(verdiNumbersById, p, verdi);
        if (gialli.length == matchType && verdi.length == matchType) break;
      }

      //case when rookies are in convocations
      int howManyRookies = gialliNumbersById.keys.length + verdiNumbersById.keys.length;
      if (howManyRookies != 0) {
        List<Player> allRookies = await getRookiesList();
        for (Player r in allRookies) {
          howManyRookies = checkIfRookieConvocato(gialliNumbersById, r, gialli, howManyRookies);
          howManyRookies = checkIfRookieConvocato(verdiNumbersById, r, verdi, howManyRookies);
          if (howManyRookies == 0) break;
        }
      }
    }
    return [
      gialli..sortByNumber(),
      verdi
        ..marskAsGreenTeam()
        ..sortByNumber()
    ];
  }

  int checkIfRookieConvocato(
      Map<String, int> gialliNumbersById, Player r, List<Player> gialli, int howManyRookies) {
    if (gialliNumbersById.containsKey(r.playerId)) {
      r.number = gialliNumbersById[r.playerId]!;
      howManyRookies--;
    }
    return howManyRookies;
  }

  void checkIfPlayerConvocato(Map<String, int> gialliNumbersById, Player p, List<Player> gialli) {
    if (gialliNumbersById.containsKey(p.playerId)) {
      gialliNumbersById.remove(p.playerId);
      gialli.add(p);
    }
  }

  Future<List<List<Player>>> getPlayersConvocati() async {
    List<List<Player>> allConvocati = [];
    return allConvocati;
  }

  Future<List<String>> getModuli() async {
    Map<String, dynamic>? currGame = await ApiFirebaseService().getFromUrl(path: [CURRENT_GAME]);
    int matchType = currGame?[MATCH_TYPE] ?? 7;
    Map<String, dynamic>? moduli = await ApiFirebaseService()
        .getFromUrl(path: [MODULI.trim(), '$MODULI_PREFIX$matchType'.trim()]);
    return moduli?.keys.toList() ?? [];
  }

  Future<void> saveModuli(String moduloGialli, String moduloVerdi) async {
    await ApiFirebaseService().patchToUrl([CURRENT_GAME], {MODULO_GIALLI: moduloGialli});
    await ApiFirebaseService().patchToUrl([CURRENT_GAME], {MODULO_VERDI: moduloVerdi});
    return;
  }

  Future<List<String?>> getSavedModuli() async {
    Map<String, dynamic>? currentGame = await ApiFirebaseService().getFromUrl(path: [CURRENT_GAME]);
    String? g = currentGame?[MODULO_GIALLI] as String?;
    String? v = currentGame?[MODULO_VERDI] as String?;
    bool officialMatch = currentGame?[OFFICIAL_MATCH_FB] as bool? ?? false;
    if (!officialMatch) {
      g = g != null && g.isNotEmpty ? g : null;
      v = v != null && v.isNotEmpty ? v : null;
      return [g, v];
    } else
      return [g ?? v!];
  }

  Future<void> markContentAsDone() async =>
      await ApiFirebaseService().patchToUrl([CURRENT_GAME], {CONTENT_DONE: true});

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

  Future<int> getMatchType() async {
    Map<String, dynamic>? currentGame = await ApiFirebaseService().getFromUrl(path: [CURRENT_GAME]);
    return currentGame?[MATCH_TYPE] ?? 7;
  }
}
