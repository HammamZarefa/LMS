import 'package:masterstudy_app/data/models/QuizResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuizScreenEvent {}

class FetchEvent extends QuizScreenEvent {
  final int courseId;
  final int lessonId;
  final QuizResponse quizResponse;

  FetchEvent(this.courseId, this.lessonId, this.quizResponse);
}
