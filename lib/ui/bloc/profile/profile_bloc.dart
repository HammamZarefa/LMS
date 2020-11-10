import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/repository/account_repository.dart';
import 'package:masterstudy_app/data/repository/auth_repository.dart';

import './bloc.dart';

@provide
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountRepository _accountRepository;
  final AuthRepository _authRepository;

  Account account;

  ProfileBloc(this._accountRepository, this._authRepository);

  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfileEvent) {
      yield* _mapFetchToState(event);
    }
    if (event is UpdateProfileEvent) {
      yield InitialProfileState();
      yield* _mapFetchToState(event);
    }
    if (event is LogoutProfileEvent) {
      await _authRepository.logout();
      yield LogoutProfileState();
    }
  }

  Stream<ProfileState> _mapFetchToState(event) async* {
    try {
      Account account = await _accountRepository.getUserAccount();
      yield LoadedProfileState(account);
    } catch (excaption, stacktrace) {
      print(excaption);
      print(stacktrace);
    }
  }
}
