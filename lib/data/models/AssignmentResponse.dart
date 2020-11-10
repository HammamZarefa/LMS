import 'package:json_annotation/json_annotation.dart';

part 'AssignmentResponse.g.dart';

@JsonSerializable()
class AssignmentResponse {
    String status;
    String title;
    String content;
    String comment;
    String button;
    SectionBean section;
    String prev_lesson_type;
    String next_lesson_type;
    String prev_lesson;
    String next_lesson;
    String label;
    TranslationBean translations;
    List<FilesBean> files;
    num draft_id = null;

    AssignmentResponse({this.status, this.translations, this.title, this.content, this.draft_id, this.button, this.section, this.prev_lesson_type, this.next_lesson_type, this.prev_lesson, this.next_lesson, this.label, this.comment, this.files});

    factory AssignmentResponse.fromJson(Map<String, dynamic> json) => _$AssignmentResponseFromJson(json);

    Map<String, dynamic> toJson() => _$AssignmentResponseToJson(this);
}

@JsonSerializable()
class SectionBean {
    String label;
    String number;
    int index = null;

    SectionBean({this.label, this.number, this.index});

    factory SectionBean.fromJson(Map<String, dynamic> json) => _$SectionBeanFromJson(json);

    Map<String, dynamic> toJson() => _$SectionBeanToJson(this);
}

@JsonSerializable()
class TranslationBean {
    String title;
    String content;
    String files;

    TranslationBean({this.title, this.content, this.files});

    factory TranslationBean.fromJson(Map<String, dynamic> json) => _$TranslationBeanFromJson(json);

    Map<String, dynamic> toJson() => _$TranslationBeanToJson(this);
}

@JsonSerializable()
class FilesBean {
    FileBean data;

    FilesBean({this.data});

    factory FilesBean.fromJson(Map<String, dynamic> json) => _$FilesBeanFromJson(json);

    Map<String, dynamic> toJson() => _$FilesBeanToJson(this);
}

@JsonSerializable()
class FileBean {
    String name;
    num id;
    String status;
    bool error;
    String link;

    FileBean({this.name, this.id, this.status, this.error, this.link});

    factory FileBean.fromJson(Map<String, dynamic> json) => _$FileBeanFromJson(json);

    Map<String, dynamic> toJson() => _$FileBeanToJson(this);
}