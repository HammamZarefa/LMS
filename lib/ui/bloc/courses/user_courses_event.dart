import 'package:equatable/equatable.dart';

abstract class UserCoursesEvent extends Equatable {
  const UserCoursesEvent();
}

class FetchEvent extends UserCoursesEvent {
  @override
  List<Object> get props => null;
}

