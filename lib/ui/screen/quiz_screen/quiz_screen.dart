import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterstudy_app/data/models/QuizResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/quiz_screen/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'timer_widget.dart';

class QuizScreenArgs {
  final QuizResponse quizResponse;
  final int lessonId;
  final int courseId;

  QuizScreenArgs(this.quizResponse, this.lessonId, this.courseId);
}

class QuizScreen extends StatelessWidget {
  static const routeName = "quizScreen";
  final QuizScreenBloc bloc;

  const QuizScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    QuizScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<QuizScreenBloc>(
      create: (c) => bloc,
      child: QuizScreenWidget(args.quizResponse, args.lessonId, args.courseId),
    );
  }
}

class QuizScreenWidget extends StatefulWidget {
  final QuizResponse quizResponse;

  int lessonId;

  int courseId;

  QuizScreenWidget(this.quizResponse, this.lessonId, this.courseId) : super();

  @override
  State<StatefulWidget> createState() {
    return QuizScreenWidgetState();
  }
}

class QuizScreenWidgetState extends State<QuizScreenWidget> {
  QuizScreenBloc _bloc;

  WebViewController _webViewController;


  int courseId;
  int lessonId;

  @override
  void initState() {
    super.initState();
    courseId = widget.courseId;
    lessonId = widget.lessonId;
    _bloc = BlocProvider.of<QuizScreenBloc>(context);
    _bloc.add(FetchEvent(courseId, lessonId, widget.quizResponse));
  }

  bool isCoursePassed(QuizResponse response) {
    bool passed = false;
    if (response.quiz_data.isNotEmpty) {
      widget.quizResponse.quiz_data.forEach((value) {
        if (value.status == "passed") passed = true;
      });
    }
    return passed;
  }

  _fetchCourse() {
    _bloc.add(FetchEvent(courseId, lessonId, null));
  }

  _startQuiz() {
    if (_webViewController != null)
      _webViewController.evaluateJavascript("stm_lms_start_quiz()");
  }

  _completeQuiz() {
    _webViewController.evaluateJavascript("stm_lms_accept_quiz()");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizScreenBloc, QuizScreenState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor.fromHex("#273044"),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Quiz 1:",
                      textScaleFactor: 1.0,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    Text(
                      "Mobile Native Apps",
                      textScaleFactor: 1.0,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: _buildBody(),
        );
      },
    );
  }

  _buildBody() {
    return _buildWebView();
  }




  _buildWebView() {
    return Stack(
      children: <Widget>[ 
        WebView(
          initialUrl: widget.quizResponse.view_link,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (some) async {


          },
          onPageStarted: (some) {

          },
          onWebViewCreated: (controller) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String header = prefs.get("apiToken");

            controller.clearCache();
            this._webViewController = controller;
            controller.loadUrl(widget.quizResponse.view_link,
                headers: {"token": header});
          },
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: "lmsEvent",
                onMessageReceived: (JavascriptMessage result) {
                  //_handleEvent(result.message);
                }),
          ]),
        )
      ],
    );
  }
}
