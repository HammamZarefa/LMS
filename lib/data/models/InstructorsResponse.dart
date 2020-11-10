import 'package:json_annotation/json_annotation.dart';

part 'InstructorsResponse.g.dart';

@JsonSerializable()
class InstructorsResponse {
  num page;
  List<InstructorBean> data;
  num total_pages;

  InstructorsResponse({this.page, this.data, this.total_pages});

  factory InstructorsResponse.fromJson(Map<String, dynamic> json) => _$InstructorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorsResponseToJson(this);
}

@JsonSerializable()
class InstructorBean {
  num id;
  String login;
  String avatar;
  String avatar_url;
  String email;
  String url;
  MetaBean meta;
  RatingBean rating;
  String profile_url;

  InstructorBean({this.id, this.login, this.avatar, this.avatar_url, this.email, this.url, this.meta, this.rating, this.profile_url});

  factory InstructorBean.fromJson(Map<String, dynamic> json) => _$InstructorBeanFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorBeanToJson(this);
}

@JsonSerializable()
class RatingBean {
  num total;
  num average;
  num marks_num;
  String total_marks;
  num percent;

  RatingBean({this.total, this.average, this.marks_num, this.total_marks, this.percent});

  factory RatingBean.fromJson(Map<String, dynamic> json) => _$RatingBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RatingBeanToJson(this);
}

@JsonSerializable()
class MetaBean {
  String facebook;
  String twitter;
  String instagram;
  @JsonKey(name: "google-plus")
  String google_plus;
  String position;
  String description;
  String first_name;
  String last_name;

  MetaBean({this.facebook, this.twitter, this.instagram, this.google_plus, this.position, this.description, this.first_name, this.last_name});

  factory MetaBean.fromJson(Map<String, dynamic> json) => _$MetaBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MetaBeanToJson(this);
}

