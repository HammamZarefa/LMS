import 'package:meta/meta.dart';

@immutable
abstract class QuizLessonEvent {}

class FetchEvent extends QuizLessonEvent {
  final int courseId;
  final int lessonId;

  FetchEvent(this.courseId, this.lessonId);
}
