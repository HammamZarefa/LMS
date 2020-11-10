import 'package:json_annotation/json_annotation.dart';

part 'QuestionAddResponse.g.dart';

@JsonSerializable()
class QuestionAddResponse {

    bool error;
    String status;
    String message;
    QuestionAddBean comment;

    QuestionAddResponse({this.error, this.status, this.message, this.comment});

    factory QuestionAddResponse.fromJson(Map<String, dynamic> json) => _$QuestionAddResponseFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionAddResponseToJson(this);
}

@JsonSerializable()
class QuestionAddBean {
    String comment_ID;
    String content;
    QuestionAddAuthorBean author;
    String datetime;
    String replies_count;

    QuestionAddBean({this.comment_ID, this.content, this.author, this.datetime, this.replies_count});

    factory QuestionAddBean.fromJson(Map<String, dynamic> json) => _$QuestionAddBeanFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionAddBeanToJson(this);
}

@JsonSerializable()
class QuestionAddAuthorBean {
    int id;
    String login;
    String avatar_url;
    String url;
    String email;

    //RatingBean rating;

    QuestionAddAuthorBean({
        this.id,
        this.login,
        this.avatar_url,
        this.url,
        this.email
        //   this.rating
    });

    factory QuestionAddAuthorBean.fromJson(Map<String, dynamic> json) =>
        _$QuestionAddAuthorBeanFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionAddAuthorBeanToJson(this);
}

@JsonSerializable()
class ReplyAddBean {
    String comment_ID;
    String content;
    QuestionAddAuthorBean author;
    String datetime;

    //RatingBean rating;

    ReplyAddBean({
        this.comment_ID,
        this.content,
        this.author,
        this.datetime
        //   this.rating
    });

    factory ReplyAddBean.fromJson(Map<String, dynamic> json) =>
        _$ReplyAddBeanFromJson(json);

    Map<String, dynamic> toJson() => _$ReplyAddBeanToJson(this);
}