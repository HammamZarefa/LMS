// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsResponse _$QuestionsResponseFromJson(Map<String, dynamic> json) {
  return QuestionsResponse(
    posts: (json['posts'] as List)
        ?.map((e) =>
            e == null ? null : QuestionBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionsResponseToJson(QuestionsResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };

QuestionBean _$QuestionBeanFromJson(Map<String, dynamic> json) {
  return QuestionBean(
    comment_ID: json['comment_ID'] as String,
    content: json['content'] as String,
    author: json['author'] == null
        ? null
        : QuestionAuthorBean.fromJson(json['author'] as Map<String, dynamic>),
    datetime: json['datetime'] as String,
    replies_count: json['replies_count'] as String,
    replies: (json['replies'] as List)
        ?.map((e) =>
            e == null ? null : ReplyBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionBeanToJson(QuestionBean instance) =>
    <String, dynamic>{
      'comment_ID': instance.comment_ID,
      'content': instance.content,
      'author': instance.author,
      'datetime': instance.datetime,
      'replies_count': instance.replies_count,
      'replies': instance.replies,
    };

QuestionAuthorBean _$QuestionAuthorBeanFromJson(Map<String, dynamic> json) {
  return QuestionAuthorBean(
    id: json['id'] as int,
    login: json['login'] as String,
    avatar_url: json['avatar_url'] as String,
    url: json['url'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$QuestionAuthorBeanToJson(QuestionAuthorBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'url': instance.url,
      'email': instance.email,
    };

ReplyBean _$ReplyBeanFromJson(Map<String, dynamic> json) {
  return ReplyBean(
    comment_ID: json['comment_ID'] as String,
    content: json['content'] as String,
    author: json['author'] == null
        ? null
        : QuestionAuthorBean.fromJson(json['author'] as Map<String, dynamic>),
    datetime: json['datetime'] as String,
  );
}

Map<String, dynamic> _$ReplyBeanToJson(ReplyBean instance) => <String, dynamic>{
      'comment_ID': instance.comment_ID,
      'content': instance.content,
      'author': instance.author,
      'datetime': instance.datetime,
    };
