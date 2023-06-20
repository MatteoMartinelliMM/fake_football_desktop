import 'package:fake_football_desktop/model/event_type.dart';

abstract class VideoGeneratorEvent {}

class StartCreatingFileEvent extends VideoGeneratorEvent {}

class EnterPageEvent extends VideoGeneratorEvent {}

class VideoClickEvent extends VideoGeneratorEvent {
  int position;
  bool isHighlights;

  VideoClickEvent(this.position, {this.isHighlights = false});
}

class ClipTimeChangeEvent extends VideoGeneratorEvent {
  int position;
  String startOrEnd;
  bool add;

  ClipTimeChangeEvent(this.position, this.startOrEnd, this.add);
}

class SportMatchPickedEvent extends VideoGeneratorEvent {
  int position;

  SportMatchPickedEvent(this.position);
}

class MediaTypeSelectedEvent extends VideoGeneratorEvent {
  String mediaType;

  MediaTypeSelectedEvent(this.mediaType);
}

class VideoChangeEvent extends VideoGeneratorEvent {}

class ReClipVideoEvent extends VideoGeneratorEvent {
  int position;

  ReClipVideoEvent(this.position);
}

class RemoveClipEvent extends VideoGeneratorEvent {
  int position;

  RemoveClipEvent(this.position);
}

class OverflowMenuEvent extends VideoGeneratorEvent {
  String action;

  OverflowMenuEvent(this.action);
}

class NextEvent extends VideoGeneratorEvent {}

class MarkVideoAsFavouriteEvent extends VideoGeneratorEvent {
  int position;

  MarkVideoAsFavouriteEvent(this.position);
}

class FakeMomentsPickedEvent extends VideoGeneratorEvent {
  EventType type;

  FakeMomentsPickedEvent(this.type);
}

class FakeMomentsCheckedEvent extends VideoGeneratorEvent {
  bool checked;
  int position;

  FakeMomentsCheckedEvent(this.checked, this.position);
}

class BackPressEvent extends VideoGeneratorEvent {}

class HighlightsBuildedEvent extends VideoGeneratorEvent {}

class ErrorEvent extends VideoGeneratorEvent {
  String errorMsg;

  ErrorEvent(this.errorMsg);
}

class LoadProgressEvent extends VideoGeneratorEvent {
  int millis;

  LoadProgressEvent(this.millis);
}
