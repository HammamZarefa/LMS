import 'package:meta/meta.dart';

@immutable
abstract class LessonStreamEvent {}

class FetchEvent extends LessonStreamEvent {
    final int courseId;
    final int lessonId;

    FetchEvent(this.courseId, this.lessonId);
}
