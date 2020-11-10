import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/LessonResponse.dart';
import 'package:masterstudy_app/data/repository/lesson_repository.dart';

import './bloc.dart';

@provide
class LessonVideoBloc extends Bloc<LessonVideoEvent, LessonVideoState> {
    final LessonRepository _lessonRepository;

    LessonVideoBloc(this._lessonRepository);

    @override
    LessonVideoState get initialState => InitialLessonVideoState();

    @override
    Stream<LessonVideoState> mapEventToState(
        LessonVideoEvent event,
        ) async* {
        if (event is FetchEvent) {
            try {

                LessonResponse response = await _lessonRepository.getLesson(event.courseId, event.lessonId);

                yield LoadedLessonVideoState(response);
            } catch(error) {
                print(error);
            }
        }else if (event is CompleteLessonEvent){
            try{
                var response = await _lessonRepository.completeLesson(event.courseId, event.lessonId);
            }catch(e,s){
                print(e);
                print(s);
            }
        }
    }
}
