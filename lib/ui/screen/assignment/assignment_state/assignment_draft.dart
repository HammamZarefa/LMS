import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/AssignmentResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/assignment/assignment_bloc.dart';
import 'package:masterstudy_app/ui/bloc/assignment/assignment_event.dart';
import 'package:masterstudy_app/ui/screen/assignment/assignment_parts/assignment_info.dart';
import 'package:meta/meta.dart';

class AssignmentDraftWidget extends StatefulWidget {
    final AssignmentBloc _bloc;
    final AssignmentResponse assignmentResponse;

    final int courseId;
    final int assignmentId;
    final int userAssignmentId;

    const AssignmentDraftWidget(Key key, this._bloc, this.assignmentResponse, this.courseId, this.assignmentId, this.userAssignmentId) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return AssignmentDraftWidgetState();
    }
}

class AssignmentDraftWidgetState extends State<AssignmentDraftWidget> {
    TextEditingController _title = TextEditingController();
    TextEditingController _text = TextEditingController();
    List<File> files = List<File>();

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 7.0, bottom: 10.0, left: 7.0),
                    child: Text(
                        "Assignment " + widget.assignmentResponse.section.index.toString(),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: HexColor.fromHex("#273044")
                        ),
                    )
                ),
                BlocListener(
                    bloc: widget._bloc,
                    listener: (context, state) {

                    },
                    child: BlocBuilder(
                        bloc: widget._bloc,
                        builder: (context, state) {
                            return SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.0, bottom: 10.0),
                                                child: Text(
                                                    widget.assignmentResponse.title,
                                                    textScaleFactor: 1.0,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w600
                                                    )
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0),
                                                child: TextFormField(
                                                    controller: _title,
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(color: HexColor.fromHex("#DDDDDD")),
                                                        ),
                                                        labelText: widget.assignmentResponse.translations.title,
                                                        alignLabelWithHint: true,
                                                        filled: true,
                                                        fillColor: HexColor.fromHex("#F6F6F6"),
                                                    ),
                                                )
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.0),
                                                child: TextFormField(
                                                    controller: _text,
                                                    maxLines: 8,
                                                    textAlignVertical: TextAlignVertical
                                                        .top,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(color: HexColor.fromHex("#FFFFFF")),
                                                        ),
                                                        labelText: widget.assignmentResponse.translations.content,
                                                        alignLabelWithHint: true,
                                                        filled: true,
                                                        fillColor: HexColor.fromHex("#F6F6F6"),
                                                    ),
                                                )
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0),
                                                child: SizedBox(
                                                    width: 140,
                                                    height: 40,
                                                    child: FlatButton(
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius: new BorderRadius.circular(20.0),
                                                            side: BorderSide(color: secondColor)),
                                                        onPressed: () {
                                                            uploadFile();
                                                        },
                                                        padding: EdgeInsets.all(0.0),
                                                        color: secondColor,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                                Padding(
                                                                    padding: EdgeInsets.only(left: 0, right: 4.0),
                                                                    child: SizedBox(
                                                                        width: 20,
                                                                        height: 20,
                                                                        child: SvgPicture.asset(
                                                                            "assets/icons/file_icon.svg",
                                                                            color: HexColor.fromHex("#FFFFFF")
                                                                        ))
                                                                ),
                                                                Text(
                                                                    widget.assignmentResponse.translations.files,
                                                                    textScaleFactor: 1.0,
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 14.0
                                                                    ),
                                                                )
                                                            ],
                                                        ),
                                                    ),
                                                )
                                            ),
                                            (files != null) ? _buildFileList() : Center()
                                        ],
                                    )
                                ),
                            );
                        }),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 7.0, bottom: 10.0, left: 7.0),
                    child: Center(),
                ),
            ],
        );
    }

    _buildFileList() {
        return Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                            var item = files[index];
                            String fileName = item.path.split('/').last;

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
                                                                    fileName,
                                                                    textScaleFactor: 1.0,
                                                                ),
                                                            )
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                                setState(() {
                                                                    this.files.removeAt(index);
                                                                });
                                                            },
                                                            child: Icon(
                                                                Icons.close,
                                                                size: 22.0,
                                                                color: HexColor.fromHex("#AAAAAA"),
                                                            )
                                                        ),
                                                    ],
                                                )



                                            ),
                                        ),
                                    ),
                            );
                        }),
                ],
            )
        );
    }

    void uploadFile() async {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
        }

        try {
            File file = await FilePicker.getFile();
            setState(() {
                if(file != null) {
                    files.add(file);
                }
            });
        } catch (error) {
            print('File picker error');
            print(error);
        }
    }

    void addAssignment(bool add) {

        String content = this._title.text + " " + this._text.text;

        widget._bloc.add(AddAssignmentEvent(widget.courseId, widget.assignmentId, widget.userAssignmentId, content, files));
    }
}