import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/data/models/category.dart';
import 'package:masterstudy_app/ui/bloc/category_detail/bloc.dart';
import 'package:masterstudy_app/ui/screen/search_detail/search_detail_screen.dart';
import 'package:masterstudy_app/ui/widgets/course_grid_item.dart';
import 'package:masterstudy_app/ui/widgets/loading_error_widget.dart';

import '../../../main.dart';

class CategoryDetailScreenArgs {
    final Category category;

    CategoryDetailScreenArgs(this.category);
}

class CategoryDetailScreen extends StatelessWidget {
    static const routeName = "categoryDetailScreen";
    final CategoryDetailBloc _bloc;

    const CategoryDetailScreen(this._bloc) : super();

    @override
    Widget build(BuildContext context) {
        final CategoryDetailScreenArgs args =
            ModalRoute
                .of(context)
                .settings
                .arguments;
        return BlocProvider<CategoryDetailBloc>(
            create: (c) => _bloc,
            child: _CategoryDetailScreenWidget(args.category));
    }
}

class _CategoryDetailScreenWidget extends StatefulWidget {
    final Category category;

    const _CategoryDetailScreenWidget(this.category);

    @override
    State<StatefulWidget> createState() {
        return _CategoryDetailScreenWidgetState();
    }
}

class _CategoryDetailScreenWidgetState extends State<_CategoryDetailScreenWidget> {
    CategoryDetailBloc _bloc;
    var unescape = new HtmlUnescape();
    Category selCat;

    @override
    void initState() {
        super.initState();

        _bloc = BlocProvider.of<CategoryDetailBloc>(context)
            ..add(FetchEvent(widget.category.id));

        selCat = widget.category;
    }

    @override
    Widget build(BuildContext context) {
        return BlocBuilder <CategoryDetailBloc, CategoryDetailState>(
            bloc: _bloc,
            builder: (context, state) {
                return Scaffold(
                    backgroundColor: HexColor.fromHex("#F3F5F9"),
                    appBar: AppBar(
                        title: _buildTitleDropDown(state),
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(
                                kToolbarHeight + 16),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 8.0, left: 8, right: 2),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16.0, left: 2, right: 2),
                                        child: InkWell(
                                            onTap: () {
                                                Navigator.of(context)
                                                    .pushNamed(
                                                    SearchDetailScreen.routeName,
                                                    arguments: SearchDetailScreenArgs(""));
                                            },
                                            child: new Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(2.0),
                                                ),
                                                elevation: 4,
                                                color: Colors.white,
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(4.0),
                                                    child: new Container(
                                                        padding: EdgeInsets.all(
                                                            8.0),
                                                        child: new Column(
                                                            children: <Widget>[
                                                                new Row(
                                                                    children: <Widget>[
                                                                        new Expanded(
                                                                            child: new Text(
                                                                                localizations.getLocalization("search_bar_title"),
                                                                                textScaleFactor: 1.0,
                                                                                style: TextStyle(
                                                                                    color: Colors
                                                                                        .black
                                                                                        .withOpacity(
                                                                                        0.5)))),
                                                                        Icon(
                                                                            Icons
                                                                                .search,
                                                                            color: Colors
                                                                                .grey,
                                                                        ),
                                                                    ])
                                                            ],
                                                        ))))))
                                ],
                            ))),
                    body: SingleChildScrollView(
                            child: _buildBody(state)
                    )
                );
            });
    }

    _buildTitleDropDown(CategoryDetailState state) {
        if (state is InitialCategoryDetailState) return Center();
        if (state is LoadedCategoryDetailState) {
            return Container(
                child: _buildDropDownCategory(state),
            );
        }
    }

    _buildBody(CategoryDetailState state) {
      if(state is ErrorCategoryDetailState) return Center(
        child: LoadingErrorWidget(
            (){
              _bloc.add(FetchEvent(state.categoryId));
            }
        ),
      );
        if (state is InitialCategoryDetailState) return _buildLoading();
        if (state is LoadedCategoryDetailState) {
            return  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 30.0, bottom: 5.0),
                            child: Text(
                                unescape.convert(selCat.name),
                                textScaleFactor: 1.0,
                                style: Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .headline
                                    .copyWith(
                                    color: dark, fontStyle: FontStyle.normal))),
                        _buildCourses(state)
                    ]);
        }
    }

    _buildCourses(LoadedCategoryDetailState state) {
        return Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 22.0),
            child: Container(
                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                        var item = state.courses[index];
                        return CourseGridItem(item);
                    },
                )));
    }

    _buildDropDownCategory(LoadedCategoryDetailState state) {
        return DropdownButtonHideUnderline(
            child: DropdownButton<Category>(
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 18,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                elevation: 16,
                style: new TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                hint: Text(
                    unescape.convert(selCat.name),
                    textScaleFactor: 1.0,
                    style: new TextStyle(color: Colors.white)),
                    onChanged: (Category selectedCat) {
                        setState(() {
                          selCat = selectedCat;
                        });
                        _bloc.add(FetchEvent(selectedCat.id));
                    },
                items: state.categoryList.map((Category catList) {
                    return new DropdownMenuItem<Category>(
                        value: catList,
                        child:
                        new Text(
                            unescape.convert(catList.name),
                            textScaleFactor: 1.0,
                            style: new TextStyle(color: Colors.black)
                        ),
                    );
                }).toList(),
            ));
    }

    _buildLoading() {
        return Center(
            child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: CircularProgressIndicator(),
            ),
        );
    }
}
