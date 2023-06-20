// ignore_for_file: must_be_immutable, prefer_for_elements_to_map_fromiterable

import 'package:equatable/equatable.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/material.dart';

class Player extends Equatable {
  late String playerId;
  late String name;
  late int number;

  late int appearances;
  late int goal;
  late int assist;
  late int rigoriTirati;
  late int rigoriSegnati;
  late int fail;
  late int mvp;
  late int violenzeCommesse;
  late int violenzeSubite;
  late int andatoAlBaretto;
  late int mandatiAlBaretto;
  late int quasiGoal;

  late int goalMatch;
  late int quasiGoalMatch;
  late int assistMatch;
  late int rigoriTiratiMatch;
  late int rigoriSegnatiMatch;
  late int violenzeCommesseMatch;
  late int violenzeSubiteMatch;
  late int mandatiAlBarettoMatch;
  late int andatoAlBarettoMatch;
  late int failMatch;
  late List<String> roles;
  bool isYellow = true;
  bool isRookie = false;
  bool isMvp = false;

  Player();

  Player.createRookie(this.name, this.playerId) {
    appearances = 0;
    number = 0;
    goal = 0;
    quasiGoal = 0;
    assist = 0;
    rigoriTirati = 0;
    rigoriSegnati = 0;
    goalMatch = 0;
    quasiGoalMatch = 0;
    assistMatch = 0;
    rigoriTiratiMatch = 0;
    rigoriSegnatiMatch = 0;

    mvp = 0;
    fail = 0;
    violenzeCommesse = 0;
    violenzeSubite = 0;
    andatoAlBaretto = 0;
    mandatiAlBaretto = 0;
    failMatch = 0;
    violenzeCommesseMatch = 0;
    violenzeSubiteMatch = 0;
    andatoAlBarettoMatch = 0;
    mandatiAlBarettoMatch = 0;
    roles = [];
  }

  factory Player.fromJson(String playerId, dynamic json) {
    Player p = Player();

    p.name = json[NAME];
    p.number = json[NUMBER];
    p.playerId = playerId;
    print(p.name);
    p.appearances = json[APPEARANCES] ?? 0;
    p.roles = json[ROLE].cast<String>();
    p.goal = json[GOAL] ?? 0;
    p.quasiGoal = json[QUASI_GOAL] ?? 0;
    p.assist = json[ASSIST] ?? 0;
    p.rigoriTirati = json[RIGORI_TIRATI] ?? 0;
    p.rigoriSegnati = json[RIGORI_SEGNATI] ?? 0;
    p.mvp = json[MVP] ?? 0;
    p.fail = json[PAPERE_COMMESSE] ?? 0;
    p.violenzeCommesse = json[VIOLENZA_FATTA] ?? 0;
    p.violenzeSubite = json[VIOLENZA_SUBITA] ?? 0;
    p.andatoAlBaretto = json[ANDATO_AL_BARETTO] ?? 0;
    p.mandatiAlBaretto = json[MANDATI_AL_BARETTO] ?? 0;
    p.goalMatch = json[GOAL_MATCH] ?? 0;
    p.quasiGoalMatch = json[QUASI_GOAL_MATCH] ?? 0;
    p.rigoriTiratiMatch = json[RIGORI_TIRATI_MATCH] ?? 0;
    p.assistMatch = json[ASSIST_MATCH] ?? 0;
    p.rigoriSegnatiMatch = json[RIGORI_SEGNATI_MATCH] ?? 0;
    p.failMatch = json[PAPERE_COMMESSE_MATCH] ?? 0;
    p.violenzeCommesseMatch = json[VIOLENZA_FATTA_MATCH] ?? 0;
    p.violenzeSubiteMatch = json[VIOLENZA_SUBITA_MATCH] ?? 0;
    p.andatoAlBarettoMatch = json[ANDATO_AL_BARETTO_MATCH] ?? 0;
    p.mandatiAlBarettoMatch = json[MANDATI_AL_BARETTO_MATCH] ?? 0;
    return p;
  }

  bool _isRookie(Player p) {
    return YELLOW_ROOKIES.contains(p.number) ||
        GREEN_ROOKIES.contains(p.number) ||
        YELLOW_KEEPER == p.number ||
        GREEN_KEEPER == p.number;
  }

  void saveMatchStatsIntoSeasonStats() {
    goal += goalMatch;
    quasiGoal += quasiGoalMatch;
    assist += assistMatch;
    rigoriTirati += rigoriTiratiMatch;
    rigoriSegnati += rigoriSegnatiMatch;
    fail += failMatch;
    violenzeCommesse += violenzeCommesseMatch;
    violenzeSubite += violenzeSubiteMatch;
    andatoAlBaretto += andatoAlBarettoMatch;
    mandatiAlBaretto += mandatiAlBarettoMatch;
  }

  factory Player.fromJsonConvocati(String playerId, dynamic json) {
    Player p = Player();
    p.name = json[NAME];
    p.number = json[NUMBER];
    p.playerId = playerId;
    p.isRookie = YELLOW_ROOKIES.contains(p.number) ||
        GREEN_ROOKIES.contains(p.number) ||
        YELLOW_KEEPER == p.number ||
        GREEN_KEEPER == p.number;
    return p;
  }

  Map<String, dynamic> toJson() => {
        playerId: {
          'playerId': playerId,
          'name': name,
          'number': number,
          'goal': goal,
          'assist': assist,
          'appearances': appearances,
          'falli': violenzeCommesse,
          'fail': fail,
          'goalMatch': goalMatch,
          'quasiGoalMatch': quasiGoalMatch,
          'assistMatch': assistMatch,
          'rigoriTiratiMatch': rigoriTiratiMatch,
          'rigoriSegnatiMatch': rigoriSegnatiMatch,
          'failMatch': failMatch,
          'violenzeCommesse': violenzeCommesse,
          'violenzeCommesseMatch': violenzeCommesseMatch,
          'violenzeSubite': violenzeSubite,
          'violenzeSubiteMatch': violenzeSubiteMatch,
          'andatoAlBaretto': andatoAlBaretto,
          'andatoAlBarettoMatch': andatoAlBarettoMatch,
          'mandatiAlBaretto': mandatiAlBaretto,
          'mandatiAlBarettoMatch': mandatiAlBarettoMatch,
          'ruoli': roles
        }
      };

  Map<String, dynamic> toFirebase() => {
        'playerId': playerId,
        'name': name,
        'number': number,
        'goal': goal,
        'assist': assist,
        'appearances': appearances,
        'falli': violenzeCommesse,
        'fail': fail,
        'goalMatch': goalMatch,
        'quasiGoalMatch': quasiGoalMatch,
        'assistMatch': assistMatch,
        'rigoriTiratiMatch': rigoriTiratiMatch,
        'rigoriSegnatiMatch': rigoriSegnatiMatch,
        'failMatch': failMatch,
        'violenzeCommesse': violenzeCommesse,
        'violenzeCommesseMatch': violenzeCommesseMatch,
        'violenzeSubite': violenzeSubite,
        'violenzeSubiteMatch': violenzeSubiteMatch,
        'andatoAlBaretto': andatoAlBaretto,
        'andatoAlBarettoMatch': andatoAlBarettoMatch,
        'mandatiAlBaretto': mandatiAlBaretto,
        'mandatiAlBarettoMatch': mandatiAlBarettoMatch,
        'ruoli': roles
      };

  Map<String, dynamic> toJsonConvocati() => {
        playerId: {'playerId': '$playerId', 'name': name, 'number': number}
      };

  Map<String, dynamic> toConvocati() => {
        'playerid': '$playerId',
        'name': name,
        'number': number,
      };

  String get distinta => '$number) ${name.toLowerCase()}';

  String get dirName => '$number\-${name.toLowerCase()}';

  String get dirNameFormazioni => '$number\ - ${name.toLowerCase()}';

  String get assetDirName => !isRookie ? dirName : 'rookie';

  String get cardFormazione => CARD_FORMAZIONE + _yellowOrGreenFileFlag() + PNG;

  String get cardPortiere => CARD_PORTIERE + _yellowOrGreenFileFlag() + PNG;

  String get cardPortiereWithoutExt => CARD_PORTIERE + _yellowOrGreenFileFlag();

  String get cardFormazioneWithoutExt => CARD_FORMAZIONE + _yellowOrGreenFileFlag();

  String get cardSocial => CARD_SOCIAL + _yellowOrGreenFileFlag() + PNG;

  String get playerIntero => PLAYER_INTERO;

  String get playerMezzoBusto => PLAYER_MEZZO_BUSTO + _yellowOrGreenFileFlag() + PNG;

  String get playerMezzoBustoNamed => PLAYER_MEZZO_BUSTO_NAMED + _yellowOrGreenFileFlag() + PNG;

  String get playerTagliato => PLAYER_TAGLIATO + _yellowOrGreenFileFlag() + PNG;

  String get playerBg => PLAYER_BG + _yellowOrGreenFileFlag() + PNG;

  String get playerStats => PLAYER_STATS + name.capitalize() + _yellowOrGreenFileFlag() + PNG;

  String get testa => TESTA;

  String get formazione => isYellow ? '1$PNG' : '2$PNG';

  String get cambioLabel => '$number\ - ${name.capitalize()}';

  Color get primaryColor => isYellow ? Colors.yellow : const Color(0xFF238450);

  Color get accentColor => isYellow ? Colors.black : Colors.white;

  void checkIfIsRookie() => isRookie = _isRookie(this);

  String _yellowOrGreenFileFlag() => (isYellow ? YELLOW_F : GREEN_F);

  @override
  List<Object?> get props => [name, number];

  void initMatchStats() {
    goalMatch = 0;
    quasiGoalMatch = 0;
    assistMatch = 0;
    violenzeCommesseMatch = 0;
    violenzeSubiteMatch = 0;
    mandatiAlBarettoMatch = 0;
    andatoAlBarettoMatch = 0;
    failMatch = 0;
    rigoriTiratiMatch = 0;
    rigoriSegnatiMatch = 0;
  }
}
