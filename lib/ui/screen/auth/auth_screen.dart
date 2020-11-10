import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_bloc.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_event.dart';
import 'package:masterstudy_app/ui/bloc/auth/auth_state.dart';
import 'package:masterstudy_app/ui/screen/main/main_screen.dart';
import 'package:masterstudy_app/ui/screen/splash/splash_screen.dart';

class AuthScreenArgs {
  final OptionsBean optionsBean;

  AuthScreenArgs(this.optionsBean);
}

@provide
class AuthScreen extends StatelessWidget {
  final AuthBloc _bloc;
  static const routeName = "authScreen";

  AuthScreen(this._bloc);

  @override
  Widget build(BuildContext context) {
    final AuthScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(child: AuthScreenWidget(args.optionsBean), create: (context) => _bloc);
  }
}

class AuthScreenWidget extends StatefulWidget {
  final OptionsBean optionsBean;

  const AuthScreenWidget(this.optionsBean) : super();

  @override
  State<StatefulWidget> createState() {
    return AuthScreenWidgetState();
  }
}

class AuthScreenWidgetState extends State<AuthScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0), // here th
          child: new AppBar(
            brightness: Brightness.light,
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(top:0.0),
                child: CachedNetworkImage(
                  imageUrl: appLogoUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => SizedBox(
                      width: 50.0,
                      child: Image(
                          image: AssetImage('assets/icons/logo.png')
                      )
                  ),
                  width: 50.0,
                ),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: mainColorA,
              tabs: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Tab(
                    icon: Text(
                      localizations.getLocalization("auth_sign_up_tab"),
                      textScaleFactor: 1.0,
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                ),
                Tab(
                    icon: Text(
                      localizations.getLocalization("auth_sign_in_tab"),
                      textScaleFactor: 1.0,
                  style: TextStyle(color: mainColor),
                )),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <Widget>[_SignUpPage(widget.optionsBean)],
            ),
            ListView(children: <Widget>[_SignInPage(widget.optionsBean)]),
          ],
        ),
      ),
    );
  }
}

class _SignUpPage extends StatefulWidget {

  final OptionsBean optionsBean;

  const _SignUpPage(this.optionsBean) : super();

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<_SignUpPage> {
  AuthBloc _bloc;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _loginController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var passwordVisible = false;

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthBloc>(context);
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        var enableInputs = !(state is LoadingAuthState);

        if (state is SuccessAuthState) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Navigator.pushReplacementNamed(context, MainScreen.routeName,
                  arguments: MainScreenArgs(widget.optionsBean)));
        }
        if (state is ErrorAuthState) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => showDialogError(context, state.message));
        }

        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 30.0),
                child: TextFormField(
                  controller: _loginController,
                  enabled: enableInputs,
                  decoration: InputDecoration(
                      labelText: localizations.getLocalization("login_label_text"),
                      helperText: localizations.getLocalization("login_registration_helper_text"),
                      filled: true),
                  validator: (value) {
                    if (value.isEmpty) {
                      return localizations.getLocalization("login_empty_error_text");
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: _emailController,
                  enabled: enableInputs,
                  decoration: InputDecoration(
                      labelText: localizations.getLocalization("email_label_text"),
                      helperText: localizations.getLocalization("email_helper_text"),
                      filled: true),
                  validator: _validateEmail,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: _passwordController,
                  enabled: enableInputs,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      labelText: localizations.getLocalization("password_label_text"),
                      helperText: localizations.getLocalization("password_registration_helper_text"),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        color: mainColor,
                      )),
                  validator: (value) {
                    if (value.isEmpty) {
                      return localizations.getLocalization("password_empty_error_text");
                    }
                    if (value.length < 8) {
                      return localizations.getLocalization("password_characters_count_error_text");
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: new MaterialButton(
                  minWidth: double.infinity,
                  color: mainColor,
                  onPressed: register,
                  child: setUpButtonChild(enableInputs),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showDialogError(context, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                localizations.getLocalization("error_dialog_title"),
                textScaleFactor: 1.0,
                style: TextStyle(color: Colors.black, fontSize: 20.0)
            ),
            content: Text(
              text,
              textScaleFactor: 1.0,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                    localizations.getLocalization("ok_dialog_button"),
                  textScaleFactor: 1.0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _bloc.add(CloseDialogEvent());
                },
              ),
            ],
          );
        });
  }

  Widget setUpButtonChild(enable) {
    if (enable == true) {
      return new Text(
        localizations.getLocalization("registration_button"),
        textScaleFactor: 1.0,
      );
    } else {
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
  }

  void register() {
    if (_formKey.currentState.validate()) {
      _bloc.add(RegisterEvent(_loginController.text, _emailController.text,
          _passwordController.text));
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return localizations.getLocalization("email_empty_error_text");
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return localizations.getLocalization("email_invalid_error_text");
  }
}

class _SignInPage extends StatefulWidget {
  final OptionsBean optionsBean;

  const _SignInPage(this.optionsBean) : super();

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<_SignInPage> {
  AuthBloc _bloc;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var passwordVisible = false;

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthBloc>(context);
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        var enableInputs = !(state is LoadingAuthState);
        if (state is SuccessAuthState) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Navigator.pushReplacementNamed(context, MainScreen.routeName,
                  arguments: MainScreenArgs(widget.optionsBean)));
        }
        if (state is ErrorAuthState) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => showDialogError(context, state.message));
        }
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 30.0),
                child: TextFormField(
                  controller: _loginController,
                  enabled: enableInputs,
                  decoration: InputDecoration(
                      labelText: localizations.getLocalization("login_label_text"),
                      helperText: localizations.getLocalization("login_sign_in_helper_text"),
                      filled: true),
                  validator: (value) {
                    if (value.isEmpty) {
                      return localizations.getLocalization("login_sign_in_helper_text");
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextFormField(
                  controller: _passwordController,
                  enabled: enableInputs,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      labelText: localizations.getLocalization("password_label_text"),
                      helperText: localizations.getLocalization("password_sign_in_helper_text"),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        color: mainColor,
                      )),
                  validator: (value) {
                    if (value.isEmpty) {
                      return localizations.getLocalization("password_sign_in_helper_text");
                    }
                    if (value.length < 4) {
                      return localizations.getLocalization("password_sign_in_characters_count_error_text");
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: new MaterialButton(
                  minWidth: double.infinity,
                  color: mainColor,
                  onPressed: auth,
                  child: setUpButtonChild(enableInputs),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showDialogError(context, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                localizations.getLocalization("error_dialog_title"),
                textScaleFactor: 1.0,
                style: TextStyle(color: Colors.black, fontSize: 20.0)
            ),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text(
                    localizations.getLocalization("ok_dialog_button"),
                  textScaleFactor: 1.0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _bloc.add(CloseDialogEvent());
                },
              ),
            ],
          );
        });
  }

  Widget setUpButtonChild(enable) {
    if (enable == true) {
      return new Text(
        localizations.getLocalization("sign_in_button"),
        textScaleFactor: 1.0,
      );
    } else {
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
  }

  void auth() {
    if (_formKey.currentState.validate()) {
      _bloc.add(LoginEvent(_loginController.text, _passwordController.text));
    }
  }
}
