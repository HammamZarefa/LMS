import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String login;
  final String password;

  LoginEvent(this.login, this.password);
}

class RegisterEvent extends AuthEvent {
  final String login;
  final String email;
  final String password;

  RegisterEvent(this.login, this.email, this.password);
}

class CloseDialogEvent extends AuthEvent {}
