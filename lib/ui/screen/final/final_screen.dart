import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/final/bloc.dart';
import 'package:masterstudy_app/ui/screen/review_write/review_write_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FinalScreenArgs {
    final int course_id;

    FinalScreenArgs(this.course_id);
}

class FinalScreen extends StatelessWidget {
    static const routeName = 'finalScreen';
    final FinalBloc _bloc;

    const FinalScreen(this._bloc) : super();

    @override
    Widget build(BuildContext context) {
        final FinalScreenArgs args = ModalRoute.of(context).settings.arguments;

        return BlocProvider<FinalBloc>(
            create: (c) => _bloc, child: _FinalScreenWidget(args.course_id)
        );
    }
}

class _FinalScreenWidget extends StatefulWidget {
    final num course_id;
    const _FinalScreenWidget(this.course_id);

    @override
    State<StatefulWidget> createState() {
        return _FinalScreenState();
    }
}

class _FinalScreenState extends State<_FinalScreenWidget> {
    FinalBloc _bloc;
    double width;
    double progressWrapWidth;

    @override
    void initState() {
        super.initState();
        _bloc = BlocProvider.of<FinalBloc>(context)..add(FetchEvent(widget.course_id));
    }

    @override
    Widget build(BuildContext context) {
        width = MediaQuery.of(context).size.width;
        progressWrapWidth = (width - 60.0);

        return Scaffold(
            appBar: AppBar(
                backgroundColor: HexColor.fromHex("#273044"),
                title: Text(
                    "Final page",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0
                    ),
                ),
            ),
            body: BlocBuilder<FinalBloc, FinalState>(
                bloc: _bloc,
                builder: (context, state) {
                    return SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
                            child: _buildBody(state),
                        ),
                    );
                })
        );
    }

    _buildBody(FinalState state) {
        if (state is LoadedFinalState) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: Text(
                            (state.finalResponse.course_completed) ? "You have successfully completed the course" : "You have NO completed the course",
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: HexColor.fromHex("#2A3045")
                            ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: Text(
                            state.finalResponse.title + "!",
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: HexColor.fromHex("#2A3045")
                            ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Stack(
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                    child: Container(
                                        width: progressWrapWidth,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: HexColor.fromHex("#EEF1F7"), width: 1),
                                            borderRadius: BorderRadius.circular(10.0)
                                        ),
                                        child: _buildProgressBar(state, state.finalResponse.course.progress_percent)
                                    ),
                                ),
                                Positioned(
                                    top: 0.0,
                                    child: _buildProgressTitle(state, state.finalResponse.course.progress_percent),
                                )
                            ],
                        ),
                    ),
                    (state.finalResponse.course_completed)
                        ? Center()
                        : Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Text(
                            "To take the course again and improve your results, please return to the curriculum",
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: HexColor.fromHex("#2A3045")
                            ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 20.0,
                            children: <Widget>[
                                if(state.finalResponse.curriculum.lesson != null) _buildCard(state, "assets/icons/final_pages.svg", "#2476F5", "PAGES", "${state.finalResponse.curriculum.lesson.completed}/${state.finalResponse.curriculum.lesson.total}"),
                                if(state.finalResponse.curriculum.multimedia != null) _buildCard(state, "assets/icons/final_video.svg", "#F61B40", "VIDEO", "${state.finalResponse.curriculum.multimedia.completed}/${state.finalResponse.curriculum.multimedia.total} hrs"),
                                if(state.finalResponse.curriculum.assignment != null) _buildCard(state, "assets/icons/assignnments_icon.svg", "#E9B356", "ASSIGNMENT", "${state.finalResponse.curriculum.assignment.completed}/${state.finalResponse.curriculum.assignment.total}"),
                                if(state.finalResponse.curriculum.quiz != null) _buildCard(state, "assets/icons/final_quizes.svg", "#13C79B", "QUIZES", "${state.finalResponse.curriculum.quiz.completed}/${state.finalResponse.curriculum.quiz.total}"),
                            ],
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: _buildButtons(state),
                    )
                ],
            );
        }

        if (state is InitialFinalState) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: CircularProgressIndicator()
                ),
            );
        }
    }

    _buildCard(FinalState state, String ico, String icoHexColor, String title, String value) {

        if (state is InitialFinalState) {
            return Center(
                child: CircularProgressIndicator(),
            );
        }

        if (state is LoadedFinalState) {
            return Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
                  width: width * 0.40,
                  decoration: BoxDecoration(
                      border: Border.all(color: HexColor.fromHex("#EEF1F7"), width: 1),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(top: 20.0, right: 20.0, bottom: 20.0, left: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Container(
                                      width: 35,
                                      child: Center(
                                          child: SvgPicture.asset(
                                              ico,
                                              color: HexColor.fromHex(icoHexColor),
                                              width: 30.0,
                                              height: 30.0,
                                          ),
                                      ),
                                  ),
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 0),
                                          child: Text(
                                              title,
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500
                                              )
                                          ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 3.0),
                                          child: Text(
                                              value,
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w500
                                              )
                                          ),
                                      ),
                                  ],
                              ),
                          ],
                      ),
                  )
              ),
            );
        }
    }

    _buildProgressBar(FinalState state, int percent) {
        if(state is InitialFinalState)
            return Center(
                child: CircularProgressIndicator(),
            );

        if(state is LoadedFinalState) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container(
                        width: (width - 62.0) * (percent / 100),
                        height: 74.0,
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#EEF1F7"),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                    )
                ],
            );
        }
    }

    _buildProgressTitle(LoadedFinalState state, int percent) {

        if(state.finalResponse.course_completed) {
            return Container(
                width: progressWrapWidth,
                height: 96.0,
                child: Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            SvgPicture.asset(
                                "assets/icons/final_badge.svg",
                                width: 96.0,
                                height: 96.0,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                    percent.toString() + "%",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 45.0,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor.fromHex("#2A3045")
                                    ),
                                ),
                            )
                        ],
                    ),
                )
            );
        }

        return Container(
            width: progressWrapWidth,
            height: 96.0,
            child: Center(
                child: Text(
                    percent.toString() + "%",
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w700,
                        color: HexColor.fromHex("#2A3045")
                    ),
                ),
            ),
        );
    }

    _buildButtons(FinalState state) {
        if(state is InitialFinalState)
            return Center(
                child: CircularProgressIndicator(),
            );

        if(state is LoadedFinalState) {
            if(state.finalResponse.course_completed) {
                return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(
                                "Your certificate is available for download.",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: HexColor.fromHex("#AAAAAA"),
                                    fontSize: 14.0
                                ),
                            ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: MaterialButton(
                                    height: 50,
                                    color: mainColor,
                                    onPressed: () {
                                        _downloadCertificate(state.finalResponse.certificate_url);
                                    },
                                    child: Text(
                                        "DOWNLOAD CERTIFICATE",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 14.0
                                        ),
                                    )
                                )
                            ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: MaterialButton(
                                    height: 50,
                                    color: secondColor,
                                    onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            ReviewWriteScreen.routeName,
                                            arguments: ReviewWriteScreenArgs(
                                                state.finalResponse.course.course_id, state.finalResponse.title),
                                        );
                                    },
                                    child: Text(
                                        "LEAVE REVIEW",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: white
                                        ),
                                    )
                                )
                            ),
                        ),
                    ],
                );
            } else {
                return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        SizedBox(
                            width: double.infinity,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: MaterialButton(
                                    height: 50,
                                    color: mainColor,
                                    onPressed: () {
                                        Navigator.of(context).pop();
                                    },
                                    child: Text(
                                        "CURRICULUM",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 14.0
                                        ),
                                    )
                                )
                            ),
                        ),
                    ],
                );
            }
        }
    }

    _downloadCertificate(String downloadUrl) async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String header = prefs.get("apiToken");
        await launch(downloadUrl, headers: {'token': header});
    }
}