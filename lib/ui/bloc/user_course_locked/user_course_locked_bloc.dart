import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/user_course_repository.dart';

import './bloc.dart';

@provide
class UserCourseLockedBloc extends Bloc<UserCourseLockedEvent, UserCourseLockedState> {
  final UserCourseRepository _repository;

  UserCourseLockedBloc(this._repository);

  @override
  UserCourseLockedState get initialState => InitialUserCourseLockedState();

  @override
  Stream<UserCourseLockedState> mapEventToState(
    UserCourseLockedEvent event,
  ) async* {
    if (event is FetchEvent) {
        try{
          var response = await _repository.getCourse(event.courseId);
          yield LoadedUserCourseLockedState(response);
        }catch(e,s){
          print(e);
          print(s);
        }

    }
  }
}
