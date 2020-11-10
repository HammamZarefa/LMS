import 'package:json_annotation/json_annotation.dart';

part 'curriculum.g.dart';

@JsonSerializable()
class CurriculumResponse {
  final List<SectionItem> sections;
  final String progress_percent;
  final String current_lesson_id;
  final String lesson_type;

  CurriculumResponse(
    this.sections,
    this.progress_percent,
    this.current_lesson_id,
    this.lesson_type,
  );

  factory CurriculumResponse.fromJson(Map<String, dynamic> json) =>
      _$CurriculumResponseFromJson(json);
}

@JsonSerializable()
class SectionItem {
  String number;
  String title;
  List<String> items;
  List<Section_itemsBean> section_items;

  SectionItem({this.number, this.title, this.items, this.section_items});

  factory SectionItem.fromJson(Map<String, dynamic> json) =>
      _$SectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$SectionItemToJson(this);
}

@JsonSerializable()
class Section_itemsBean {
  int item_id;
  String title;
  String type;
  dynamic quiz_info;
  bool locked;
  bool completed;
  dynamic lesson_id;
  bool has_preview;
  String duration;
  String questions;

  Section_itemsBean(
      {this.item_id,
      this.title,
      this.type,
      this.quiz_info,
      this.locked,
      this.completed,
      this.has_preview,
      this.lesson_id});

  factory Section_itemsBean.fromJson(Map<String, dynamic> json) =>
      _$Section_itemsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Section_itemsBeanToJson(this);
}
