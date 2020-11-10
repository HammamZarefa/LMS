import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/FinalResponse.dart';
import 'package:masterstudy_app/data/repository/final_repository.dart';

import './bloc.dart';

@provide
class FinalBloc extends Bloc<FinalEvent, FinalState> {
    final FinalRepository _finalRepository;

    FinalBloc(this._finalRepository);

    @override
    FinalState get initialState => InitialFinalState();

    @override
    Stream<FinalState> mapEventToState (
        FinalEvent event
        ) async* {
        if (event is FetchEvent) {
            try {
                FinalResponse response = await _finalRepository.getCourseResults(event.courseId);

                print(response);

                yield LoadedFinalState(response);
            } catch(error) {
                print('Final Page Error');
                print(error);
            }
        }
    }
}