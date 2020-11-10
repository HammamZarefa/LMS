import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/repository/account_repository.dart';

import './bloc.dart';

@provide
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final AccountRepository _repository;
  Account account;

  EditProfileBloc(this._repository);

  @override
  EditProfileState get initialState => InitialEditProfileState();

  @override
  Stream<EditProfileState> mapEventToState(
    EditProfileEvent event,
  ) async* {
    if (event is SaveEvent) {
      yield* _mapSaveEventToState(event);
    }
    if (event is CloseScreenEvent) {
      yield CloseEditProfileState();
    }
  }

  Stream<EditProfileState> _mapSaveEventToState(event) async* {
    try {
      yield LoadingEditProfileState();
      await _repository.editProfile(event.firstName, event.lastName,
          event.password, event.description, event.position, event.facebook,event.twitter,event.instagram,
          photo: event.photo);
      await Future.delayed(Duration(milliseconds: 1000));
      yield CloseEditProfileState();
    } catch (e, s) {
      print(e);
      print(s);
      yield ErrorEditProfileState();
      yield InitialEditProfileState();
    }
  }
}
