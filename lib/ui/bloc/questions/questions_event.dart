import 'package:masterstudy_app/data/models/QuestionsResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuestionsEvent {}

class FetchEvent extends QuestionsEvent {
    final int lessonId;
    final int page;
    final String search;
    final String authorIn;


    FetchEvent(this.lessonId, this.page, this.search, this.authorIn);
}

class MyQuestionAddEvent extends QuestionsEvent {
    final QuestionsResponse questionsResponse;
    final int lessonId;
    final String comment;
    final int parent;

    MyQuestionAddEvent(this.questionsResponse, this.lessonId, this.comment, this.parent);
}