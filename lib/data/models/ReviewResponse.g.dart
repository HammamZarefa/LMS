// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReviewResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) {
  return ReviewResponse(
    posts: (json['posts'] as List)
        ?.map((e) =>
            e == null ? null : ReviewBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    total: json['total'] as bool,
  );
}

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'total': instance.total,
    };

ReviewBean _$ReviewBeanFromJson(Map<String, dynamic> json) {
  return ReviewBean(
    user: json['user'] as String,
    avatar_url: json['avatar_url'] as String,
    time: json['time'] as String,
    title: json['title'] as String,
    content: json['content'] as String,
    mark: json['mark'] as num,
  );
}

Map<String, dynamic> _$ReviewBeanToJson(ReviewBean instance) =>
    <String, dynamic>{
      'user': instance.user,
      'avatar_url': instance.avatar_url,
      'time': instance.time,
      'title': instance.title,
      'content': instance.content,
      'mark': instance.mark,
    };
