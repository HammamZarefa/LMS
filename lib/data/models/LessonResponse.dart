import 'package:json_annotation/json_annotation.dart';

part 'LessonResponse.g.dart';

@JsonSerializable()
class LessonResponse {
  SectionBean section;
  String title;
  String type;
  String content;
  String video;
  String video_poster;
  String prev_lesson_type;
  String next_lesson_type;
  String prev_lesson;
  String next_lesson;
  bool completed;
  bool next_lesson_available;

  LessonResponse({this.section, this.title, this.type, this.content, this.video, this.video_poster, this.prev_lesson_type, this.next_lesson_type, this.prev_lesson, this.next_lesson, this.completed, this.next_lesson_available});

  factory LessonResponse.fromJson(Map<String, dynamic> json) => _$LessonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LessonResponseToJson(this);
}

@JsonSerializable()
class SectionBean {
  String label;
  String number;
  num index;

  SectionBean({this.label, this.number, this.index});

  factory SectionBean.fromJson(Map<String, dynamic> json) => _$SectionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SectionBeanToJson(this);
}

