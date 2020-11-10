// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuizResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) {
  return QuizResponse(
    section: json['section'] == null
        ? null
        : SectionBean.fromJson(json['section'] as Map<String, dynamic>),
    title: json['title'] as String,
    type: json['type'] as String,
    content: json['content'] as String,
    video: json['video'] as String,
    prev_lesson_type: json['prev_lesson_type'] as String,
    next_lesson_type: json['next_lesson_type'] as String,
    prev_lesson: json['prev_lesson'] as String,
    next_lesson: json['next_lesson'] as String,
    view_link: json['view_link'] as String,
    quiz_data: (json['quiz_data'] as List)
        ?.map((e) => e == null
            ? null
            : Quiz_dataBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    time: json['time'] as num,
    time_left: json['time_left'] as num,
    quiz_time: json['quiz_time'],
  );
}

Map<String, dynamic> _$QuizResponseToJson(QuizResponse instance) =>
    <String, dynamic>{
      'section': instance.section,
      'title': instance.title,
      'type': instance.type,
      'content': instance.content,
      'video': instance.video,
      'prev_lesson_type': instance.prev_lesson_type,
      'next_lesson_type': instance.next_lesson_type,
      'prev_lesson': instance.prev_lesson,
      'next_lesson': instance.next_lesson,
      'view_link': instance.view_link,
      'quiz_data': instance.quiz_data,
      'time': instance.time,
      'time_left': instance.time_left,
      'quiz_time': instance.quiz_time,
    };

Quiz_dataBean _$Quiz_dataBeanFromJson(Map<String, dynamic> json) {
  return Quiz_dataBean(
    user_quiz_id: json['user_quiz_id'] as String,
    user_id: json['user_id'] as String,
    course_id: json['course_id'] as String,
    quiz_id: json['quiz_id'] as String,
    progress: json['progress'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$Quiz_dataBeanToJson(Quiz_dataBean instance) =>
    <String, dynamic>{
      'user_quiz_id': instance.user_quiz_id,
      'user_id': instance.user_id,
      'course_id': instance.course_id,
      'quiz_id': instance.quiz_id,
      'progress': instance.progress,
      'status': instance.status,
    };

SectionBean _$SectionBeanFromJson(Map<String, dynamic> json) {
  return SectionBean(
    label: json['label'] as String,
    number: json['number'] as String,
  );
}

Map<String, dynamic> _$SectionBeanToJson(SectionBean instance) =>
    <String, dynamic>{
      'label': instance.label,
      'number': instance.number,
    };
