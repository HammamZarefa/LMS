import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/profile_assignment/profile_assignment_bloc.dart';

class ProfileAssignmentScreen extends StatelessWidget {
    static const routeName = 'profileAssignmentScreen';
    final ProfileAssignmentBloc _bloc;

    const ProfileAssignmentScreen(this._bloc) : super();

    @override
    Widget build(BuildContext context) {
        return BlocProvider<ProfileAssignmentBloc>(
            create: (c) => _bloc, child: _ProfileAssignmentScreenWidget()
        );
    }
}

class _ProfileAssignmentScreenWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _ProfileAssignmentScreenWidgetState();
    }
}

class _ProfileAssignmentScreenWidgetState extends State<_ProfileAssignmentScreenWidget> {
    ProfileAssignmentBloc _bloc;

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: HexColor.fromHex('#F3F5F9'),
            appBar: AppBar(
                title: Text(
                    localizations.getLocalization("profile_assignment_title"),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                    ),
                )
            ),
            body: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: SvgPicture.asset(
                                    "assets/icons/monitor.svg",
                                    color: HexColor.fromHex("#DDDFE3")
                                ))
                        ),
                        Text(
                        localizations.getLocalization("assignment_content"),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: HexColor.fromHex('#2A3045'),
                                fontSize: 20.0
                            ),
                            textAlign: TextAlign.center,
                        )
                    ],
                ),
            ),
        );
    }
}