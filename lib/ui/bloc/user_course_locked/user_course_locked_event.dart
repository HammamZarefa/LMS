import 'package:meta/meta.dart';

@immutable
abstract class UserCourseLockedEvent {}

class FetchEvent extends UserCourseLockedEvent {
  final int courseId;

  FetchEvent(this.courseId);
}
