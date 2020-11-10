import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {}

class LogoutProfileEvent extends ProfileEvent {}
