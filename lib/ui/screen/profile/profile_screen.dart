import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/profile/bloc.dart';
import 'package:masterstudy_app/ui/screen/detail_profile/detail_profile_screen.dart';
import 'package:masterstudy_app/ui/screen/orders/orders.dart';
import 'package:masterstudy_app/ui/screen/profile_edit/profile_edit_screen.dart';
import 'package:masterstudy_app/ui/screen/splash/splash_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  final Function myCoursesCallback;

  const ProfileScreen(this.myCoursesCallback) : super();

  @override
  Widget build(BuildContext context) {
    return ProfileScreenWidget(myCoursesCallback);
  }
}

class ProfileScreenWidget extends StatefulWidget {
  final Function myCoursesCallback;

  const ProfileScreenWidget(this.myCoursesCallback) : super();

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenWidgetState();
  }
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  ProfileBloc _bloc;

  String version =  "";

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ProfileBloc>(context)..add(FetchProfileEvent());
    PackageInfo.fromPlatform().then((value){
      setState(() {
        version = value.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is LogoutProfileState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              SplashScreen.routeName, (Route<dynamic> route) => false);
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: AppBar(
                  brightness: Brightness.dark,
                ),
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                    child: Column(
                  children: <Widget>[
                    _buildHead(state),
                    new SizedBox(
                      height: 1.5,
                      child: new Center(
                        child: new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 2.0, end: 2.0),
                          height: 5.0,
                          color: HexColor.fromHex("#E5E5E5"),
                        ),
                      ),
                    ),
                    _buildTile(
                      localizations.getLocalization("view_my_profile"),
                      "assets/icons/profile_icon.svg",
                      () {
                        if (state is LoadedProfileState)
                          Navigator.pushNamed(
                            context,
                            DetailProfileScreen.routeName,
                            arguments: DetailProfileScreenArgs(state.account),
                          );
                      },
                    ),
//                      _buildTile(
//                        localizations.getLocalization("add_announcement"),
//                        "assets/icons/announcement_icon.svg",
//                            () {},
//                      ),
//                      _buildTile(
//                        "Plans",
//                        "assets/icons/assignnments_icon.svg",
//                            () {
//                          Navigator.of(context).pushNamed(
//                            PlansScreen.routeName,
//                          );
//                        },
//                      ),
                    _buildTile(
                      localizations.getLocalization("my_orders"),
                      "assets/icons/orders_icon.svg",
                      () {
                        //if (state is LoadedProfileState)
                        Navigator.of(context).pushNamed(
                          OrdersScreen.routeName,
                        );
                      },
                    ),
                    _buildTile(
                      localizations.getLocalization("my_courses"),
                      "assets/icons/ms_nav_courses.svg",
                      () {
                        this.widget.myCoursesCallback();
                      },
                    ),
                    _buildTile(
                      localizations.getLocalization("settings"),
                      "assets/icons/settings_icon.svg",
                      () async {
                        if (state is LoadedProfileState) {
                          var result = await Navigator.pushNamed(
                            context,
                            ProfileEditScreen.routeName,
                            arguments: ProfileEditScreenArgs(state.account),
                          );
                          if (result) {
                            _bloc.add(UpdateProfileEvent());
                          }
                        }
                      },
                    ),
                    _buildTile(localizations.getLocalization("logout"),
                        "assets/icons/logout_icon.svg", () {
                      showLogoutDialog(context);
                    }, textColor: lipstick, iconColor: lipstick),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "",
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                )),
              ));
        },
      ),
    );
  }

  _buildHead(ProfileState state) {
    if (state is LoadedProfileState) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailProfileScreen.routeName,
            arguments: DetailProfileScreenArgs(state.account),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Image.network(
                  state.account.avatar_url,
                  fit: BoxFit.cover,
                  height: 50.0,
                  width: 50.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      localizations.getLocalization("greeting_user"),
                      textScaleFactor: 1.0,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle
                          .copyWith(color: HexColor.fromHex("#AAAAAA")),
                    ),
                    Container(
                      width: double.infinity,
                      height: 28,
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 110),
                      child: Text(
                        (state.account.meta.first_name != '' &&
                                state.account.meta.last_name != '')
                            ? "${state.account.meta.first_name} ${state.account.meta.last_name}"
                            : state.account.login,
                        textScaleFactor: 1.0,
                        maxLines: 1,
                        softWrap: false,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(color: dark),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 90,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(60.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.amber),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 15,
                      decoration: BoxDecoration(color: Colors.green),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(color: Colors.green),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTile(String title, String assetPath, VoidCallback onClick,
      {Color textColor, Color iconColor}) {
    final String assetName = assetPath;
    final Widget svg = SvgPicture.asset(
      assetName,
      color: (iconColor == null) ? mainColor : iconColor,
    );
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding:
              const EdgeInsets.only(left: 36.0, top: 15.0, bottom: 15.0),
          leading: SizedBox(
            child: svg,
            width: 23,
            height: 23,
          ),
          title: Text(
            title,
            textScaleFactor: 1.0,
            style: TextStyle(
              color: (textColor == null) ? dark : textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: onClick,
        ),
        SizedBox(
          height: 1.0,
          child: new Center(
            child: new Container(
              margin: new EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
              height: 5.0,
              color: HexColor.fromHex("#E5E5E5"),
            ),
          ),
        ),
      ],
    );
  }

  showLogoutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        localizations.getLocalization("cancel_button"),
        textScaleFactor: 1.0,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        localizations.getLocalization("logout"),
        textScaleFactor: 1.0,
      ),
      onPressed: () {
        _bloc.add(LogoutProfileEvent());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(localizations.getLocalization("logout"),
          textScaleFactor: 1.0,
          style: TextStyle(color: Colors.black, fontSize: 20.0)),
      content: Text(
        localizations.getLocalization("logout_message"),
        textScaleFactor: 1.0,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
