import 'package:flutter/material.dart';
import 'package:masterstudy_app/main.dart';

class MetaIcon extends StatelessWidget {
  final String tag;

  const MetaIcon(this.tag) : super();

  @override
  Widget build(BuildContext context) {
    String assetName;

    switch (tag) {
      case 'current_students':
        assetName = "enrolled_icon.png";
        break;
      case 'duration':
        assetName = "duration_icon.png";
        break;
      case 'curriculum':
        assetName = "lectures_icon.png";
        break;
      case 'video_duration':
        assetName = "video_curriculum_icon.png";
        break;
      case 'level':
        assetName = "level_icon.png";
        break;
    }

    return Image.asset(
      "assets/icons/$assetName",
      width: 24,
      height: 24,
      color: mainColor,
    );
  }
}
