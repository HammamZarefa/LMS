import 'package:json_annotation/json_annotation.dart';

import 'InstructorsResponse.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  num id;
  String login;
  String avatar;
  String avatar_url;
  String email;
  String url;
  MetaBean meta;
  RatingBean rating;
  String profile_url;

  Account(
      {this.id,
      this.login,
      this.avatar,
      this.avatar_url,
      this.email,
      this.url,
      this.meta,
      this.rating,
      this.profile_url});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class RatingBean {
  num total;
  num average;
  num marks_num;
  String total_marks;
  num percent;

  RatingBean(
      {this.total,
      this.average,
      this.marks_num,
      this.total_marks,
      this.percent});

  factory RatingBean.fromJson(Map<String, dynamic> json) =>
      _$RatingBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RatingBeanToJson(this);
}
