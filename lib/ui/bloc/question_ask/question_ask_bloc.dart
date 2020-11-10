import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/QuestionAddResponse.dart';
import 'package:masterstudy_app/data/repository/questions_repository.dart';

import './bloc.dart';

@provide
class QuestionAskBloc extends Bloc<QuestionAskEvent, QuestionAskState> {
    final QuestionsRepository _questionsRepository;

    QuestionAskBloc (this._questionsRepository);

    @override
    QuestionAskState get initialState => InitialQuestionAskState();

    @override
    Stream<QuestionAskState> mapEventToState(
        QuestionAskEvent event
    ) async* {
        if(event is QuestionAddEvent) {
            try {
                QuestionAddResponse addAnswer = await _questionsRepository
                    .addQuestion(event.lessonId, event.comment, 0);
                yield QuestionAddedState(addAnswer);
            } catch(error) {
                print(error);
            }
        }

        yield LoadedQuestionAskState();
    }
}