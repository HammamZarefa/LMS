import 'package:meta/meta.dart';

@immutable
abstract class TextLessonEvent {}

class FetchEvent extends TextLessonEvent {
  final int courseId;
  final int lessonId;

  FetchEvent(this.courseId, this.lessonId);
}
class CompleteLessonEvent extends TextLessonEvent {
  final int courseId;
  final int lessonId;

  CompleteLessonEvent(this.courseId, this.lessonId);
}
