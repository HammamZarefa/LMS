import 'package:meta/meta.dart';

@immutable
abstract class UserCourseEvent {}

class FetchEvent extends UserCourseEvent {
  final int courseId;

  FetchEvent(this.courseId);
}
