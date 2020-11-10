import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/theme/theme.dart';

class FaqWidget extends StatelessWidget {
  final CourseDetailResponse response;

  const FaqWidget(this.response) : super();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: response.faq.length,
        itemBuilder: (context, index) {
          var item = response.faq[index];
          return ExpansionTile(
            title: Text(
                item.question,
                textScaleFactor: 1.0,
                style: TextStyle(color: HexColor.fromHex("#273044"),fontSize: 18),
            ),
            children: <Widget>[Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
              child: Text(
                  item.answer,
                  textScaleFactor: 1.0,
              ),
            )],
          );
        });
  }
}
