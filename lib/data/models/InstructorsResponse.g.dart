// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InstructorsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorsResponse _$InstructorsResponseFromJson(Map<String, dynamic> json) {
  return InstructorsResponse(
    page: json['page'] as num,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : InstructorBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    total_pages: json['total_pages'] as num,
  );
}

Map<String, dynamic> _$InstructorsResponseToJson(
        InstructorsResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'data': instance.data,
      'total_pages': instance.total_pages,
    };

InstructorBean _$InstructorBeanFromJson(Map<String, dynamic> json) {
  return InstructorBean(
    id: json['id'] as num,
    login: json['login'] as String,
    avatar: json['avatar'] as String,
    avatar_url: json['avatar_url'] as String,
    email: json['email'] as String,
    url: json['url'] as String,
    meta: json['meta'] == null
        ? null
        : MetaBean.fromJson(json['meta'] as Map<String, dynamic>),
    rating: json['rating'] == null
        ? null
        : RatingBean.fromJson(json['rating'] as Map<String, dynamic>),
    profile_url: json['profile_url'] as String,
  );
}

Map<String, dynamic> _$InstructorBeanToJson(InstructorBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar': instance.avatar,
      'avatar_url': instance.avatar_url,
      'email': instance.email,
      'url': instance.url,
      'meta': instance.meta,
      'rating': instance.rating,
      'profile_url': instance.profile_url,
    };

RatingBean _$RatingBeanFromJson(Map<String, dynamic> json) {
  return RatingBean(
    total: json['total'] as num,
    average: json['average'] as num,
    marks_num: json['marks_num'] as num,
    total_marks: json['total_marks'] as String,
    percent: json['percent'] as num,
  );
}

Map<String, dynamic> _$RatingBeanToJson(RatingBean instance) =>
    <String, dynamic>{
      'total': instance.total,
      'average': instance.average,
      'marks_num': instance.marks_num,
      'total_marks': instance.total_marks,
      'percent': instance.percent,
    };

MetaBean _$MetaBeanFromJson(Map<String, dynamic> json) {
  return MetaBean(
    facebook: json['facebook'] as String,
    twitter: json['twitter'] as String,
    instagram: json['instagram'] as String,
    google_plus: json['google-plus'] as String,
    position: json['position'] as String,
    description: json['description'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
  );
}

Map<String, dynamic> _$MetaBeanToJson(MetaBean instance) => <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'google-plus': instance.google_plus,
      'position': instance.position,
      'description': instance.description,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
    };
