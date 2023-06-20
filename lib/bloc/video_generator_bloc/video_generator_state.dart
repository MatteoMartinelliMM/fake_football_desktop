import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/event_type.dart';
import 'package:fake_football_desktop/model/sport_match.dart';

abstract class VideoGeneratorState {
  VideoGeneratorState copy();
}

class SportMatchesLoadedState extends VideoGeneratorState {
  List<SportMatch> sportMatches;
  Map<String, String> extByFileName;

  SportMatchesLoadedState(this.sportMatches, this.extByFileName);

  @override
  VideoGeneratorState copy() => SportMatchesLoadedState(sportMatches, extByFileName);
}

class SingleMatchLoadedState extends VideoGeneratorState {
  SportMatch sportMatch;
  List<String> actions;
  String videoExt;

  SingleMatchLoadedState(this.sportMatch, this.actions, this.videoExt);

  @override
  VideoGeneratorState copy() => SingleMatchLoadedState(sportMatch, actions, videoExt);
}

class GeneratingMediaState extends VideoGeneratorState {
  List<Event> events;
  SportMatch sm;
  String videoExt;
  int totDuration;
  List<String> deletedVideo;

  GeneratingMediaState(this.events, this.sm, this.videoExt, this.totDuration, this.deletedVideo);

  @override
  VideoGeneratorState copy() =>
      GeneratingMediaState(events, sm, videoExt, totDuration, deletedVideo);
}

class LoadPageState extends VideoGeneratorState {
  String msg;
  int? percentage;
  LoadPageState(this.msg,{this.percentage});

  @override
  VideoGeneratorState copy() => LoadPageState(msg);
}

class ErrorState extends VideoGeneratorState {
  String errorMsg;

  ErrorState(this.errorMsg);

  @override
  VideoGeneratorState copy() => ErrorState(errorMsg);
}

class EndJobState extends VideoGeneratorState {
  @override
  VideoGeneratorState copy() => EndJobState();
}

class CloseState extends VideoGeneratorState {
  @override
  VideoGeneratorState copy() => CloseState();
}

class ShowHighlightsState extends VideoGeneratorState {
  bool isViewed;

  ShowHighlightsState(this.isViewed);

  @override
  VideoGeneratorState copy() => ShowHighlightsState(isViewed);
}

class ChooseFakeMomentsState extends VideoGeneratorState {
  Map<EventType, List<Event>> fakeMomentsChoice;
  SportMatch sm;
  String videoExt;
  int totDuration;

  ChooseFakeMomentsState(this.fakeMomentsChoice, this.sm, this.videoExt, this.totDuration);

  @override
  VideoGeneratorState copy() =>
      ChooseFakeMomentsState(fakeMomentsChoice, sm, videoExt, totDuration);
}

class ChooseFakeMomentsEventsState extends VideoGeneratorState {
  List<Event> currEvents;
  String type;
  SportMatch sm;
  String videoExt;
  int totDuration;

  ChooseFakeMomentsEventsState(
      this.currEvents, this.type, this.sm, this.videoExt, this.totDuration);

  @override
  VideoGeneratorState copy() =>
      ChooseFakeMomentsEventsState(currEvents, type, sm, videoExt, totDuration);
}
