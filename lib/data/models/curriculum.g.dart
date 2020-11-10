// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurriculumResponse _$CurriculumResponseFromJson(Map<String, dynamic> json) {
  return CurriculumResponse(
    (json['sections'] as List)
        ?.map((e) =>
            e == null ? null : SectionItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['progress_percent'] as String,
    json['current_lesson_id'] as String,
    json['lesson_type'] as String,
  );
}

Map<String, dynamic> _$CurriculumResponseToJson(CurriculumResponse instance) =>
    <String, dynamic>{
      'sections': instance.sections,
      'progress_percent': instance.progress_percent,
      'current_lesson_id': instance.current_lesson_id,
      'lesson_type': instance.lesson_type,
    };

SectionItem _$SectionItemFromJson(Map<String, dynamic> json) {
  return SectionItem(
    number: json['number'] as String,
    title: json['title'] as String,
    items: (json['items'] as List)?.map((e) => e as String)?.toList(),
    section_items: (json['section_items'] as List)
        ?.map((e) => e == null
            ? null
            : Section_itemsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SectionItemToJson(SectionItem instance) =>
    <String, dynamic>{
      'number': instance.number,
      'title': instance.title,
      'items': instance.items,
      'section_items': instance.section_items,
    };

Section_itemsBean _$Section_itemsBeanFromJson(Map<String, dynamic> json) {
  return Section_itemsBean(
    item_id: json['item_id'] as int,
    title: json['title'] as String,
    type: json['type'] as String,
    quiz_info: json['quiz_info'],
    locked: json['locked'] as bool,
    completed: json['completed'] as bool,
    has_preview: json['has_preview'] as bool,
    lesson_id: json['lesson_id'],
  )
    ..duration = json['duration'] as String
    ..questions = json['questions'] as String;
}

Map<String, dynamic> _$Section_itemsBeanToJson(Section_itemsBean instance) =>
    <String, dynamic>{
      'item_id': instance.item_id,
      'title': instance.title,
      'type': instance.type,
      'quiz_info': instance.quiz_info,
      'locked': instance.locked,
      'completed': instance.completed,
      'lesson_id': instance.lesson_id,
      'has_preview': instance.has_preview,
      'duration': instance.duration,
      'questions': instance.questions,
    };
