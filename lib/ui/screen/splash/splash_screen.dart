import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/splash/bloc.dart';
import 'package:masterstudy_app/ui/screen/auth/auth_screen.dart';
import 'package:masterstudy_app/ui/screen/main/main_screen.dart';
import 'package:masterstudy_app/ui/widgets/loading_error_widget.dart';

@provide
class SplashScreen extends StatelessWidget {
  static const String routeName = "splashScreen";
  SplashBloc bloc;

  SplashScreen(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => bloc,
        child: SplashWidget(),
      ),
    );
  }
}

class SplashWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashWidgetState();
  }
}

class SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(CheckAuthSplashEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (BuildContext context, SplashState state) {
        return Center(child: _buildLogoBlock(state));
      },
    );
  }

  _buildLogoBlock(state) {
    if (state is InitialSplashState)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (state is CloseSplash) {
      if (state.isSigned) {
        openMainPage(state.appSettings.options);
      } else {
        openAuthPage(state.appSettings.options);
      }
      String imgUrl = "";
      String postsCount = "";
      if (state.appSettings != null) {
        imgUrl = (state.appSettings.options.logo == null)
            ? ""
            : state.appSettings.options.logo;
        if (state.appSettings.addons != null)
          dripContentEnabled =
              state.appSettings.addons.sequential_drip_content != null &&
                  state.appSettings.addons.sequential_drip_content == "on";
        postsCount = state.appSettings.options.posts_count.toString();
      }

      appLogoUrl = imgUrl;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imgUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => SizedBox(
                width: 83.0,
                child: Image(image: AssetImage('assets/icons/logo.png'))),
            width: 83.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: Text(
              postsCount,
              textScaleFactor: 1.0,
              style: TextStyle(color: mainColor, fontSize: 40.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Text(
              (postsCount != "") ? "COURSES" : "",
              textScaleFactor: 1.0,
              style: TextStyle(
                  color: HexColor.fromHex("#000000"),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    }
    if (state is ErrorSplashState) {
      return LoadingErrorWidget(() {
        BlocProvider.of<SplashBloc>(context).add(CheckAuthSplashEvent());
      });
    }
  }

  void openAuthPage(OptionsBean optionsBean) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.of(context).pushReplacementNamed(AuthScreen.routeName,
            arguments: AuthScreenArgs(optionsBean));
      });
    });
  }

  void openMainPage(OptionsBean optionsBean) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName,
            arguments: MainScreenArgs(optionsBean));
      });
    });
  }
}
