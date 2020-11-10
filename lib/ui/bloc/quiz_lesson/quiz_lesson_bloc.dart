import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/lesson_repository.dart';
import './bloc.dart';

@provide
class QuizLessonBloc extends Bloc<QuizLessonEvent, QuizLessonState> {

  final LessonRepository repository;

  QuizLessonBloc(this.repository);

  @override
  QuizLessonState get initialState => InitialQuizLessonState();

  @override
  Stream<QuizLessonState> mapEventToState(
    QuizLessonEvent event,
  ) async* {
    if (event is FetchEvent) {
      try{
        var response = await repository.getQuiz(event.courseId, event.lessonId);
        yield LoadedQuizLessonState(response);
      }catch(e,s){
        print(e);
        print(s);
      }
    }
  }
}
