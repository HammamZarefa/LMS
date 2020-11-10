import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/QuestionAddResponse.dart';
import 'package:masterstudy_app/data/models/QuestionsResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/question_details/bloc.dart';

class QuestionDetailsScreenArgs {
    final QuestionBean questionBean;
    final int lessonId;

    QuestionDetailsScreenArgs(this.lessonId, this.questionBean);
}

class QuestionDetailsScreen extends StatelessWidget {
    static const routeName = "questionDetailsScreen";
    final QuestionDetailsBloc bloc;

    const QuestionDetailsScreen(this.bloc) : super();

    @override
    Widget build(BuildContext context) {
        QuestionDetailsScreenArgs args = ModalRoute.of(context).settings.arguments;
        return BlocProvider<QuestionDetailsBloc>(
            create: (context) => bloc,
            child: QuestionDetailsWidget(args.lessonId, args.questionBean));
    }
}

class QuestionDetailsWidget extends StatefulWidget {
    final QuestionBean questionBean;
    final int lessonId;

    const QuestionDetailsWidget(this.lessonId, this.questionBean) : super();

    @override
    State<StatefulWidget> createState() {
        return QuestionDetailsWidgetState();
    }
}

class QuestionDetailsWidgetState extends State<QuestionDetailsWidget> {
    QuestionDetailsBloc _bloc;
    bool completed = false;
    TextEditingController _reply = TextEditingController();
    List<QuestionAddBean> newReply = List<QuestionAddBean>();
    List<ReplyBean> aList;


    @override
    void initState() {
        super.initState();
        _bloc = BlocProvider.of<QuestionDetailsBloc>(context)..add(FetchEvent());
        aList = widget.questionBean.replies;
    }

    @override
    Widget build(BuildContext context) {
        return BlocListener(
            bloc: _bloc,
            listener: (context, state) {
                if (state is ReplyAddedState) {
                    setState(() {
                        this.newReply.insert(0, state.questionAddResponse.comment);
                    });
                }
            },
            child: BlocBuilder<QuestionDetailsBloc, QuestionDetailsState>(
                builder: (context, state) {
                    return Scaffold(
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
                        ),
                        body: SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        _buildBodyHead(state),
                                        _buildAddedReply(),
                                        Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: (widget.questionBean.replies.length != 0) ? _buildList(aList) : Center()
                                        ),
                                    ]
                                )
                            )
                        )
                    );
                }
            ),
        );
    }

    _buildBodyHead(QuestionDetailsState state) {
        if (state is InitialQuestionDetailsState)
            return Center(
                child: CircularProgressIndicator(),
            );

        if (state is LoadedQuestionDetailsState)
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Html(
                            data: widget.questionBean.content,
                            defaultTextStyle: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                                color: HexColor.fromHex("#273044")
                            )
                        ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Text(
                                widget.questionBean.author.login,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: mainColor
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Container(
                                    width: 2,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        color: HexColor.fromHex("#E2E5EB"),
                                    )
                                ),
                            ),
                            Text(
                                widget.questionBean.datetime,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: HexColor.fromHex("#AAAAAA")
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0),
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
                        padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
                        child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _reply,
                            maxLines: 2,
                            textAlignVertical: TextAlignVertical.top,
                            onFieldSubmitted: (text) {
                                _reply.clear();
                                _bloc.add(QuestionAddEvent(
                                    widget.lessonId, text, int.tryParse(widget.questionBean.comment_ID)));
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: localizations.getLocalization("enter_your_answer"),
                                alignLabelWithHint: true,
                            ),
                        )
                    ),
                ],
            );
    }

    _buildAddedReply () {
        if(this.newReply.length > 0) {

            return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: newReply.length,
                itemBuilder: (context, index) {
                    return _buildReply(this.newReply[index]);
                });
        }

        return Center();
    }

    _buildList(List<ReplyBean> replies) {
        return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: replies.length,
            itemBuilder: (context, index) {
                return _buildQuestion(replies[index]);
            });
    }

    _buildQuestion (ReplyBean reply) {
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

    _buildReply (QuestionAddBean reply) {
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
}