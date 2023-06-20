// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/event_team.dart';
import 'package:fake_football_desktop/model/event_type.dart';
import 'package:fake_football_desktop/model/sport_match.dart';
import 'package:fake_football_desktop/model/view_model/match_resume_model.dart';
import 'package:fake_football_desktop/tracking_database.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:isar/isar.dart';

class TrackingRepository {
  int insertEventSync(Event e) =>
      TrackingDatabase.db.writeTxnSync(() => TrackingDatabase.db.events.putSync(e));

  int insertMatchSync(SportMatch m) =>
      TrackingDatabase.db.writeTxnSync(() => TrackingDatabase.db.sportMatchs.putSync(m));

  bool deleteMatchSync(SportMatch m) =>
      TrackingDatabase.db.writeTxnSync(() => TrackingDatabase.db.sportMatchs.deleteSync(m.id));

  Future<SportMatch?> getCurrentMatch() async =>
      (await TrackingDatabase.db.sportMatchs.where(distinct: true).findAll())
          .toList()
          .firstOrNullWhere((sm) => sm.isCurrent);

  Future<void> markAllMatchAsNotCurrrent() async {
    List<SportMatch> sm = (await TrackingDatabase.db.sportMatchs
            .where(distinct: true)
            .filter()
            .isCurrentEqualTo(true)
            .findAll())
        .toList();
    sm.forEach((s) => s.isCurrent = false);
    updateAllMatchesSync(sm);
    return;
  }

  List<int> updateAllMatchesSync(List<SportMatch> matches) =>
      TrackingDatabase.db.writeTxnSync(() => TrackingDatabase.db.sportMatchs.putAllSync(matches));

  MatchResumeModel getResumeBySquads(SportMatch s)  {

    List<Event> homeGoals = [], awayGoals = [];
    s.events
        .where((e) =>
            !e.mainEventPlayer.isNullOrEmpty() &&
            !e.matchTime.isNullOrEmpty() &&
            (e.type == EventType.GOAL || e.type == EventType.RIGORI))
        .forEach((e) => e.team == EventTeam.HOME ? homeGoals.add(e) : awayGoals.add(e));
    homeGoals.sort((a, b) => a.id.compareTo(b.id));
    awayGoals.sort((a, b) => a.id.compareTo(b.id));
    Map<String, List<String>> homeScorer = {}, awayScorer = {};
    homeGoals.forEach(
      (s) => homeScorer.containsKey(s.mainEventPlayer)
          ? homeScorer[s.mainEventPlayer]!
              .add(s.matchTime! + (s.type == EventType.RIGORI ? '(R)' : ''))
          : homeScorer[s.mainEventPlayer!] = [
              (s.matchTime! + (s.type == EventType.RIGORI ? '(R)' : ''))
            ],
    );
    awayGoals.forEach(
      (s) => awayScorer.containsKey(s.mainEventPlayer)
          ? awayScorer[s.mainEventPlayer]!.add(s.matchTime!)
          : awayScorer[s.mainEventPlayer!] = [s.matchTime!],
    );
    return MatchResumeModel(
        s.home, s.away, homeScorer, awayScorer, s.homeResult, s.awayResult, s.state);
  }

  Future<MatchResumeModel?> getResumeFromFirstMatch() async {
    SportMatch? s = await TrackingDatabase.db.sportMatchs.where(distinct: true).findFirst();
    if (s != null) {
      return await getResumeBySquads(s);
    }
    return null;
  }


}
