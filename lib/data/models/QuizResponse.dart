import 'package:json_annotation/json_annotation.dart';

part 'QuizResponse.g.dart';

@JsonSerializable()
class QuizResponse {
  SectionBean section;
  String title;
  String type;
  String content;
  String video;
  String prev_lesson_type;
  String next_lesson_type;
  String prev_lesson;
  String next_lesson;
  String view_link;
  List<Quiz_dataBean> quiz_data;
  num time;
  num time_left;
  dynamic quiz_time;

  QuizResponse({this.section, this.title, this.type, this.content, this.video, this.prev_lesson_type, this.next_lesson_type, this.prev_lesson, this.next_lesson, this.view_link, this.quiz_data, this.time, this.time_left, this.quiz_time});

  factory QuizResponse.fromJson(Map<String, dynamic> json) => _$QuizResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResponseToJson(this);
}

@JsonSerializable()
class Quiz_dataBean {
  String user_quiz_id;
  String user_id;
  String course_id;
  String quiz_id;
  String progress;
  String status;

  Quiz_dataBean({this.user_quiz_id, this.user_id, this.course_id, this.quiz_id, this.progress, this.status});

  factory Quiz_dataBean.fromJson(Map<String, dynamic> json) => _$Quiz_dataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Quiz_dataBeanToJson(this);
}

@JsonSerializable()
class SectionBean {
  String label;
  String number;

  SectionBean({this.label, this.number});

  factory SectionBean.fromJson(Map<String, dynamic> json) => _$SectionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SectionBeanToJson(this);
}

