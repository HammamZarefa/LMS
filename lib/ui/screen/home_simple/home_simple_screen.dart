import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/screen/search_detail/search_detail_screen.dart';
import 'package:masterstudy_app/ui/bloc/home_simple/bloc.dart';

import 'package:masterstudy_app/ui/widgets/course_grid_item.dart';

import '../../../theme/theme.dart';
import '../../widgets/course_grid_item.dart';

@provide
class HomeSimpleScreen extends StatefulWidget {
  const HomeSimpleScreen() : super();

  @override
  State<StatefulWidget> createState() {
    return _HomeSimpleScreenState();
  }
}

class _HomeSimpleScreenState extends State<HomeSimpleScreen> {
  HomeSimpleBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<HomeSimpleBloc>(context)..add(FetchHomeSimpleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("F3F5F9"),
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(26),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(SearchDetailScreen.routeName,
                        arguments: SearchDetailScreenArgs(""));
                  },
                  child: new Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Container(
                        padding: EdgeInsets.all(8.0),
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                    child: new Text(
                                      localizations.getLocalization("search_bar_title"),
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    )),
                                Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
        body: BlocBuilder<HomeSimpleBloc, HomeSimpleState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ));
  }

  _buildBody(context, state) {
    if (state is LoadedHomeSimpleState) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Text(localizations.getLocalization("new_courses_title"),
                    textScaleFactor: 1.0,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline
                        .copyWith(color: dark, fontStyle: FontStyle.normal))),
            _buildCourses(state)
          ],
        ),
      );
    }
    if (state is InitialHomeSimpleState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  _buildCourses(LoadedHomeSimpleState state) {
    double ratio = (MediaQuery.of(context).size.width > 375) ? 0.8 : 0.75;

    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
      child: Container(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: ratio,
            crossAxisCount: 2,
          ),
          itemCount: state.coursesNew.length,
          itemBuilder: (context, index) {
            var item = state.coursesNew[index];
            return CourseGridItem(item);
          },
        ),
      ),
    );
  }
}