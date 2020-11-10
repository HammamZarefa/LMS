import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/category.dart';
import 'package:masterstudy_app/data/repository/courses_repository.dart';
import 'package:masterstudy_app/data/repository/home_repository.dart';

import './bloc.dart';

@provide
class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final HomeRepository _homeRepository;
  final CoursesRepository _coursesRepository;

  CategoryDetailBloc(this._homeRepository, this._coursesRepository);

  @override
  CategoryDetailState get initialState => InitialCategoryDetailState();

  @override
  Stream<CategoryDetailState> mapEventToState (
      CategoryDetailEvent event,
  ) async* {
    if(event is FetchEvent) {
      yield InitialCategoryDetailState();
      try {
        var categories = await _homeRepository.getCategories();
        var courses = await _coursesRepository.getCourses(categoryId: event.categoryId);

        yield LoadedCategoryDetailState(
          categories,
          courses.courses
        );
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        yield ErrorCategoryDetailState(event.categoryId);
      }
    }
  }
}