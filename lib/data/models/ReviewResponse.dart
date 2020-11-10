import 'package:json_annotation/json_annotation.dart';

part 'ReviewResponse.g.dart';

@JsonSerializable()
class ReviewResponse {
  List<ReviewBean> posts;
  bool total;

  ReviewResponse({this.posts, this.total});

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => _$ReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}

@JsonSerializable()
class ReviewBean {
  String user;
  String avatar_url;
  String time;
  String title;
  String content;
  num mark;

  ReviewBean({this.user, this.avatar_url, this.time, this.title, this.content, this.mark});

  factory ReviewBean.fromJson(Map<String, dynamic> json) => _$ReviewBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewBeanToJson(this);
}

