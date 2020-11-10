import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/ui/bloc/home/bloc.dart';
import 'package:masterstudy_app/ui/widgets/loading_error_widget.dart';

import 'items/categories_item.dart';
import 'items/new_courses_item.dart';
import 'items/top_instructors.dart';
import 'items/trending_item.dart';

@provide
class HomeScreen extends StatefulWidget {
  const HomeScreen() : super();

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<HomeBloc>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            brightness: Brightness.dark,
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
    ));
  }

  _buildBody(context, state) {
    if (state is LoadedHomeState) {
      return ListView.builder(
          itemCount: state.layout.length,
          itemBuilder: (context, index) {
            var item = state.layout[index];
            switch (item.id) {
              case 3:
                return TrendingWidget(true,item.name,state.coursesTranding);
              case 4:
                return TopInstructorsWidget(item.name, state.instructors);
              case 1:
                return CategoriesWidget(item.name, state.categoryList);
              case 2:
                return NewCoursesWidget(item.name, state.coursesNew);
              case 5:
                return TrendingWidget(false,item.name, state.coursesFree);
              default:
                return NewCoursesWidget(item.name, state.coursesNew);
            }
          });
    }
    if (state is InitialHomeState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(state is ErrorHomeState){
      return LoadingErrorWidget((){
        _bloc.add(FetchEvent());
      });
    }
  }
}
