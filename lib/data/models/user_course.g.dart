// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCourseResponse _$UserCourseResponseFromJson(Map<String, dynamic> json) {
  return UserCourseResponse(
    posts: (json['posts'] as List)
        ?.map((e) =>
            e == null ? null : PostsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    total: json['total'] as String,
    offset: json['offset'] as num,
    total_posts: json['total_posts'] as num,
    pages: json['pages'] as num,
  );
}

Map<String, dynamic> _$UserCourseResponseToJson(UserCourseResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'total': instance.total,
      'offset': instance.offset,
      'total_posts': instance.total_posts,
      'pages': instance.pages,
    };

PostsBean _$PostsBeanFromJson(Map<String, dynamic> json) {
  return PostsBean(
    image_id: json['image_id'] as String,
    title: json['title'] as String,
    link: json['link'] as String,
    image: json['image'] as String,
    terms: (json['terms'] as List)?.map((e) => e as String)?.toList(),
    terms_list: (json['terms_list'] as List)?.map((e) => e as String)?.toList(),
    views: json['views'] as String,
    price: json['price'] as String,
    sale_price: json['sale_price'] as String,
    post_status: json['post_status'] == null
        ? null
        : PostStatusBean.fromJson(json['post_status'] as Map<String, dynamic>),
    progress: json['progress'] as String,
    progress_label: json['progress_label'] as String,
    current_lesson_id: json['current_lesson_id'] as String,
    course_id: json['course_id'] as String,
    lesson_id: json['lesson_id'] as String,
    start_time: json['start_time'] as String,
    duration: json['duration'] as String,
    app_image: json['app_image'] as String,
    author: json['author'] == null
        ? null
        : PostAuthorBean.fromJson(json['author'] as Map<String, dynamic>),
    lesson_type: json['lesson_type'] as String,
    categories_object: (json['categories_object'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostsBeanToJson(PostsBean instance) => <String, dynamic>{
      'image_id': instance.image_id,
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
      'terms': instance.terms,
      'terms_list': instance.terms_list,
      'views': instance.views,
      'price': instance.price,
      'sale_price': instance.sale_price,
      'post_status': instance.post_status,
      'progress': instance.progress,
      'progress_label': instance.progress_label,
      'current_lesson_id': instance.current_lesson_id,
      'course_id': instance.course_id,
      'lesson_id': instance.lesson_id,
      'start_time': instance.start_time,
      'duration': instance.duration,
      'app_image': instance.app_image,
      'author': instance.author,
      'lesson_type': instance.lesson_type,
      'categories_object': instance.categories_object,
    };

PostStatusBean _$PostStatusBeanFromJson(Map<String, dynamic> json) {
  return PostStatusBean(
    status: json['status'] as String,
    label: json['label'] as String,
  );
}

Map<String, dynamic> _$PostStatusBeanToJson(PostStatusBean instance) =>
    <String, dynamic>{
      'status': instance.status,
      'label': instance.label,
    };

PostAuthorBean _$PostAuthorBeanFromJson(Map<String, dynamic> json) {
  return PostAuthorBean(
    id: json['id'] as String,
    login: json['login'] as String,
    avatar_url: json['avatar_url'] as String,
    url: json['url'] as String,
    meta: json['meta'] == null
        ? null
        : AuthorMetaBean.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostAuthorBeanToJson(PostAuthorBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'url': instance.url,
      'meta': instance.meta,
    };

AuthorMetaBean _$AuthorMetaBeanFromJson(Map<String, dynamic> json) {
  return AuthorMetaBean(
    type: json['type'] as String,
    label: json['label'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$AuthorMetaBeanToJson(AuthorMetaBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'text': instance.text,
    };
