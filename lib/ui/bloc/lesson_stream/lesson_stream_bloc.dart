import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/lesson_repository.dart';

import './bloc.dart';

@provide
class LessonStreamBloc extends Bloc<LessonStreamEvent, LessonStreamState> {
    final LessonRepository repository;

    LessonStreamBloc(this.repository);

    @override
    LessonStreamState get initialState => InitialLessonStreamState();

    @override
    Stream<LessonStreamState> mapEventToState(
        LessonStreamEvent event,
        ) async* {
        if (event is FetchEvent) {
            try{
                var response = await repository.getLesson(event.courseId, event.lessonId);
                print(response);
                yield LoadedLessonStreamState(response);
            }catch(e,s){
                print(e);
                print(s);
            }
        }
    }
}
