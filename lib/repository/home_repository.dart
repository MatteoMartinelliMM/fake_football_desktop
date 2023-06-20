import 'dart:io';

import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/tracking_database.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/repository/api_firebase_service.dart';
import 'package:isar/isar.dart';

class HomeRepository {
  Future<String> checkStatus() async {
    Map<String, dynamic>? status = await ApiFirebaseService().getFromUrl(path: [CURRENT_GAME]);
    if (status != null) {
      bool haveDoneContent = status[CONTENT_DONE] == true;
      return haveDoneContent ? ALL_DONE : CONFERMA_CONVOCATI;
    }
    return CONVOCA_GIOCATORI;
  }

  Future<void> exportDb() async => await TrackingDatabase().exportDatabase();

  Future<bool> haveGameToClip() async =>
      await TrackingDatabase.db.events.where(distinct: true).isNotEmpty();
}

