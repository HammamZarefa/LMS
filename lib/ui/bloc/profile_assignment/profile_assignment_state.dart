import 'package:meta/meta.dart';

@immutable
abstract class ProfileAssignmentState {}

class InitialProfileAssignmentState extends ProfileAssignmentState {}

class LoadedProfileAssignmentState extends ProfileAssignmentState {
    LoadedProfileAssignmentState();
}

class ErrorProfileAssignmentState extends ProfileAssignmentState {}