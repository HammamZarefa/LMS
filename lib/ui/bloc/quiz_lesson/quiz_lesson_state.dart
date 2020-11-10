import 'package:masterstudy_app/data/models/QuizResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuizLessonState {}

class InitialQuizLessonState extends QuizLessonState {}

class LoadedQuizLessonState extends QuizLessonState {
  final QuizResponse quizResponse;

  LoadedQuizLessonState(this.quizResponse);
}
