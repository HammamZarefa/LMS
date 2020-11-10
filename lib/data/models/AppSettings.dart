import 'package:json_annotation/json_annotation.dart';

part 'AppSettings.g.dart';

@JsonSerializable()
class AppSettings {
  AddonsBean addons;
  List<HomeLayoutBean> home_layout;
  OptionsBean options;

  AppSettings({this.addons, this.home_layout, this.options});

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}

@JsonSerializable()
class HomeLayoutBean {
  num id;
  String name;
  bool enabled;

  HomeLayoutBean({this.id, this.name, this.enabled});

  factory HomeLayoutBean.fromJson(Map<String, dynamic> json) => _$HomeLayoutBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeLayoutBeanToJson(this);
}

@JsonSerializable()
class AddonsBean {
  String shareware;
  String sequential_drip_content;
  String gradebook;
  String live_streams;
  String enterprise_courses;
  String assignments;
  String point_system;
  String statistics;
  String online_testing;
  String course_bundle;
  String multi_instructors;

  AddonsBean({this.shareware, this.sequential_drip_content, this.gradebook, this.live_streams, this.enterprise_courses, this.assignments, this.point_system, this.statistics, this.online_testing, this.course_bundle, this.multi_instructors});

  factory AddonsBean.fromJson(Map<String, dynamic> json) => _$AddonsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AddonsBeanToJson(this);
}

@JsonSerializable()
class OptionsBean {
  String logo;
  ColorBean main_color;
  ColorBean secondary_color;
  bool app_view;
  num posts_count;

  OptionsBean({this.logo, this.main_color, this.secondary_color, this.app_view, this.posts_count});

  factory OptionsBean.fromJson(Map<String, dynamic> json) => _$OptionsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsBeanToJson(this);
}

@JsonSerializable()
class ColorBean {
  num r;
  num g;
  num b;
  num a;

  ColorBean({this.r, this.g, this.b, this.a});

  factory ColorBean.fromJson(Map<String, dynamic> json) => _$ColorBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ColorBeanToJson(this);
}