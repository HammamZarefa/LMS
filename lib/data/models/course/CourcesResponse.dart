import 'package:json_annotation/json_annotation.dart';
import 'package:masterstudy_app/data/models/category.dart';

part 'CourcesResponse.g.dart';

@JsonSerializable()
class CourcesResponse {
  num page;
  List<CoursesBean> courses;
  num total_pages;

  CourcesResponse({this.page, this.courses, this.total_pages});

  factory CourcesResponse.fromJson(Map<String, dynamic> json) =>
      _$CourcesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourcesResponseToJson(this);
}

@JsonSerializable()
class CoursesBean {
  num id;
  String title;
  ImagesBean images;
  List<String> categories;

  PriceBean price;

  RatingBean rating;
  String featured;
  StatusBean status;
  List<Category> categories_object;

  CoursesBean(
      {this.id,
      this.title,
      this.images,
      this.categories,
      this.price,
      this.rating,
      this.featured,
      this.status,
      this.categories_object
      });

  factory CoursesBean.fromJson(Map<String, dynamic> json) =>
      _$CoursesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CoursesBeanToJson(this);
}

@JsonSerializable()
class PriceBean {
  bool free;
  String price;
  String old_price;

  PriceBean({
    this.free,
    this.price,
    this.old_price,
  });

  factory PriceBean.fromJson(Map<String, dynamic> json) =>
      _$PriceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PriceBeanToJson(this);
}

@JsonSerializable()
class StatusBean {
  String status;
  String label;

  StatusBean({this.status, this.label});

  factory StatusBean.fromJson(Map<String, dynamic> json) =>
      _$StatusBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StatusBeanToJson(this);
}

@JsonSerializable()
class RatingBean {
  num average;
  num total;
  num percent;

  RatingBean({this.average, this.total, this.percent});

  factory RatingBean.fromJson(Map<String, dynamic> json) =>
      _$RatingBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RatingBeanToJson(this);
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
