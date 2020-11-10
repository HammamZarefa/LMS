import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/user_course_repository.dart';

import './bloc.dart';

@provide
class UserCourseBloc extends Bloc<UserCourseEvent, UserCourseState> {
  final UserCourseRepository _repository;

  UserCourseBloc(this._repository);

  @override
  UserCourseState get initialState => InitialUserCourseState();

  @override
  Stream<UserCourseState> mapEventToState(
    UserCourseEvent event,
  ) async* {
    if (event is FetchEvent) {
      if(state is ErrorUserCourseState) yield InitialUserCourseState();
      try {
        var response = await _repository.getCourseCurriculum(event.courseId);
        yield LoadedUserCourseState(
            response.sections,
            response.progress_percent,
            response.current_lesson_id,
            response.lesson_type);
      } catch (e, s) {
        print(e);
        print(s);
        yield(ErrorUserCourseState());
      }
    }
  }
}
