import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/QuestionAddResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/question_ask/bloc.dart';

class QuestionAskScreenArgs {
    final int lessonId;

    QuestionAskScreenArgs(this.lessonId);
}

class QuestionAskScreen extends StatelessWidget {
    static const routeName = "questionAskScreen";
    final QuestionAskBloc bloc;

    const QuestionAskScreen(this.bloc) : super();

    @override
    Widget build(BuildContext context) {
        QuestionAskScreenArgs args = ModalRoute.of(context).settings.arguments;
        return BlocProvider<QuestionAskBloc>(
            create: (context) => bloc,
            child: QuestionAskWidget(args.lessonId));
    }
}

class QuestionAskWidget extends StatefulWidget {
    final int lessonId;

    const QuestionAskWidget(this.lessonId) : super();

    @override
    State<StatefulWidget> createState() {
        return QuestionAskWidgetState();
    }
}

class QuestionAskWidgetState extends State<QuestionAskWidget> {
    QuestionAskBloc _bloc;
    bool sendRequest = false;
    TextEditingController textController = TextEditingController();


    @override
    void initState() {
        super.initState();
        _bloc = BlocProvider.of<QuestionAskBloc>(context)..add(FetchEvent());
    }

    @override
    Widget build(BuildContext context) {
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
                body: BlocListener(
                    bloc: _bloc,
                    listener: (context, state) {
                        if (state is QuestionAddedState) {
                            textController.clear();

                            setState(() {
                              sendRequest = false;
                            });

                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(state.questionAddResponse.message,
                                    textScaleFactor: 1.0,),
                                duration: Duration(seconds: 5),
                                action: SnackBarAction(
                                    label: localizations.getLocalization("ok_dialog_button"),
                                    onPressed: () {
                                        Navigator.of(context).pop();
                                    },
                                ),
                            ));
                        }
                    },
                    child: BlocBuilder<QuestionAskBloc, QuestionAskState>(
                        builder: (context, state) {
                            return SingleChildScrollView(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(top: 0),
                                                child: Text(
                                                    localizations.getLocalization("ask_your_question"),
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: HexColor.fromHex("#273044"),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18
                                                    )
                                                )
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0),
                                                child: TextFormField(
                                                    textInputAction: TextInputAction.done,
                                                    controller: textController,
                                                    maxLines: 8,
                                                    textAlignVertical: TextAlignVertical
                                                        .top,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        labelText: localizations.getLocalization("enter_review"),
                                                        alignLabelWithHint: true,
                                                    ),
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50.0, bottom: 20.0),
                                                child: new MaterialButton(
                                                    minWidth: double.infinity,
                                                    color: secondColor,
                                                    onPressed: () {
                                                        if(textController.text != "") {
                                                            _bloc.add(
                                                                QuestionAddEvent(
                                                                    widget.lessonId,
                                                                    textController
                                                                        .text));
                                                            setState(() {
                                                                sendRequest = true;
                                                            });
                                                        }
                                                    },
                                                    child: (!sendRequest) ? Text(
                                                        "SUBMIT",
                                                        textScaleFactor: 1.0,
                                                    ) : Center(
                                                        child: SizedBox(
                                                            width: 20,
                                                            height: 20,
                                                            child: CircularProgressIndicator(
                                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                            ),
                                                        )
                                                    ),
                                                    textColor: Colors.white,
                                                ),
                                            ),
                                        ]
                                    )
                                )
                            );
                        }
                    ),
                )
        );
    }
}