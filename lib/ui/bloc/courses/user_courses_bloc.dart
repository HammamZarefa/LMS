import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/user_course.dart';
import 'package:masterstudy_app/data/repository/user_course_repository.dart';

import './bloc.dart';

@provide
class UserCoursesBloc extends Bloc<UserCoursesEvent, UserCoursesState> {
  UserCoursesBloc(this._userCourseRepository);

  @override
  UserCoursesState get initialState => InitialUserCoursesState();

  final UserCourseRepository _userCourseRepository;

  @override
  Stream<UserCoursesState> mapEventToState(
    UserCoursesEvent event,
  ) async* {
    if (event is FetchEvent) {
      yield* _mapFetchToState();
    }
  }

  Stream<UserCoursesState> _mapFetchToState() async* {
    if(state is ErrorUserCoursesState) yield InitialUserCoursesState();
    try {
      UserCourseResponse response =
          await _userCourseRepository.getUserCourses();
      if (response.posts.isEmpty) {
        yield EmptyCoursesState();
      } else {
        yield LoadedCoursesState(response.posts);
        print(response.posts.length);
      }
    } catch (e, s) {
      print(e);
      print(s);
      yield ErrorUserCoursesState();
    }
  }
}
