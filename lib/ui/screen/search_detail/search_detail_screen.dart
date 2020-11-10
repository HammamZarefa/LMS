import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/search_detail/bloc.dart';
import 'package:masterstudy_app/ui/widgets/course_grid_item.dart';

class SearchDetailScreenArgs {
  final String searchText;

  SearchDetailScreenArgs(this.searchText);
}

class SearchDetailScreen extends StatelessWidget {
  static const routeName = "searchDetailScreen";
  final SearchDetailBloc _bloc;

  const SearchDetailScreen(this._bloc) : super();

  @override
  Widget build(BuildContext context) {
    SearchDetailScreenArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<SearchDetailBloc>(
      child: SearchDetailWidget(args.searchText),
      create: (_) => _bloc,
    );
  }
}

class SearchDetailWidget extends StatefulWidget {
  final String searchText;

  const SearchDetailWidget(this.searchText) : super();

  @override
  State<StatefulWidget> createState() {
    return _SearchDetailWidgetState();
  }
}

class _SearchDetailWidgetState extends State<SearchDetailWidget> {
  SearchDetailBloc _bloc;
  final TextEditingController _searchQuery = TextEditingController();

  @override
  void initState() {
    super.initState();

    if(widget.searchText != "") {
      this._searchQuery.text = widget.searchText;
    }

    _bloc = BlocProvider.of<SearchDetailBloc>(context)..add(FetchEvent(this._searchQuery.text));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F3F5F9"),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          style: TextStyle(fontSize: 20),
          controller: _searchQuery,
          onChanged: (value) {
            if (value.trim().length > 1) _bloc.add(FetchEvent(value));
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: localizations.getLocalization("search_bar_title"),
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ),
      body: BlocBuilder<SearchDetailBloc, SearchDetailState>(
        bloc: _bloc,
        // ignore: missing_return
        builder: (context, state) {
          if (state is LoadingSearchDetailState) return _buildLoadingWidget();

          if (state is LoadedSearchDetailState) {
            if (state.courses.isEmpty) {
              return _buildEmptyResults();
            } else {
              return _buildCourses(state.courses);
            }
          }
          return Center();
        },
      ),
    );
  }

  _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildCourses(List<CoursesBean> courses) {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
      child: Container(
        child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 4,
          staggeredTileBuilder: (_) => StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            var item = courses[index];

            return CourseGridItem(item);
          },
        ),
      ),
    );
  }

  _buildEmptyResults() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            size: 150,
            color: Colors.grey[400],
          ),
          Text(
            localizations.getLocalization("nothing_found_search"),
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.grey[500], fontSize: 22),
          ),
          Text(
            "${_searchQuery.text}",
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.grey[500], fontSize: 18),
          ),
        ],
      ),
    );
  }
}
