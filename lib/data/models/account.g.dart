// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
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

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
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
