import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/ui/screen/courses/courses_screen.dart';
import 'package:masterstudy_app/ui/screen/favorites/favorites_screen.dart';
import 'package:masterstudy_app/ui/screen/home/home_screen.dart';
import 'package:masterstudy_app/ui/screen/home_simple/home_simple_screen.dart';
import 'package:masterstudy_app/ui/screen/profile/profile_screen.dart';
import 'package:masterstudy_app/ui/screen/search/search_screen.dart';

class MainScreenArgs {
  final OptionsBean optionsBean;

  MainScreenArgs(this.optionsBean);
}

class MainScreen extends StatelessWidget {
  static const routeName = "mainScreen";

  const MainScreen() : super();

  @override
  Widget build(BuildContext context) {
    final MainScreenArgs args = ModalRoute.of(context).settings.arguments;

    return MainScreenWidget(args.optionsBean);
  }
}

class MainScreenWidget extends StatefulWidget {
  final OptionsBean optionsBean;

  const MainScreenWidget(this.optionsBean) : super();

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreenWidget> {
  String token;
  var _selectedIndex = 0;
  final _selectedItemColor = mainColor;
  final _unselectedItemColor = Colors.white;
  final _selectedBgColor = Colors.white;
  final _unselectedBgColor = mainColor;

  Color _getBgColor(int index) =>
      _selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

  Color _getItemColor(int index) =>
      _selectedIndex == index ? _selectedItemColor : _unselectedItemColor;

  Widget _buildIcon(String iconData, String text, int index) => Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Icon(iconData),
                Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 4.0),
                  child: SvgPicture.asset(iconData,
                      height: 22.0, color: _getItemColor(index)),
                ),
                Text(text,
                    textScaleFactor: 1.0,
                    style:
                        TextStyle(fontSize: 12, color: _getItemColor(index))),
              ],
            ),
            onTap: () => _onItemTapped(index),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
          child: _getBody(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_home.svg",
                  localizations.getLocalization("home_bottom_nav"), 0),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_courses.svg",
                  localizations.getLocalization("courses_bottom_nav"), 1),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_search.svg",
                  localizations.getLocalization("search_bottom_nav"), 2),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_fav.svg",
                  localizations.getLocalization("favorites_bottom_nav"), 3),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _buildIcon("assets/icons/ms_nav_profile.svg",
                  localizations.getLocalization("profile_bottom_nav"), 4),
              title: SizedBox.shrink()),
        ],
        selectedFontSize: 0,
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return (widget.optionsBean?.app_view ?? true)
            ? HomeSimpleScreen()
            : HomeScreen();
      case 1:
        return CoursesScreen(() {
          setState(() {
            _selectedIndex = 0;
          });
        });
      case 2:
        return SearchScreen();
      case 3:
        return FavoritesScreen();
      case 4:
        return ProfileScreen((){
          setState(() {
            _selectedIndex = 1;
          });
        });
      default:
        return Center(
          child: Text(
            "Not implemented!",
            textScaleFactor: 1.0,
          ),
        );
    }
  }
}
