import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:masterstudy_app/data/models/AssignmentResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/screen/assignment/assignment_parts/assignment_info.dart';

class AssignmentPendingWidget extends StatefulWidget {
    final AssignmentResponse assignmentResponse;

    const AssignmentPendingWidget(this.assignmentResponse) : super();

    @override
    State<StatefulWidget> createState() {
        return _AssignmentPendingWidgetState();
    }
}

class _AssignmentPendingWidgetState extends State<AssignmentPendingWidget> {
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
                                                    color: mainColor
                                                ),
                                                child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Icon(
                                                        Icons.more_horiz,
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
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 7.0, right: 7.0),
                    child: Container(
                        height: 2.0,
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#E2E5EB"),
                        )
                    ),
                ),
                AssignmentInfoWidget(widget.assignmentResponse),
                _filesList(widget.assignmentResponse.files)
            ],
        );
    }

    _filesList(List<FilesBean> files) {
        if (files == null || files.isEmpty) return Center();

        return Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: files.length,
                itemBuilder: (context, index) {
                    FilesBean item = files[index];

                    return Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container (
                                color: HexColor.fromHex("#EEF1F7"),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0, right: 15.0, left: 15.0),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                            Icon(
                                                Icons.cloud_download,
                                                color: mainColor,
                                                size: 22.0,
                                            ),
                                            Expanded(
                                                flex: 8,
                                                child:
                                                Padding(
                                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                    child: Text(
                                                        item.data.name,
                                                        textScaleFactor: 1.0,
                                                    ),
                                                )
                                            ),
                                        ],
                                    )
                                ),
                            ),
                        ),
                    );
                }),
        );
    }
}