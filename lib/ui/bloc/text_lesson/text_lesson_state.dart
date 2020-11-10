import 'package:masterstudy_app/data/models/LessonResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TextLessonState {}

class InitialTextLessonState extends TextLessonState {}

class LoadedTextLessonState extends TextLessonState {
  final LessonResponse lessonResponse;

  LoadedTextLessonState(this.lessonResponse);
}
