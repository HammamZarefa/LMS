// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionAddResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAddResponse _$QuestionAddResponseFromJson(Map<String, dynamic> json) {
  return QuestionAddResponse(
    error: json['error'] as bool,
    status: json['status'] as String,
    message: json['message'] as String,
    comment: json['comment'] == null
        ? null
        : QuestionAddBean.fromJson(json['comment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QuestionAddResponseToJson(
        QuestionAddResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
      'comment': instance.comment,
    };

QuestionAddBean _$QuestionAddBeanFromJson(Map<String, dynamic> json) {
  return QuestionAddBean(
    comment_ID: json['comment_ID'] as String,
    content: json['content'] as String,
    author: json['author'] == null
        ? null
        : QuestionAddAuthorBean.fromJson(
            json['author'] as Map<String, dynamic>),
    datetime: json['datetime'] as String,
    replies_count: json['replies_count'] as String,
  );
}

Map<String, dynamic> _$QuestionAddBeanToJson(QuestionAddBean instance) =>
    <String, dynamic>{
      'comment_ID': instance.comment_ID,
      'content': instance.content,
      'author': instance.author,
      'datetime': instance.datetime,
      'replies_count': instance.replies_count,
    };

QuestionAddAuthorBean _$QuestionAddAuthorBeanFromJson(
    Map<String, dynamic> json) {
  return QuestionAddAuthorBean(
    id: json['id'] as int,
    login: json['login'] as String,
    avatar_url: json['avatar_url'] as String,
    url: json['url'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$QuestionAddAuthorBeanToJson(
        QuestionAddAuthorBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'url': instance.url,
      'email': instance.email,
    };

ReplyAddBean _$ReplyAddBeanFromJson(Map<String, dynamic> json) {
  return ReplyAddBean(
    comment_ID: json['comment_ID'] as String,
    content: json['content'] as String,
    author: json['author'] == null
        ? null
        : QuestionAddAuthorBean.fromJson(
            json['author'] as Map<String, dynamic>),
    datetime: json['datetime'] as String,
  );
}

Map<String, dynamic> _$ReplyAddBeanToJson(ReplyAddBean instance) =>
    <String, dynamic>{
      'comment_ID': instance.comment_ID,
      'content': instance.content,
      'author': instance.author,
      'datetime': instance.datetime,
    };
