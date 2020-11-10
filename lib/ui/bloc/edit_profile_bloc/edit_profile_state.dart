import 'package:meta/meta.dart';

@immutable
abstract class EditProfileState {}

class InitialEditProfileState extends EditProfileState {}

class LoadingEditProfileState extends EditProfileState {}

class CloseEditProfileState extends EditProfileState {}

class ErrorEditProfileState extends EditProfileState {}
