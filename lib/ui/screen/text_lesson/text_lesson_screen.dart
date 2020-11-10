import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/text_lesson/bloc.dart';
import 'package:masterstudy_app/ui/screen/assignment/assignment_screen.dart';
import 'package:masterstudy_app/ui/screen/final/final_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_stream/lesson_stream_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_video/lesson_video_screen.dart';
import 'package:masterstudy_app/ui/screen/questions/questions_screen.dart';
import 'package:masterstudy_app/ui/screen/quiz_lesson/quiz_lesson_screen.dart';
import 'package:masterstudy_app/ui/screen/user_course_locked/user_course_locked_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../main.dart';

class TextLessonScreenArgs {
  final int lessonId;
  final int courseId;
  final String authorAva;
  final String authorName;
  final bool hasPreview;
  final bool trial;

  TextLessonScreenArgs(this.courseId, this.lessonId, this.authorAva, this.authorName, this.hasPreview, this.trial);
}

class TextLessonScreen extends StatelessWidget {
  static const routeName = "textLessonScreen";
  final TextLessonBloc bloc;

  const TextLessonScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    TextLessonScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<TextLessonBloc>(
        create: (context) => bloc,
        child: TextLessonWidget(args.courseId, args.lessonId, args.authorAva, args.authorName, args.hasPreview, args.trial));
  }
}

class TextLessonWidget extends StatefulWidget {
  final int lessonId;
  final int courseId;
  final String authorAva;
  final String authorName;
  final bool hasPreview;
  final bool trial;

  const TextLessonWidget(
    this.courseId,
    this.lessonId,
      this.authorAva,
      this.authorName,
      this.hasPreview,
      this.trial
  ) : super();

  @override
  State<StatefulWidget> createState() {
    return TextLessonWidgetState();
  }
}

class TextLessonWidgetState extends State<TextLessonWidget> {
  TextLessonBloc _bloc;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TextLessonBloc>(context)
      ..add(FetchEvent(widget.courseId, widget.lessonId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextLessonBloc, TextLessonState>(
      bloc: _bloc,
      builder: (BuildContext context, TextLessonState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor.fromHex("#273044"),
            title: _buildTitle(state),
          ),
          body: _buildBody(state),
          bottomNavigationBar: (!widget.trial) ? null : _buildBottomNavigation(state),
        );
      },
    );
  }

  _buildTitle(TextLessonState state) {
    if (state is InitialTextLessonState) return Center();
    if (state is LoadedTextLessonState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
            Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  state.lessonResponse.section.number,
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                Flexible(
                  child: Text(
                    state.lessonResponse.section.label,
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
          (widget.hasPreview) ? Center() : SizedBox(
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

  _buildBody(TextLessonState state) {
    if (state is InitialTextLessonState) return _buildLoading();
    if (state is LoadedTextLessonState) return _buildWebView(state);
  }

  _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  WebViewController _webViewController;
  bool showLoadingWebview = true;

  _buildWebView(LoadedTextLessonState state) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(state.lessonResponse.content))}',
      onPageFinished: (some) async {},
      onWebViewCreated: (controller) async {
        controller.clearCache();
        this._webViewController = controller;
      },
    );
  }

  _buildBottomNavigation(TextLessonState state) {
    if(state is InitialTextLessonState)
      return Center(child: CircularProgressIndicator());

    if(state is LoadedTextLessonState) {
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
                  child: (state.lessonResponse.prev_lesson !=
                      "") ? FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: mainColor)),
                    onPressed: () {
                      switch (state.lessonResponse.prev_lesson_type) {
                        case "video":
                          Navigator.of(context).pushReplacementNamed(LessonVideoScreen.routeName,
                            arguments: LessonVideoScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.prev_lesson), widget.authorAva, widget.authorName, widget.hasPreview, widget.trial),
                          );
                          break;
                        case "quiz":
                          Navigator.of(context).pushReplacementNamed(QuizLessonScreen.routeName,
                            arguments: QuizLessonScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.prev_lesson), widget.authorAva, widget.authorName
                            ),
                          );
                          break;
                        case "assignment":
                          Navigator.of(context).pushReplacementNamed(
                            AssignmentScreen.routeName,
                            arguments: AssignmentScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.prev_lesson), widget.authorAva, widget.authorName),
                          );
                          break;
                        case "stream":
                          Navigator.of(context).pushReplacementNamed(
                            LessonStreamScreen.routeName,
                            arguments: LessonStreamScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.prev_lesson), widget.authorAva, widget.authorName),
                          );
                          break;
                        default:
                          Navigator.of(context).pushReplacementNamed(TextLessonScreen.routeName,
                            arguments: TextLessonScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.prev_lesson), widget.authorAva, widget.authorName, widget.hasPreview, widget.trial),
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
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        if (state is LoadedTextLessonState &&
                            !state.lessonResponse.completed) {
                          _bloc.add(CompleteLessonEvent(
                              widget.courseId, widget.lessonId));
                          setState(() {
                            completed = true;
                          });
                        } else if(state.lessonResponse.completed && !state.lessonResponse.next_lesson_available) {
                          /*Navigator.of(context).pushNamed(FinalScreen.routeName,
                            arguments: FinalScreenArgs(widget.courseId),
                          );*/
                        }
                      },
                      child: _buildButtonChild(state)),
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: (state.lessonResponse.next_lesson !=
                    "") ? FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      side: BorderSide(color: mainColor)),
                  onPressed: () {
                    if(state.lessonResponse.next_lesson_available) {
                      switch (state.lessonResponse.next_lesson_type) {
                        case "video":
                          Navigator.of(context).pushReplacementNamed(LessonVideoScreen.routeName,
                            arguments: LessonVideoScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.next_lesson), widget.authorAva, widget.authorName, widget.hasPreview, widget.trial),
                          );
                          break;
                        case "quiz":
                          Navigator.of(context).pushReplacementNamed(QuizLessonScreen.routeName,
                            arguments: QuizLessonScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.next_lesson), widget.authorAva, widget.authorName),
                          );
                          break;
                        case "assignment":
                          Navigator.of(context).pushReplacementNamed(
                            AssignmentScreen.routeName,
                            arguments: AssignmentScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.next_lesson), widget.authorAva, widget.authorName),
                          );
                          break;
                        case "stream":
                          Navigator.of(context).pushReplacementNamed(
                            LessonStreamScreen.routeName,
                            arguments: LessonStreamScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.next_lesson), widget.authorAva, widget.authorName),
                          );
                          break;
                        default:
                          Navigator.of(context).pushReplacementNamed(TextLessonScreen.routeName,
                            arguments: TextLessonScreenArgs(widget.courseId, int.tryParse(state.lessonResponse.next_lesson), widget.authorAva, widget.authorName, widget.hasPreview, widget.trial),
                          );
                      }
                    } else {
                      Navigator.of(context).pushNamed(
                        UserCourseLockedScreen.routeName,
                        arguments: UserCourseLockedScreenArgs(widget.courseId),
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

  _buildButtonChild(TextLessonState state) {

    if (state is InitialTextLessonState)
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    if (state is LoadedTextLessonState) {
      Widget icon;
      if (state.lessonResponse.completed || completed) {
        icon = Icon(Icons.check_circle);
      } else {
        icon = Icon(Icons.panorama_fish_eye);
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              localizations.getLocalization("complete_lesson_button"),
              textScaleFactor: 1.0,
              
            ),
          )
        ],
      );
    }
  }
}
