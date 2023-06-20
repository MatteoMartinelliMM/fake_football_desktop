import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/match_status.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:isar/isar.dart';

part 'sport_match.g.dart';

@collection
class SportMatch {
  Id id = Isar.autoIncrement;
  late String home;
  late String away;
  int homeResult = 0;
  int awayResult = 0;
  int? pausedTimeMillis;
  @Enumerated(EnumType.name)
  MatchState state = MatchState.NONE;
  String? dateTime;
  bool isCurrent = false;
  bool isFF = false;

  IsarLinks<Event> events = IsarLinks<Event>();

  String getPartita() => '$home\_$away\_$dateTime';

  SportMatch();

  SportMatch.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
    homeResult = json['homeResult'];
    awayResult = json['awayResult'];
    dateTime = json['dateTime'];
    isCurrent = json['isCurrent'];
    pausedTimeMillis = json['pausedTimeMillis'];
    isFF = json['isFF'];
    id = json['id'];
    state = MatchState.values.byName(json['status'] ?? MatchState.NONE.enumName());
  }

  Map<String, dynamic> toFirebase() => {
        'dateTime': dateTime,
        'home': home,
        'away': away,
        'homeResult': homeResult,
        'awayResult': awayResult,
        'homeScorer': events.toList().homeScorer(),
        'awayScorer': events.toList().awayScorer(),
      };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['away'] = away;
    data['home'] = home;
    data['homeResult'] = homeResult;
    data['awayResult'] = awayResult;
    data['id'] = id;
    data['isCurrent'] = isCurrent;
    data['pausedTimeMillis'] = pausedTimeMillis;
    data['dateTime'] = dateTime;
    data['isFF'] = isFF;
    data['status'] = state.enumName();
    return data;
  }

/*Map<String, dynamic> toFirebaseJson() {
    events.loadSync(overrideChanges: true);
    List<Event> goalHome = events
        .toList()
        .where((e) =>
    e.team == EventTeam.HOME &&
        (e.type == EventType.GOAL || (e.type == EventType.RIGORE && e.success)))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id);
          List<Event> goalAway = events
              .toList()
          .where((e) =>
      e.team == EventTeam.HOME &&
          (e.type == EventType.GOAL || (e.type == EventType.RIGORE && e.success)))
          .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    Map<String, dynamic> map = {'${id}_${dateTime!}': {
      'id': '$id\_$dateTime',
      'home': home,
      'away': away,
      'homeResult': homeResult,
      'awayResult': awayResult,
      'dateTime': dateTime,
    }
    };
    Map<String, String> scorerByMinutesHome = {},
        scorerByMinutesAway = {};
    goalHome.forEachIndexed((e, i) => scorerByMinutesHome[homeMinutesGoal[i]] = e.mainEventPlayer!);
    goalAway.forEachIndexed((e, i) =>
    scorerByMinutesAway[awayMinuitesGoal[i]] = e.mainEventPlayer!);
    map['homeGoals'] = scorerByMinutesHome;
    map['awayGoals'] = scorerByMinutesAway;

    return map;
  }*/
}
