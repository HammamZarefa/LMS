import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchDetailState {}

class InitialSearchDetailState extends SearchDetailState {}

class LoadingSearchDetailState extends SearchDetailState {}

class LoadedSearchDetailState extends SearchDetailState {
  final List<CoursesBean> courses;

  LoadedSearchDetailState(this.courses);
}

class NotingFoundSearchDetailState extends SearchDetailState {}

class ErrorSearchDetailState extends SearchDetailState {}
