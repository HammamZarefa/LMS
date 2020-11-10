import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:masterstudy_app/data/models/AssignmentResponse.dart';
import 'package:masterstudy_app/theme/theme.dart';

import '../../../bloc/assignment/bloc.dart';

class AssignmentInfoWidget extends StatefulWidget {
    final AssignmentResponse assignmentResponse;

    const AssignmentInfoWidget(this.assignmentResponse) : super();

    @override
    State<StatefulWidget> createState() {
        return _AssignmentInfoWidgetState();
    }
}

class _AssignmentInfoWidgetState extends State<AssignmentInfoWidget> {

    @override
    Widget build(BuildContext context) {
        return Padding(
                    padding: EdgeInsets.all(0.0),
                    child: _buildContent(),
                );
    }

    _buildContent() {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 20.0, right: 7.0, bottom: 20.0, left: 7.0),
                    child: Html(
                        data: widget.assignmentResponse.title,
                        defaultTextStyle: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.w700,
                            color: HexColor.fromHex("#273044")
                        ),
                    ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 7.0, left: 7.0),
                    child: Html(
                            data: widget.assignmentResponse.content,
                        )
                ),
            ],
        );
    }
}