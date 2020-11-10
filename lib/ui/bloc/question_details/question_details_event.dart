import 'package:meta/meta.dart';

@immutable
abstract class QuestionDetailsEvent {}

class FetchEvent extends QuestionDetailsEvent {
    FetchEvent();
}

class QuestionAddEvent extends QuestionDetailsEvent {
    final int lessonId;
    final String comment;
    final int parent;

        QuestionAddEvent(this.lessonId, this.comment, this.parent);
}