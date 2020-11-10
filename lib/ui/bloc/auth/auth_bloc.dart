import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/auth_repository.dart';

import './bloc.dart';

@provide
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository);

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is RegisterEvent) {
      yield* _mapRegisterEventToState(event);
    }
    if (event is LoginEvent) {
      yield* _mapSignInEventToState(event);
    }

    if (event is CloseDialogEvent) {
      yield InitialAuthState();
    }
  }

  Stream<AuthState> _errorToState(message) async* {
    yield ErrorAuthState(message);
    //yield InitialAuthState();
  }

  Stream<AuthState> _mapRegisterEventToState(event) async* {
    yield LoadingAuthState();
    try {
      await _repository.register(event.login, event.email, event.password);
      yield SuccessAuthState();
    } catch (error, stacktrace) {
      var errorData = json.decode(error.response.toString());

      yield* _errorToState(errorData['message']);
    }
  }

  Stream<AuthState> _mapSignInEventToState(event) async* {
    yield LoadingAuthState();
    try {
      await _repository.authUser(event.login, event.password);
      yield SuccessAuthState();
    } catch (error, stacktrace) {

      var errorData = json.decode(error.response.toString());

      yield* _errorToState(errorData['message']);
    }
  }
}
