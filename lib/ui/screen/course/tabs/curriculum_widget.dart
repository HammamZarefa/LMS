import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/screen/lesson_video/lesson_video_screen.dart';
import 'package:masterstudy_app/ui/screen/text_lesson/text_lesson_screen.dart';

import '../../../../main.dart';

class CurriculumWidget extends StatefulWidget{
  final CourseDetailResponse response;

  CurriculumWidget(this.response) : super();

  @override
  _CurriculumWidgetState createState() => _CurriculumWidgetState();
}

class _CurriculumWidgetState extends State<CurriculumWidget> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.response.curriculum.length,
        itemBuilder: (context, index) {
          var curriculumBean = widget.response.curriculum[index];
          if (curriculumBean.type == "section") {
            return _buildSection(curriculumBean);
          } else if (curriculumBean.type == "lesson") {
            return _buildLesson(context, curriculumBean);
          }else if( curriculumBean.type == "quiz"){
            return _buildQuiz(curriculumBean);
          }
          return Center();
        });
  }

  _buildSection(CurriculumBean curriculumBean) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            curriculumBean.view,
            textScaleFactor: 1.0,
            style: TextStyle(color: HexColor.fromHex("#AAAAAA")),
          ),
          Text(
            curriculumBean.label,
            textScaleFactor: 1.0,
            style: TextStyle(
                color: HexColor.fromHex("#273044"),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _buildLesson(BuildContext context, CurriculumBean curriculumBean) {
    Widget icon = Center();
    if (curriculumBean.view == "video")
      icon = SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
              "assets/icons/ico_play.svg",
              color: (curriculumBean.has_preview) ? mainColor : HexColor.fromHex("#2A3045").withOpacity(0.3)
          ));
    if (curriculumBean.view == "assignment")
      icon = SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
              "assets/icons/assignment_icon.svg",
              color: (curriculumBean.has_preview) ? mainColor : HexColor.fromHex("#2A3045").withOpacity(0.3)
          ));
    if (curriculumBean.view == "slide")
      icon = SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
              "assets/icons/slides_icon.svg",
              color: (curriculumBean.has_preview) ? mainColor : HexColor.fromHex("#2A3045").withOpacity(0.3)
          ));
    if (curriculumBean.view == "stream")
      icon = SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
              "assets/icons/video-camera.svg",
              color: (curriculumBean.has_preview) ? mainColor : HexColor.fromHex("#2A3045").withOpacity(0.3)
          ));
    if (curriculumBean.view == "quiz")
      icon = SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
              "assets/icons/ico_question.svg",
              color: (curriculumBean.has_preview) ? mainColor : HexColor.fromHex("#2A3045").withOpacity(0.3)
          ));
    if (curriculumBean.view == "text" || curriculumBean.view == "")
      icon = SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
              "assets/icons/ico_text.svg",
              color: (curriculumBean.has_preview) ? mainColor : HexColor.fromHex("#2A3045").withOpacity(0.3)
          ));

    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        decoration: BoxDecoration(color: HexColor.fromHex("#F3F5F9")),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 16, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              icon,
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8.0),
                  child: Text(
                    curriculumBean.label,
                    textScaleFactor: 1.0,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
              (curriculumBean.has_preview || widget.response.trial) ?
              Container(
                constraints: BoxConstraints(minWidth: 110, maxWidth: 110),
                height: 36,
                child: MaterialButton(
                  height: 36,
                  minWidth: 110,
                  padding: EdgeInsets.only(left: 0, right: 0),
                  color: secondColor,
                  onPressed: () {
                    switch (curriculumBean.view) {
                      case "video":
                        Navigator.of(context).pushNamed(
                          LessonVideoScreen.routeName,
                          arguments: LessonVideoScreenArgs(widget.response.id, int
                              .tryParse(curriculumBean.lesson_id), widget.response
                              .author.avatar_url, widget.response.author.login,
                              curriculumBean.has_preview, false),
                        );
                        break;
                      default:
                        Navigator.of(context).pushNamed(
                          TextLessonScreen.routeName,
                          arguments: TextLessonScreenArgs(widget.response.id, int
                              .tryParse(curriculumBean.lesson_id), widget.response
                              .author.avatar_url, widget.response.author.login,
                              curriculumBean.has_preview, false),
                        );
                    }
                  },
                  child: Text(
                      localizations.getLocalization("preview_button"),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.4,

                      )
                  ),
                ),
              ) : Center(),
            ],
          ),
        ),
      ),
    );
  }

  _buildQuiz(CurriculumBean curriculumBean) {
    Widget icon = SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
              "assets/icons/ico_question.svg",
              color: (curriculumBean.has_preview) ? mainColor : HexColor.fromHex("#2A3045").withOpacity(0.3)
          ));

    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        decoration: BoxDecoration(color: HexColor.fromHex("#F3F5F9")),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 16, left: 20, right: 20),
          child: Row(

            children: <Widget>[
              icon,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8.0),
                  child: Text(
                    curriculumBean.label,
                    textScaleFactor: 1.0,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
