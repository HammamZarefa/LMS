// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FinalResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalResponse _$FinalResponseFromJson(Map<String, dynamic> json) {
  return FinalResponse(
    title: json['title'] as String,
  )
    ..course = json['course'] == null
        ? null
        : CourseBean.fromJson(json['course'] as Map<String, dynamic>)
    ..curriculum = json['curriculum'] == null
        ? null
        : CurriculumBean.fromJson(json['curriculum'] as Map<String, dynamic>)
    ..course_completed = json['course_completed'] as bool
    ..url = json['url'] as String
    ..certificate_url = json['certificate_url'] as String;
}

Map<String, dynamic> _$FinalResponseToJson(FinalResponse instance) =>
    <String, dynamic>{
      'course': instance.course,
      'curriculum': instance.curriculum,
      'course_completed': instance.course_completed,
      'title': instance.title,
      'url': instance.url,
      'certificate_url': instance.certificate_url,
    };

CourseBean _$CourseBeanFromJson(Map<String, dynamic> json) {
  return CourseBean(
    user_course_id: json['user_course_id'] as num,
  )
    ..user_id = json['user_id'] as num
    ..course_id = json['course_id'] as num
    ..current_lesson_id = json['current_lesson_id'] as num
    ..progress_percent = json['progress_percent'] as num
    ..status = json['status'] as String
    ..subscription_id = json['subscription_id'] as num
    ..start_time = json['start_time'] as String
    ..lng_code = json['lng_code'] as String
    ..enterprise_id = json['enterprise_id'] as num
    ..bundle_id = json['bundle_id'] as num;
}

Map<String, dynamic> _$CourseBeanToJson(CourseBean instance) =>
    <String, dynamic>{
      'user_course_id': instance.user_course_id,
      'user_id': instance.user_id,
      'course_id': instance.course_id,
      'current_lesson_id': instance.current_lesson_id,
      'progress_percent': instance.progress_percent,
      'status': instance.status,
      'subscription_id': instance.subscription_id,
      'start_time': instance.start_time,
      'lng_code': instance.lng_code,
      'enterprise_id': instance.enterprise_id,
      'bundle_id': instance.bundle_id,
    };

CurriculumBean _$CurriculumBeanFromJson(Map<String, dynamic> json) {
  return CurriculumBean(
    multimedia: json['multimedia'] == null
        ? null
        : TypeBean.fromJson(json['multimedia'] as Map<String, dynamic>),
    lesson: json['lesson'] == null
        ? null
        : TypeBean.fromJson(json['lesson'] as Map<String, dynamic>),
    assignment: json['assignment'] == null
        ? null
        : TypeBean.fromJson(json['assignment'] as Map<String, dynamic>),
    quiz: json['quiz'] == null
        ? null
        : TypeBean.fromJson(json['quiz'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CurriculumBeanToJson(CurriculumBean instance) =>
    <String, dynamic>{
      'multimedia': instance.multimedia,
      'lesson': instance.lesson,
      'quiz': instance.quiz,
      'assignment': instance.assignment,
    };

TypeBean _$TypeBeanFromJson(Map<String, dynamic> json) {
  return TypeBean(
    total: json['total'] as num,
    completed: json['completed'] as num,
  );
}

Map<String, dynamic> _$TypeBeanToJson(TypeBean instance) => <String, dynamic>{
      'total': instance.total,
      'completed': instance.completed,
    };
