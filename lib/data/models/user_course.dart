import 'package:json_annotation/json_annotation.dart';
import 'package:masterstudy_app/data/models/category.dart';

part 'user_course.g.dart';

@JsonSerializable()
class UserCourseResponse {
  List<PostsBean> posts;
  String total;
  num offset;
  num total_posts;
  num pages;

  UserCourseResponse({this.posts, this.total, this.offset, this.total_posts, this.pages});

  factory UserCourseResponse.fromJson(Map<String, dynamic> json) => _$UserCourseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserCourseResponseToJson(this);
}

@JsonSerializable()
class PostsBean {
  String image_id;
  String title;
  String link;
  String image;
  List<String> terms;
  List<String> terms_list;
  String views;
  String price;
  String sale_price;
  PostStatusBean post_status;
  String progress;
  String progress_label;
  String current_lesson_id;
  String course_id;
  String lesson_id;
  String start_time;
  String duration;
  String app_image;
  PostAuthorBean author;
  String lesson_type;
  List<Category> categories_object;

  PostsBean({this.image_id, this.title, this.link, this.image, this.terms, this.terms_list, this.views, this.price, this.sale_price, this.post_status, this.progress, this.progress_label, this.current_lesson_id, this.course_id, this.lesson_id, this.start_time, this.duration, this.app_image, this.author, this.lesson_type, this.categories_object});

  factory PostsBean.fromJson(Map<String, dynamic> json) => _$PostsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostsBeanToJson(this);
}
@JsonSerializable()
class PostStatusBean{
  String status;
  String label;
  PostStatusBean({this.status,this.label});

  factory PostStatusBean.fromJson(Map<String, dynamic> json) => _$PostStatusBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostStatusBeanToJson(this);
}

@JsonSerializable()
class PostAuthorBean {
  String id;
  String login;
  String avatar_url;
  String url;
  AuthorMetaBean meta;

  //RatingBean rating;

  PostAuthorBean({
    this.id,
    this.login,
    this.avatar_url,
    this.url,
    this.meta,
    //   this.rating
  });

  factory PostAuthorBean.fromJson(Map<String, dynamic> json) =>
      _$PostAuthorBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostAuthorBeanToJson(this);
}


@JsonSerializable()
class AuthorMetaBean {
  String type;
  String label;

  String text;

  AuthorMetaBean({
    this.type,
    this.label,
    this.text
  });

  factory AuthorMetaBean.fromJson(Map<String, dynamic> json) =>
      _$AuthorMetaBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorMetaBeanToJson(this);
}

