import 'package:json_annotation/json_annotation.dart';
import 'package:masterstudy_app/data/models/category.dart';

part 'CourseDetailResponse.g.dart';

@JsonSerializable()
class CourseDetailResponse {
  num id;
  String title;
  ImagesBean images;
  List<String> categories;
  PriceBean price;
  RatingBean rating;
  dynamic featured;
  dynamic status;
  AuthorBean author;
  String url;
  String description;
  List<MetaBean> meta;
  String announcement;
  String purchase_label;
  List<CurriculumBean> curriculum;
  List<FaqBean> faq;
  bool is_favorite;
  bool trial;
  num first_lesson;
  String first_lesson_type;
  bool has_access;
  List<Category> categories_object;

  CourseDetailResponse(
      {this.id,
      this.title,
      this.images,
      this.categories,
      this.price,
      this.rating,
      this.featured,
      this.status,
      this.author,
      this.url,
      this.description,
      this.meta,
      this.announcement,
      this.purchase_label,
      this.curriculum,
      this.faq,
      this.is_favorite,
      this.trial,
      this.first_lesson,
      this.first_lesson_type,
      this.has_access,
      this.categories_object,
      });

  factory CourseDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailResponseToJson(this);
}

@JsonSerializable()
class FaqBean {
  String question;
  String answer;

  FaqBean({this.question, this.answer});

  factory FaqBean.fromJson(Map<String, dynamic> json) =>
      _$FaqBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FaqBeanToJson(this);
}

@JsonSerializable()
class CurriculumBean {
  String type;
  String view;
  String label;
  String meta;
  dynamic lesson_id;
  dynamic has_preview;

  CurriculumBean(
      {this.type,
      this.view,
      this.label,
      this.meta,
      this.lesson_id,
      this.has_preview});

  factory CurriculumBean.fromJson(Map<String, dynamic> json) =>
      _$CurriculumBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CurriculumBeanToJson(this);
}

@JsonSerializable()
class MetaBean {
  String type;
  String label;
  String text;

  MetaBean({this.type, this.label, this.text});

  factory MetaBean.fromJson(Map<String, dynamic> json) =>
      _$MetaBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MetaBeanToJson(this);
}

@JsonSerializable()
class AuthorBean {
  num id;
  String login;
  String avatar_url;
  String url;
  AuthorMetaBean meta;
  AuthorRatingBean rating;

  AuthorBean(
      {this.id, this.login, this.avatar_url, this.url, this.meta, this.rating});

  factory AuthorBean.fromJson(Map<String, dynamic> json) =>
      _$AuthorBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorBeanToJson(this);
}

@JsonSerializable()
class AuthorMetaBean {
  String facebook;
  String twitter;
  String instagram;
  @JsonKey(name: "google-plus")
  String google_plus;
  String position;
  String description;
  String first_name;
  String last_name;

  AuthorMetaBean(
      {this.facebook,
      this.twitter,
      this.instagram,
      this.google_plus,
      this.position,
      this.description,
      this.first_name,
      this.last_name});

  factory AuthorMetaBean.fromJson(Map<String, dynamic> json) =>
      _$AuthorMetaBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorMetaBeanToJson(this);
}

@JsonSerializable()
class AuthorRatingBean {
  num total;
  num average;
  num marks_num;
  String total_marks;
  num percent;

  AuthorRatingBean(
      {this.total,
      this.average,
      this.marks_num,
      this.total_marks,
      this.percent});

  factory AuthorRatingBean.fromJson(Map<String, dynamic> json) =>
      _$AuthorRatingBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorRatingBeanToJson(this);
}

@JsonSerializable()
class RatingBean {
  num total;
  num average;
  num percent;
  DetailsBean details;

  RatingBean({this.total, this.average, this.percent, this.details});

  factory RatingBean.fromJson(Map<String, dynamic> json) =>
      _$RatingBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RatingBeanToJson(this);
}

@JsonSerializable()
class DetailsBean {
  @JsonKey(name: "1")
  num one;
  @JsonKey(name: "2")
  num two;
  @JsonKey(name: "3")
  num three;
  @JsonKey(name: "4")
  num four;
  @JsonKey(name: "5")
  num five;

  DetailsBean({this.one, this.two, this.three, this.four, this.five});

  factory DetailsBean.fromJson(Map<String, dynamic> json) =>
      _$DetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsBeanToJson(this);
}

@JsonSerializable()
class PriceBean {
  bool free;
  String price;
  dynamic old_price;

  PriceBean({this.free, this.price, this.old_price});

  factory PriceBean.fromJson(Map<String, dynamic> json) =>
      _$PriceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PriceBeanToJson(this);
}

@JsonSerializable()
class ImagesBean {
  String full;
  String small;

  ImagesBean({this.full, this.small});

  factory ImagesBean.fromJson(Map<String, dynamic> json) =>
      _$ImagesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesBeanToJson(this);
}
