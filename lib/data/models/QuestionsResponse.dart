import 'package:json_annotation/json_annotation.dart';

part 'QuestionsResponse.g.dart';

@JsonSerializable()
class QuestionsResponse {

    List<QuestionBean> posts;

    QuestionsResponse({this.posts});

    factory QuestionsResponse.fromJson(Map<String, dynamic> json) => _$QuestionsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionsResponseToJson(this);
}

@JsonSerializable()
class QuestionBean {
    String comment_ID;
    String content;
    QuestionAuthorBean author;
    String datetime;
    String replies_count;
    List<ReplyBean> replies;

    QuestionBean({this.comment_ID, this.content, this.author, this.datetime, this.replies_count, this.replies});

    factory QuestionBean.fromJson(Map<String, dynamic> json) => _$QuestionBeanFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionBeanToJson(this);
}

@JsonSerializable()
class QuestionAuthorBean {
    int id;
    String login;
    String avatar_url;
    String url;
    String email;

    //RatingBean rating;

    QuestionAuthorBean({
        this.id,
        this.login,
        this.avatar_url,
        this.url,
        this.email
        //   this.rating
    });

    factory QuestionAuthorBean.fromJson(Map<String, dynamic> json) =>
        _$QuestionAuthorBeanFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionAuthorBeanToJson(this);
}

@JsonSerializable()
class ReplyBean {
    String comment_ID;
    String content;
    QuestionAuthorBean author;
    String datetime;

    //RatingBean rating;

    ReplyBean({
        this.comment_ID,
        this.content,
        this.author,
        this.datetime
        //   this.rating
    });

    factory ReplyBean.fromJson(Map<String, dynamic> json) =>
        _$ReplyBeanFromJson(json);

    Map<String, dynamic> toJson() => _$ReplyBeanToJson(this);
}