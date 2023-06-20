import 'package:fake_football_desktop/model/event_status.dart';
import 'package:fake_football_desktop/model/event_team.dart';
import 'package:fake_football_desktop/model/event_type.dart';
import 'package:fake_football_desktop/model/sport_match.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:isar/isar.dart';

part 'event.g.dart';

@collection
class Event {
  Id id = Isar.autoIncrement;
  late String partita;
  late String clickTime;
  late String startClip;
  late String endClip;
  String? mainEventPlayer;
  String? description;
  String? matchTime;
  int? matchTimeMillis;
  late int clickMillis;
  late int endMillis;
  late int startMillis;
  bool isFavourite = false;
  bool deleted = false;
  bool isFakeMoment = false;
  bool success = true;
  @Enumerated(EnumType.name)
  EventTeam team = EventTeam.HOME;
  @Enumerated(EnumType.name)
  EventStatus status = EventStatus.NOT_EXIST;
  @Enumerated(EnumType.name)
  EventType type = EventType.NONE;
  @Backlink(to: 'events')
  final game = IsarLink<SportMatch>();

  Event();

  String fileName() =>
      type != EventType.FINE_PRIMO_TEMPO ? '${id}_${type.getLabel()}' : PLACEHOLDER_2T;

  bool isPlaceHolder() => type == EventType.FINE_PRIMO_TEMPO;

  Event.fromJson(Map json) {
    clickTime = json['clickTime'];
    startClip = json['clipStart'];
    endClip = json['endClip'];
    id = json['id'];
    partita = json['partita'];
    description = json['description'];
    isFavourite = json['isFavourite'] ?? false;
    isFakeMoment = json['isFakeMoment'] ?? false;
    success = json['success'] ?? false;
    deleted = json['deleted'] ?? false;
    clickMillis = json['clickMillis'];
    endMillis = json['endMillis'];
    startMillis = json['startMillis'];
    matchTime = json['matchTime'];
    matchTimeMillis = json['matchTimeMillis'];
    status = EventStatus.values.byName(json['status'] ?? EventStatus.NOT_EXIST.enumName());
    type = EventType.values.byName(json['type'] ?? EventType.NONE.enumName());
    team = EventTeam.values.byName(json['team'] ?? EventTeam.HOME.enumName());
  }

  Map toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['clickTime'] = clickTime;
    data['clipStart'] = startClip;
    data['endClip'] = endClip;
    data['id'] = id;
    data['partita'] = partita;
    data['deleted'] = deleted;
    data['description'] = description;
    data['isFavourite'] = isFavourite;
    data['isFakeMoment'] = isFakeMoment;
    data['clickMillis'] = clickMillis;
    data['endMillis'] = endMillis;
    data['startMillis'] = startMillis;
    data['matchTime'] = matchTime;
    data['matchTimeMilis'] = matchTimeMillis;
    data['status'] = status.enumName();
    data['type'] = type.enumName();
    data['team'] = team.enumName();
    return data;
  }
}
