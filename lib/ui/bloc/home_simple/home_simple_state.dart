import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeSimpleState {}

class InitialHomeSimpleState extends HomeSimpleState {}

class LoadedHomeSimpleState extends HomeSimpleState {
  final List<CoursesBean> coursesNew;

  LoadedHomeSimpleState(this.coursesNew);
}

class ErrorHomeSimpleState extends HomeSimpleState {}