import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:masterstudy_app/data/models/AssignmentResponse.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/assignment/bloc.dart';
import 'package:masterstudy_app/ui/screen/assignment/assignment_parts/assignment_info.dart';

class AssignmentPassUnpassWidget extends StatefulWidget {
    final AssignmentBloc _bloc;
    final AssignmentResponse assignmentResponse;
    final int courseId;
    final int assignmentId;
    final String authorAva;
    final String authorName;

    const AssignmentPassUnpassWidget(this._bloc, this.assignmentResponse, this.courseId, this.assignmentId, this.authorAva, this.authorName) : super();

    @override
    State<StatefulWidget> createState() {
        return _AssignmentPassUnpassWidgetState();
    }
}

class _AssignmentPassUnpassWidgetState extends State<AssignmentPassUnpassWidget> {
    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 7.0, bottom: 10.0, left: 7.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#EEF1F7"),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 12.0, right: 12.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    Container(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(60.0),
                                            child: Container (
                                                decoration: BoxDecoration(
                                                    color: (widget.assignmentResponse.status == 'passed') ? secondColor : HexColor.fromHex("#F44336")
                                                ),
                                                child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Icon(
                                                        (widget.assignmentResponse.status == 'passed') ? Icons.check : Icons.close,
                                                        color: Colors.white,
                                                        size: 30.0,
                                                    ),
                                                ),
                                            ),
                                        ),
                                        margin: EdgeInsets.only(right: 10.0),
                                    ),
                                    Text(
                                        widget.assignmentResponse.label,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color: HexColor.fromHex("#273044"),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700
                                        ),
                                    )
                                ],
                            )
                        ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5.0, left: 7.0, right: 7.0),
                    child: Html(
                        data: (widget.assignmentResponse.comment != null) ? widget.assignmentResponse.comment : "",
                        defaultTextStyle: TextStyle(
                            fontSize: 13.0,
                        ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 7.0, right: 7.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        widget.authorAva,
                                    )
                                )
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text(
                                        "Teacher",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 14.0
                                        ),
                                    ),
                                    Text(
                                        widget.authorName,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: mainColor
                                        ),
                                    )
                                ],
                            )
                        ],
                    ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 7.0, right: 7.0),
                    child: Container(
                        height: 2.0,
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#E2E5EB"),
                        )
                    ),
                ),
                (widget.assignmentResponse.status == 'unpassed') ?
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 7.0, right: 7.0),
                    child: MaterialButton(
                        height: 50,
                        color: mainColor,
                        onPressed: () {
                            widget._bloc.add(StartAssignmentEvent( widget.courseId, widget.assignmentId));
                        },
                        child: Text(
                            "Retake Assignment",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: Colors.white
                            )
                        ),
                    )
                ) : Center(),
                AssignmentInfoWidget(widget.assignmentResponse)
            ],
        );
    }


}