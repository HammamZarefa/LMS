import 'package:masterstudy_app/data/models/QuestionsResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuestionsState {}

class InitialQuestionsState extends QuestionsState {}

class LoadedQuestionsState extends QuestionsState {
    final QuestionsResponse questionsResponseAll;
    final QuestionsResponse questionsResponseMy;

    LoadedQuestionsState(this.questionsResponseAll, this.questionsResponseMy);
}

class LoadedMyQuestionsState extends QuestionsState {
    final QuestionsResponse questionsResponseAll;
    final QuestionsResponse questionsResponseMy;

    LoadedMyQuestionsState(this.questionsResponseAll, this.questionsResponseMy);
}

class ErrorQuestionsState extends QuestionsState {}
