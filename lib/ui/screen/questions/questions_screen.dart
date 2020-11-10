import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/QuestionsResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/questions/bloc.dart';
import 'package:masterstudy_app/ui/screen/question_ask/question_ask_screen.dart';
import 'package:masterstudy_app/ui/screen/question_details/question_details_screen.dart';
import 'package:masterstudy_app/ui/screen/detail_profile/detail_profile_screen.dart';

class QuestionsScreenArgs {
    final int lessonId;
    final int page;

    QuestionsScreenArgs(this.lessonId, this.page);
}

class QuestionsScreen extends StatelessWidget {
    static const routeName = "questionsScreen";
    final QuestionsBloc bloc;

    const QuestionsScreen(this.bloc) : super();

    @override
    Widget build(BuildContext context) {
        QuestionsScreenArgs args = ModalRoute.of(context).settings.arguments;
        return BlocProvider<QuestionsBloc>(
            create: (context) => bloc,
            child: QuestionsWidget(args.lessonId, args.page));
    }
}

class QuestionsWidget extends StatefulWidget {
    final int lessonId;
    final int page;

    const QuestionsWidget(this.lessonId, this.page) : super();

    @override
    State<StatefulWidget> createState() {
        return QuestionsWidgetState();
    }
}

class QuestionsWidgetState extends State<QuestionsWidget> {
    QuestionsBloc _bloc;
    bool sendRequest = false;
    QuestionsResponse questionsAll;
    QuestionsResponse questionsMy;
    TextEditingController reply = TextEditingController();

    @override
    void initState() {
        super.initState();
        _bloc = BlocProvider.of<QuestionsBloc>(context)..add(FetchEvent(widget.lessonId, widget.page, "", ""));
    }

    @override
    Widget build(BuildContext context) {
        return BlocListener(
            bloc: _bloc,
            listener: (context, state) {
                if (state is LoadedMyQuestionsState) {
                    setState(() {
                        questionsAll = state.questionsResponseAll;
                        questionsMy = state.questionsResponseMy;
                    });
                }
            },
            child: BlocBuilder<QuestionsBloc, QuestionsState>(
                builder: (context, state) {
                    return DefaultTabController(
                        length: 2,
                        child: Scaffold(
                            appBar: AppBar(
                                backgroundColor: HexColor.fromHex("#273044"),
                                title: Text(
                                    localizations.getLocalization("question_ask_screen_title"),
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0
                                    ),
                                ),
                                bottom: ColoredTabBar(
                                    Colors.white,
                                    TabBar(
                                        indicatorColor: mainColorA,
                                        tabs: [
                                            Tab(
                                                text: localizations.getLocalization("all_questions"),
                                            ),
                                            Tab(text: localizations.getLocalization("my_questions")),
                                        ],
                                    )),
                            ),
                            body: _buildBody(state),
                            bottomNavigationBar: _buildBottom(state),
                        ),
                    );
                },
            )
        );
    }
    
    _buildBody(QuestionsState state) {
        if (state is InitialQuestionsState)
            return Center(
                child: CircularProgressIndicator(),
            );

        if (state is LoadedQuestionsState) {

            questionsAll = state.questionsResponseAll;
            questionsMy = state.questionsResponseMy;

            return TabBarView(
                children: <Widget>[
                    SingleChildScrollView(
                        child: (questionsAll.posts.length != 0)
                            ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0, right: 7.0, left: 7.0),
                                    child: _buildList(
                                        questionsAll.posts)
                                ),
                            ]
                        )
                            : Center(
                            child: Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: Text(
                                    localizations.getLocalization("no_questions"),
                                    textScaleFactor: 1.0,
                                ),
                            )
                        )
                    ),
                    SingleChildScrollView(
                        child: (questionsMy.posts.length != 0)
                            ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0, right: 7.0, left: 7.0),
                                    child: _buildMyList(
                                        questionsMy.posts)
                                ),
                            ]
                        )
                            : Center(
                            child: Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: Text(
                                    localizations.getLocalization("no_questions"),
                                    textScaleFactor: 1.0,
                                ),
                            )
                        )
                    ),
                ],
            );
        }
    }

    _buildList(List<QuestionBean> questions) {
        return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: (context, index) {
                return _buildQuestion(questions[index]);
            });
    }

    _buildMyList(List<QuestionBean> questions) {
        return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: (context, index) {
                return _buildMyQuestion(questions[index]);
            });
    }

    _buildQuestion (QuestionBean question) {
        return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    GestureDetector(
                        onTap: () {
                            Navigator.of(context).pushNamed(
                                QuestionDetailsScreen.routeName,
                                arguments: QuestionDetailsScreenArgs(widget.lessonId, question),
                            );
                        },
                        child: Html(
                            data: question.content,
                            defaultTextStyle: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                                color: HexColor.fromHex("#273044")
                            )
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: SvgPicture.asset(
                                        (question.replies.length == 0) ? "assets/icons/reply_no.svg" : "assets/icons/reply_has.svg",
                                        color: (question.replies.length == 0) ? HexColor.fromHex("#AAAAAA") : secondColor,
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                        question.replies_count,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: (question.replies.length == 0) ? HexColor.fromHex("#AAAAAA") : secondColor
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(
                            height: 1.0,
                            decoration: BoxDecoration(
                                color: HexColor.fromHex("#E2E5EB"),
                            )
                        ),
                    )
                ],
            ),
        );
    }

    _buildMyQuestion (QuestionBean question) {
        return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Html(
                                    data: question.content,
                                    defaultTextStyle: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor.fromHex("#273044")
                                    )
                                ),
                            ),
                            Text(
                                question.datetime,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: HexColor.fromHex("#AAAAAA")
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
                                child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    maxLines: 2,
                                    textAlignVertical: TextAlignVertical.top,
                                    onFieldSubmitted: (text) {
                                        _bloc.add(MyQuestionAddEvent(questionsAll, widget.lessonId, text, int.tryParse(question.comment_ID)));
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Enter your answer",
                                        alignLabelWithHint: true,
                                    ),
                                )
                            ),
                            _buildMyAnswerList(question.replies)
                        ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(
                            height: 1.0,
                            decoration: BoxDecoration(
                                color: HexColor.fromHex("#E2E5EB"),
                            )
                        ),
                    )
                ],
            ),
        );
    }

    _buildMyAnswerList(List<ReplyBean> replies) {
        return (replies.length > 0)
            ? ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: replies.length,
                itemBuilder: (context, index) {
                    return _buildMyAnswer(replies[index]);
                })
            : Center();
    }

    _buildMyAnswer (ReplyBean reply) {
        return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: SvgPicture.asset(
                                            "assets/icons/star.svg",
                                            color: mainColor,
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                            reply.author.login,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: mainColor
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Container(
                                    width: 1,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        color: HexColor.fromHex("#E2E5EB"),
                                    )
                                ),
                            ),
                            Text(
                                reply.datetime,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: HexColor.fromHex("#AAAAAA")
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Container(
                                    width: 1,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        color: HexColor.fromHex("#E2E5EB"),
                                    )
                                ),
                            ),
                            SizedBox(
                                width: 12,
                                height: 12,
                                child: SvgPicture.asset(
                                    "assets/icons/flag.svg",
                                    color: HexColor.fromHex("#AAAAAA"),
                                )
                            ),
                        ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Html(
                            data: reply.content,
                            defaultTextStyle: TextStyle(
                                fontSize: 14.0,
                                color: HexColor.fromHex("#273044")
                            )
                        ),
                    ),
                ],
            ),
        );
    }

    _buildBottom(QuestionsState state) {

        if(state is InitialQuestionsState) {
            return Center(
                child: CircularProgressIndicator(),
            );
        }

        if(state is LoadedQuestionsState) {
            return Container(
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#273044"),
                    boxShadow: [
                        BoxShadow(
                            color: HexColor.fromHex("#000000").withOpacity(.1),
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            spreadRadius: 2
                        )
                    ]
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            SizedBox(
                                width: 35,
                                height: 35,
                                child: Center(),
                            ),
                            Expanded(
                                flex: 8,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: MaterialButton(
                                        height: 50,
                                        color: mainColor,
                                        onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                QuestionAskScreen.routeName,
                                                arguments: QuestionAskScreenArgs(widget.lessonId),
                                            ).then((value) {
                                                _refreshState();
                                            });
                                        },
                                        child: Text(
                                            "ASK A QUESTION",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontSize: 14.0
                                            ),
                                        )
                                    )
                                ),
                            ),
                            SizedBox(
                                width: 35,
                                height: 35,
                                child: Center(),
                            )
                        ],
                    ),
                ),
            );
        }
    }

    _refreshState() {
        _bloc.add(FetchEvent(widget.lessonId, widget.page, "", ""));
    }
}