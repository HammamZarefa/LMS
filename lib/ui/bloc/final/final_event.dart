import 'package:masterstudy_app/data/models/FinalResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FinalEvent {}

class FetchEvent extends FinalEvent {
    final int courseId;
    FetchEvent(this.courseId);
}