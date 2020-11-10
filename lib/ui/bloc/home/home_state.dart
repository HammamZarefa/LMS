import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/data/models/InstructorsResponse.dart';
import 'package:masterstudy_app/data/models/category.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<Category> categoryList;
  final List<CoursesBean> coursesTranding;
  final List<CoursesBean> coursesNew;
  final List<CoursesBean> coursesFree;
  final List<InstructorBean> instructors;
  final List<HomeLayoutBean> layout;

  LoadedHomeState(this.categoryList, this.coursesTranding, this.layout,
      this.coursesNew, this.coursesFree, this.instructors);
}

class ErrorHomeState extends HomeState {}
