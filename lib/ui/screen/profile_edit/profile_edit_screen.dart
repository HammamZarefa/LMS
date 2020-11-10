import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/edit_profile_bloc/bloc.dart';

class ProfileEditScreenArgs {
  final Account account;

  ProfileEditScreenArgs(this.account);
}

class ProfileEditScreen extends StatelessWidget {
  static const routeName = "profileEditScreen";
  ProfileEditScreenArgs args;
  final EditProfileBloc bloc;

  ProfileEditScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute
        .of(context)
        .settings
        .arguments;
    return BlocProvider(
      create: (context) => bloc..account = args.account,
      child: _ProfileEditWidget(),
    );
  }
}

class _ProfileEditWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileEditWidgetState();
  }
}

class _ProfileEditWidgetState extends State<_ProfileEditWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _facebookController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();

  var enableInputs = true;

  var passwordVisible = false;

  EditProfileBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<EditProfileBloc>(context);
    passwordVisible = true;
    _firstNameController.text = _bloc.account.meta.first_name;
    _lastNameController.text = _bloc.account.meta.last_name;
    _emailController.text = _bloc.account.email;
    _bioController.text = _bloc.account.meta.description;
    _occupationController.text = _bloc.account.meta.position;
    _facebookController.text = _bloc.account.meta.facebook;
    _twitterController.text = _bloc.account.meta.twitter;
    _instagramController.text = _bloc.account.meta.instagram;
    super.initState();
  }

  _saveForm() {
    if (_formKey.currentState.validate()) {
      _bloc.add(SaveEvent(
          _firstNameController.text,
          _lastNameController.text,
          _passwordController.text,
          _bioController.text,
          _occupationController.text,
          _facebookController.text,
          _twitterController.text,
          _instagramController.text,
          _image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          localizations.getLocalization("edit_profile_title"),
          textScaleFactor: 1.0,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if(state is CloseEditProfileState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(localizations.getLocalization("profile_updated_message"),
                textScaleFactor: 1.0,),
              duration: Duration(seconds: 2),
            ))
            .closed
            .then((reason) {
              Navigator.of(context).pop(true);
            });
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      )
    );
  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  _buildBody(state) {
    enableInputs = !(state is LoadingEditProfileState);

    final Widget svg = SvgPicture.asset(
      "assets/icons/file_icon.svg",
      color: Colors.white,
    );
    Widget image;

    if (_image != null) {
      image = Image.file(
        _image,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      );
    } else {
      image = SizedBox(
        width: 100,
        height: 100,
        child: SvgPicture.asset(
          "assets/icons/empty_user.svg",
        ),
      );
    }

    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8),
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.0),
                  child: image,
                ),
              ),
            ),
          ),
          Center(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(32.0),
                  side: BorderSide(color: secondColor)),
              color: secondColor,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              onPressed: getImage,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        child: svg,
                        width: 23,
                        height: 23,
                      ),
                      Text(
                        localizations.getLocalization("change_photo_button"),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _firstNameController,
              enabled: enableInputs,
              decoration: InputDecoration(labelText: localizations.getLocalization("first_name"), filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _lastNameController,
              enabled: enableInputs,
              decoration: InputDecoration(labelText: localizations.getLocalization("last_name"), filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _occupationController,
              enabled: enableInputs,
              decoration:
              InputDecoration(labelText: localizations.getLocalization("occupation"), filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _emailController,
              enabled: enableInputs,
              validator: _validateEmail,
              decoration: InputDecoration(
                  labelText: localizations.getLocalization("email_label_text"),
                  helperText: localizations.getLocalization("email_helper_text"),
                  filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
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
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    color: Theme
                        .of(context)
                        .primaryColorDark,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return null;
                } else {
                  if (value.length < 8) {
                    return localizations.getLocalization("password_register_characters_count_error_text");
                  }
                }

                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _bioController,
              enabled: enableInputs,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: localizations.getLocalization("bio"), helperText: localizations.getLocalization("bio_helper"), filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _facebookController,
              enabled: enableInputs,
              decoration: InputDecoration(
                  labelText: 'Facebook',
                  hintText: localizations.getLocalization("enter_url"),
                  filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _twitterController,
              enabled: enableInputs,
              decoration: InputDecoration(
                  labelText: 'Twitter', hintText: localizations.getLocalization("enter_url"), filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _instagramController,
              enabled: enableInputs,
              decoration: InputDecoration(
                  labelText: 'Instagram', hintText: localizations.getLocalization("enter_url"), filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: new MaterialButton(
              minWidth: double.infinity,
              color: mainColor,
              onPressed: () {
                _saveForm();
              },
              child: setUpButtonChild(enableInputs),
              textColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
            ),
            child: FlatButton(
              child: Text(
                localizations.getLocalization("cancel_button"),
                textScaleFactor: 1.0,
                style: TextStyle(color: mainColor),
              ),
              onPressed: () {
                _bloc.add(CloseScreenEvent());
              },
            ),
          )
        ],
      ),
    );
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

Widget setUpButtonChild(enable) {
  if (enable == true) {
    return new Text(
      localizations.getLocalization("save_button"),
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
