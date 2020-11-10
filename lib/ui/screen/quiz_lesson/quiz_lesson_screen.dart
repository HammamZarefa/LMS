import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/quiz_lesson/bloc.dart';
import 'package:masterstudy_app/ui/bloc/quiz_lesson/quiz_lesson_bloc.dart';
import 'package:masterstudy_app/ui/screen/assignment/assignment_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_stream/lesson_stream_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_video/lesson_video_screen.dart';
import 'package:masterstudy_app/ui/screen/questions/questions_screen.dart';
import 'package:masterstudy_app/ui/screen/quiz_screen/quiz_screen.dart';
import 'package:masterstudy_app/ui/screen/text_lesson/text_lesson_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuizLessonScreenArgs {
  final int lessonId;
  final int courseId;
  final String authorAva;
  final String authorName;

  QuizLessonScreenArgs(this.courseId, this.lessonId, this.authorAva, this.authorName);
}

class QuizLessonScreen extends StatelessWidget {
  static const routeName = "quizLessonScreen";
  final QuizLessonBloc bloc;

  const QuizLessonScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    QuizLessonScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<QuizLessonBloc>(
        create: (context) => bloc,
        child: QuizLessonWidget(args.courseId, args.lessonId, args.authorAva, args.authorName));
  }
}

class QuizLessonWidget extends StatefulWidget {
  final int lessonId;
  final int courseId;
  final String authorAva;
  final String authorName;

  const QuizLessonWidget(
      this.courseId,
      this.lessonId,
      this.authorAva,
      this.authorName
      ) : super();

  @override
  State<StatefulWidget> createState() {
    return QuizLessonWidgetState();
  }
}

class QuizLessonWidgetState extends State<QuizLessonWidget> {
  QuizLessonBloc _bloc;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<QuizLessonBloc>(context)
      ..add(FetchEvent(widget.courseId, widget.lessonId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizLessonBloc, QuizLessonState>(
      bloc: _bloc,
      builder: (BuildContext context, QuizLessonState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor.fromHex("#273044"),
            title: _buildTitle(state),
          ),
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNavigation(state),
        );
      },
    );
  }

  _buildTitle(QuizLessonState state) {
    if (state is InitialQuizLessonState) return Center();
    if (state is LoadedQuizLessonState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  state.quizResponse.section.number,
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                Flexible(
                  child: Text(
                    state.quizResponse.section.label,
                    textScaleFactor: 1.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: HexColor.fromHex("#3E4555"))),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  QuestionsScreen.routeName,
                  arguments: QuestionsScreenArgs(widget.lessonId, 1),
                );
              },
              padding: EdgeInsets.all(0.0),
              color: HexColor.fromHex("#3E4555"),
              child: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    "assets/icons/question_icon.svg",
                    color: Colors.white,
                  )),
            ),
          )
        ],
      );
    }
  }

  _buildBody(QuizLessonState state) {
    if (state is InitialQuizLessonState) return _buildLoading();
    if (state is LoadedQuizLessonState) return _buildWebView(state);
  }

  _buildLoading() => Center(
    child: CircularProgressIndicator(),
  );

  WebViewController _webViewController;
  bool showLoadingWebview = true;

  _buildWebView(LoadedQuizLessonState state) {
    return Stack(

      children: <Widget>[
        Visibility(
          visible: showLoadingWebview,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
          'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(state.quizResponse.content))}',
          onPageFinished: (some) async {
            setState(() {
              showLoadingWebview = false;
            });
          },
          onWebViewCreated: (controller) async {
            controller.clearCache();
            this._webViewController = controller;
          },
        ),
      ],

    );
  }

  _buildBottomNavigation(QuizLessonState state) {
    if (state is InitialQuizLessonState) {
      return Center();
    }

    if(state is LoadedQuizLessonState) {
      return Container(
        decoration:
            BoxDecoration(color: HexColor.fromHex("#FFFFFF"), boxShadow: [
          BoxShadow(
              color: HexColor.fromHex("#000000").withOpacity(.1),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 2)
        ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                  width: 35,
                  height: 35,
                  child: (state.quizResponse.next_lesson != "") ? FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: mainColor)),
                    onPressed: () {
                      switch (state.quizResponse.prev_lesson_type) {
                        case "video":
                          Navigator.of(context).pushReplacementNamed(LessonVideoScreen.routeName,
                            arguments: LessonVideoScreenArgs(widget.courseId, int.tryParse(state.quizResponse.prev_lesson), widget.authorAva, widget.authorName, false, true),
                          );
                          break;
                        case "quiz":
                          Navigator.of(context).pushReplacementNamed(QuizLessonScreen.routeName,
                            arguments: QuizLessonScreenArgs(widget.courseId, int.tryParse(state.quizResponse.prev_lesson), widget.authorAva, widget.authorName
                            ),
                          );
                          break;
                        case "assignment":
                          Navigator.of(context).pushReplacementNamed(
                            AssignmentScreen.routeName,
                            arguments: AssignmentScreenArgs(widget.courseId, int.tryParse(state.quizResponse.prev_lesson), widget.authorAva, widget.authorName
                            ),
                          );
                          break;
                        case "stream":
                          Navigator.of(context).pushReplacementNamed(
                            LessonStreamScreen.routeName,
                            arguments: LessonStreamScreenArgs(widget.courseId, int.tryParse(state.quizResponse.prev_lesson), widget.authorAva, widget.authorName),
                          );
                          break;
                        default:
                          Navigator.of(context).pushReplacementNamed(
                            TextLessonScreen.routeName,
                            arguments: TextLessonScreenArgs(widget.courseId, int.tryParse(state.quizResponse.prev_lesson), widget.authorAva, widget.authorName, false, true
                            ),
                          );
                      }
                    },
                    padding: EdgeInsets.all(0.0),
                    color: mainColor,
                    child: Icon(Icons.chevron_left),
                  ) : Center()
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                      height: 50,
                      color: mainColor,
                      onPressed: () {
                        if (state is LoadedQuizLessonState)
                          Navigator.of(context).pushNamed(QuizScreen.routeName,
                              arguments: QuizScreenArgs(state.quizResponse,
                                  widget.lessonId, widget.courseId));
                      },
                      child: _buildButtonChild(state)),
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: (state.quizResponse.next_lesson != "") ? FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      side: BorderSide(color: mainColor)),
                  onPressed: () {
                    switch (state.quizResponse.next_lesson_type) {
                      case "video":
                        Navigator.of(context).pushReplacementNamed(LessonVideoScreen.routeName,
                          arguments: LessonVideoScreenArgs(widget.courseId, int.tryParse(state.quizResponse.next_lesson), widget.authorAva, widget.authorName, false, true
                          ),
                        );
                        break;
                      case "quiz":
                        Navigator.of(context).pushReplacementNamed(QuizLessonScreen.routeName,
                          arguments: QuizLessonScreenArgs(widget.courseId, int.tryParse(state.quizResponse.next_lesson), widget.authorAva, widget.authorName
                          ),
                        );
                        break;
                      case "assignment":
                        Navigator.of(context).pushReplacementNamed(
                          AssignmentScreen.routeName,
                          arguments: AssignmentScreenArgs(widget.courseId, int.tryParse(state.quizResponse.next_lesson), widget.authorAva, widget.authorName),
                        );
                        break;
                      case "stream":
                        Navigator.of(context).pushReplacementNamed(
                          LessonStreamScreen.routeName,
                          arguments: LessonStreamScreenArgs(widget.courseId, int.tryParse(state.quizResponse.next_lesson), widget.authorAva, widget.authorName),
                        );
                        break;
                      default:
                        Navigator.of(context).pushReplacementNamed(TextLessonScreen.routeName,
                          arguments: TextLessonScreenArgs(widget.courseId, int.tryParse(state.quizResponse.next_lesson), widget.authorAva, widget.authorName, false, true
                          ),
                        );
                    }
                  },
                  padding: EdgeInsets.all(0.0),
                  color: mainColor,
                  child: Icon(Icons.chevron_right),
                ) : Center(),
              )
            ],
          ),
        ),
      );
    }
  }

  _buildButtonChild(QuizLessonState state) {
    if (state is InitialQuizLessonState)
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    return Text(localizations.getLocalization("start_quiz"), textScaleFactor: 1.0,);
  }
}

