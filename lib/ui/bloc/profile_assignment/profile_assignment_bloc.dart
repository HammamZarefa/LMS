import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';

import './bloc.dart';

@provide
class ProfileAssignmentBloc extends Bloc<ProfileAssignmentEvent, ProfileAssignmentState> {

    ProfileAssignmentBloc();

    @override
    ProfileAssignmentState get initialState => InitialProfileAssignmentState();

    @override
    Stream<ProfileAssignmentState> mapEventToState (
        ProfileAssignmentEvent event,
    ) async* { }
}