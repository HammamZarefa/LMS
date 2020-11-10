import 'package:meta/meta.dart';

@immutable
abstract class LessonVideoEvent {}

class FetchEvent extends LessonVideoEvent {
    final int courseId;
    final int lessonId;

    FetchEvent(this.courseId, this.lessonId);
}
class CompleteLessonEvent extends LessonVideoEvent {
    final int courseId;
    final int lessonId;

    CompleteLessonEvent(this.courseId, this.lessonId);
}
