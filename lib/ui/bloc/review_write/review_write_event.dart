import 'package:meta/meta.dart';

@immutable
abstract class ReviewWriteEvent {}

class FetchEvent extends ReviewWriteEvent {
    final int courseId;

    FetchEvent(this.courseId);
}

class SaveReviewEvent extends ReviewWriteEvent {
    final int id;
    final int mark;
    final String review;

    SaveReviewEvent(this.id, this.mark, this.review);
}