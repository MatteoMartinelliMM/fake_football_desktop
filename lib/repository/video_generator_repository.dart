import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/sport_match.dart';
import 'package:fake_football_desktop/tracking_database.dart';
import 'package:isar/isar.dart';

class VideoGeneratorRepository {
  Future<List<SportMatch>> getAllSportMatches() async =>
      (await TrackingDatabase.db.sportMatchs.where().findAll()).toList()
        ..sort(
              (a, b) => a.dateTime?.compareTo(b.dateTime ?? '0') ?? 0,
        );

  List<int> updateMatchesSync(List<Event> events) =>
      TrackingDatabase.db
          .writeTxnSync<List<int>>(() => TrackingDatabase.db.events.putAllSync(events));

  int saveEventSync(Event event) =>
      TrackingDatabase.db.writeTxnSync<int>(() => TrackingDatabase.db.events.putSync(event));





}
