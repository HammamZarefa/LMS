import 'package:meta/meta.dart';

@immutable
abstract class VideoEvent {}

class FetchEvent extends VideoEvent {
    final String title;
    final String videoLink;

    FetchEvent(this.title, this.videoLink);
}