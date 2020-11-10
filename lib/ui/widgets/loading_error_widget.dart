import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masterstudy_app/theme/theme.dart';

import '../../main.dart';

class LoadingErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const LoadingErrorWidget(
    this.onRetry, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    return Center(
//        child: MaterialButton(
//      height: 40,
//      color: mainColor,
//      onPressed: onRetry,
//    ));



    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          SizedBox(
//            width: 150,
//            height: 150,
//            child: SvgPicture.asset(
//              "assets/icons/empty_courses.svg",
//            ),
//          ),
          Text(
            localizations.getLocalization("network_error"),
            textScaleFactor: 1.0,
            style: TextStyle(color: HexColor.fromHex("#D7DAE2"), fontSize: 18),
          ),

          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: MaterialButton(
              height: 40,
              color: mainColor,
              onPressed: onRetry,
              child: Text(
                localizations.getLocalization("error_button"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
