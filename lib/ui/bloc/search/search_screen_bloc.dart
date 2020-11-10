import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/data/repository/courses_repository.dart';

import './bloc.dart';

@provide
class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc(this._coursesRepository);

  @override
  SearchScreenState get initialState => InitialSearchScreenState();

  final CoursesRepository _coursesRepository;
  List<String> _popularSearches;
  List<CoursesBean> _newCourses;

  @override
  Stream<SearchScreenState> mapEventToState(
    SearchScreenEvent event,
  ) async* {
    if (event is FetchEvent) {
      yield* _mapFetchToState();
    }
  }

  Stream<SearchScreenState> _mapFetchToState() async* {
    if (state is ErrorSearchScreenState) yield InitialSearchScreenState();
    if (_popularSearches == null || _newCourses == null) {
      yield InitialSearchScreenState();
      try {
        _newCourses =
            (await _coursesRepository.getCourses(sort: Sort.date_low)).courses;
        _popularSearches =
            (await _coursesRepository.getPopularSearches()).searches;
        yield LoadedSearchScreenState(_newCourses, _popularSearches);
      } catch (_) {
        yield ErrorSearchScreenState();
      }
    }

  }
}
