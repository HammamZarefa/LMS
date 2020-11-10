import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/repository/account_repository.dart';
import 'package:masterstudy_app/data/repository/courses_repository.dart';

import './bloc.dart';

@provide
class DetailProfileBloc extends Bloc<DetailProfileEvent, DetailProfileState> {
  final AccountRepository _repository;
  final CoursesRepository _coursesRepository;

  DetailProfileBloc(this._repository, this._coursesRepository);

  @override
  DetailProfileState get initialState => InitialDetailProfileState();

  Account account;
  int _teacherId;

  void setAccount(Account account) {
    this.account = account;
  }

  @override
  Stream<DetailProfileState> mapEventToState(
    DetailProfileEvent event,
  ) async* {
    if (event is LoadDetailProfile) {
      yield* _mapLoadToState();
    }
  }

  Stream<DetailProfileState> _mapLoadToState() async* {
    if (account == null) {
      try {
        account = await _repository.getAccountById(_teacherId);
        var courses = await _coursesRepository.getCourses(authorId: _teacherId);
        yield LoadedDetailProfileState(courses.courses, true);
      } catch (e, s) {
        print(e);
        print(s);
      }
    } else {
      yield LoadedDetailProfileState(null, false);
    }
  }

  void setTeacherId(int teacherId) {
    _teacherId = teacherId;
  }
}
