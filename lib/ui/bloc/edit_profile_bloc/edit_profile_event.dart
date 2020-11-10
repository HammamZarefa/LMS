import 'dart:io';

import 'package:meta/meta.dart';

@immutable
abstract class EditProfileEvent {}

class SaveEvent extends EditProfileEvent {
  final String firstName;
  final String lastName;
  final String password;
  final String description;
  final String position;
  final String facebook;
  final String twitter;
  final String instagram;
  final File photo;

  SaveEvent(
    this.firstName,
    this.lastName,
    this.password,
    this.description,
    this.position,
    this.facebook,
    this.twitter,
    this.instagram,
    this.photo,
  );
}

class CloseScreenEvent extends EditProfileEvent {}
