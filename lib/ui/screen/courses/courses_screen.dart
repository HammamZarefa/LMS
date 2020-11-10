import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:masterstudy_app/data/models/user_course.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/courses/bloc.dart';
import 'package:masterstudy_app/ui/screen/category_detail/category_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/user_course/user_course.dart';
import 'package:masterstudy_app/ui/widgets/loading_error_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class CoursesScreen extends StatelessWidget {
  final Function addCoursesCallback;

  const CoursesScreen(this.addCoursesCallback) : super();

  @override
  Widget build(BuildContext context) {
    return _CoursesWidget(addCoursesCallback);
  }
}

class _CoursesWidget extends StatefulWidget {
  final Function addCoursesCallback;

  const _CoursesWidget(this.addCoursesCallback) : super();

  @override
  State<StatefulWidget> createState() {
    return _CoursesWidgetState();
  }
}

class _CoursesWidgetState extends State<_CoursesWidget> {
  UserCoursesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<UserCoursesBloc>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor.fromHex("#F3F5F9"),
        appBar: AppBar(
            backgroundColor: HexColor.fromHex("#273044"),
            centerTitle: true,
            title: Text(
              localizations.getLocalization("user_courses_screen_title"),
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            )),
        body: BlocBuilder<UserCoursesBloc, UserCoursesState>(
          bloc: _bloc,
          // ignore: missing_return
          builder: (context, state) {
            if (state is LoadedCoursesState) return _buildList(state.courses);
            if (state is ErrorUserCoursesState)
              return Center(
                child: LoadingErrorWidget(() {
                  _bloc.add(FetchEvent());
                }),
              );
            if (state is InitialUserCoursesState) return _buildLoading();
            if (state is EmptyCoursesState) return _buildEmptyList();
          },
        ));
  }

  _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 150,
            height: 150,
            child: SvgPicture.asset(
              "assets/icons/empty_courses.svg",
            ),
          ),
          Text(
            localizations.getLocalization("no_user_courses_screen_title"),
            textScaleFactor: 1.0,
            style: TextStyle(color: HexColor.fromHex("#D7DAE2"), fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: new MaterialButton(
                minWidth: double.infinity,
                color: secondColor,
                onPressed: () {
                  this.widget.addCoursesCallback();
                },
                child: Text(
                  localizations.getLocalization("add_courses_button"),
                  textScaleFactor: 1.0,
                ),
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildList(List<PostsBean> courses) {
    return ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return _CourseWidget(courses[index]);
        });
  }
}

class _CourseWidget extends StatelessWidget {
  final PostsBean postsBean;

  const _CourseWidget(this.postsBean) : super();

  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    double imgHeight =
        (MediaQuery.of(context).size.width > 450) ? 370.0 : 160.0;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          borderOnForeground: true,
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      UserCourseScreen.routeName,
                      arguments: UserCourseScreenArgs.fromPostsBean(postsBean),
                    );
                  },
                  child: Hero(
                    tag: postsBean.course_id,
                    child: FadeInImage.memoryNetwork(
                      image: postsBean.app_image,
                      placeholder: kTransparentImage,
                      width: double.infinity,
                      height: imgHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          CategoryDetailScreen.routeName,
                          arguments: CategoryDetailScreenArgs(
                              postsBean.categories_object.first),
                        );
                      },
                      child: Text(
                        "${unescape.convert(postsBean.categories_object.first.name)} >",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 16,
                            color:
                                HexColor.fromHex("#2a3045").withOpacity(0.5)),
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        UserCourseScreen.routeName,
                        arguments:
                            UserCourseScreenArgs.fromPostsBean(postsBean),
                      );
                    },
                    child: Text(
                      postsBean.title,
                      textScaleFactor: 1.0,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 22,
                          color: dark,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: SizedBox(
                      height: 6,
                      child: LinearProgressIndicator(
                        value: int.parse(postsBean.progress) / 100,
                        backgroundColor: HexColor.fromHex("#D7DAE2"),
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(secondColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        postsBean.duration,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color:
                                HexColor.fromHex("#2a3045").withOpacity(0.5)),
                      ),
                      Text(
                        postsBean.progress_label,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color:
                                HexColor.fromHex("#2a3045").withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 16, right: 16, bottom: 16),
                  child: SizedBox(
                    child: new MaterialButton(
                      minWidth: double.infinity,
                      color: secondColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          UserCourseScreen.routeName,
                          arguments:
                              UserCourseScreenArgs.fromPostsBean(postsBean),
                        );
                      },
                      child: Text(
                        localizations.getLocalization("continue_button"),
                        textScaleFactor: 1.0,
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
