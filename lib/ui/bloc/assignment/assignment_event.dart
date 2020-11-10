import 'dart:io';

import 'package:meta/meta.dart';

@immutable
abstract class AssignmentEvent {}

class FetchEvent extends AssignmentEvent {
    final int courseId;
    final int assignmentId;

    FetchEvent(this.courseId, this.assignmentId);
}

class StartAssignmentEvent extends AssignmentEvent {
    final int courseId;
    final int assignmentId;

    StartAssignmentEvent(this.courseId, this.assignmentId);
}

class AddAssignmentEvent extends AssignmentEvent {
    final int courseId;
    final int assignmentId;
    final int userAssignmentId;
    final String content;
    final List<File> files;

    AddAssignmentEvent(this.courseId, this.assignmentId, this.userAssignmentId, this.content, this.files);
}