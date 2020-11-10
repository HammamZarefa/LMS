// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AssignmentResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentResponse _$AssignmentResponseFromJson(Map<String, dynamic> json) {
  return AssignmentResponse(
    status: json['status'] as String,
    translations: json['translations'] == null
        ? null
        : TranslationBean.fromJson(
            json['translations'] as Map<String, dynamic>),
    title: json['title'] as String,
    content: json['content'] as String,
    draft_id: json['draft_id'] as num,
    button: json['button'] as String,
    section: json['section'] == null
        ? null
        : SectionBean.fromJson(json['section'] as Map<String, dynamic>),
    prev_lesson_type: json['prev_lesson_type'] as String,
    next_lesson_type: json['next_lesson_type'] as String,
    prev_lesson: json['prev_lesson'] as String,
    next_lesson: json['next_lesson'] as String,
    label: json['label'] as String,
    comment: json['comment'] as String,
    files: (json['files'] as List)
        ?.map((e) =>
            e == null ? null : FilesBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssignmentResponseToJson(AssignmentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'title': instance.title,
      'content': instance.content,
      'comment': instance.comment,
      'button': instance.button,
      'section': instance.section,
      'prev_lesson_type': instance.prev_lesson_type,
      'next_lesson_type': instance.next_lesson_type,
      'prev_lesson': instance.prev_lesson,
      'next_lesson': instance.next_lesson,
      'label': instance.label,
      'translations': instance.translations,
      'files': instance.files,
      'draft_id': instance.draft_id,
    };

SectionBean _$SectionBeanFromJson(Map<String, dynamic> json) {
  return SectionBean(
    label: json['label'] as String,
    number: json['number'] as String,
    index: json['index'] as int,
  );
}

Map<String, dynamic> _$SectionBeanToJson(SectionBean instance) =>
    <String, dynamic>{
      'label': instance.label,
      'number': instance.number,
      'index': instance.index,
    };

TranslationBean _$TranslationBeanFromJson(Map<String, dynamic> json) {
  return TranslationBean(
    title: json['title'] as String,
    content: json['content'] as String,
    files: json['files'] as String,
  );
}

Map<String, dynamic> _$TranslationBeanToJson(TranslationBean instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'files': instance.files,
    };

FilesBean _$FilesBeanFromJson(Map<String, dynamic> json) {
  return FilesBean(
    data: json['data'] == null
        ? null
        : FileBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FilesBeanToJson(FilesBean instance) => <String, dynamic>{
      'data': instance.data,
    };

FileBean _$FileBeanFromJson(Map<String, dynamic> json) {
  return FileBean(
    name: json['name'] as String,
    id: json['id'] as num,
    status: json['status'] as String,
    error: json['error'] as bool,
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$FileBeanToJson(FileBean instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'status': instance.status,
      'error': instance.error,
      'link': instance.link,
    };
