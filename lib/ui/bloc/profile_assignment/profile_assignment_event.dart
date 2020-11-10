import 'package:meta/meta.dart';

@immutable
abstract class ProfileAssignmentEvent {}

class FetchEvent extends ProfileAssignmentEvent {}