// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LessonResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonResponse _$LessonResponseFromJson(Map<String, dynamic> json) {
  return LessonResponse(
    section: json['section'] == null
        ? null
        : SectionBean.fromJson(json['section'] as Map<String, dynamic>),
    title: json['title'] as String,
    type: json['type'] as String,
    content: json['content'] as String,
    video: json['video'] as String,
    video_poster: json['video_poster'] as String,
    prev_lesson_type: json['prev_lesson_type'] as String,
    next_lesson_type: json['next_lesson_type'] as String,
    prev_lesson: json['prev_lesson'] as String,
    next_lesson: json['next_lesson'] as String,
    completed: json['completed'] as bool,
    next_lesson_available: json['next_lesson_available'] as bool,
  );
}

Map<String, dynamic> _$LessonResponseToJson(LessonResponse instance) =>
    <String, dynamic>{
      'section': instance.section,
      'title': instance.title,
      'type': instance.type,
      'content': instance.content,
      'video': instance.video,
      'video_poster': instance.video_poster,
      'prev_lesson_type': instance.prev_lesson_type,
      'next_lesson_type': instance.next_lesson_type,
      'prev_lesson': instance.prev_lesson,
      'next_lesson': instance.next_lesson,
      'completed': instance.completed,
      'next_lesson_available': instance.next_lesson_available,
    };

SectionBean _$SectionBeanFromJson(Map<String, dynamic> json) {
  return SectionBean(
    label: json['label'] as String,
    number: json['number'] as String,
    index: json['index'] as num,
  );
}

Map<String, dynamic> _$SectionBeanToJson(SectionBean instance) =>
    <String, dynamic>{
      'label': instance.label,
      'number': instance.number,
      'index': instance.index,
    };
