import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/course/course_bloc.dart';
import 'package:masterstudy_app/ui/screen/lesson_video/lesson_video_screen.dart';
import 'package:masterstudy_app/ui/screen/porchase_dialog/purchase_dialog.dart';
import 'package:masterstudy_app/ui/screen/text_lesson/text_lesson_screen.dart';
import 'package:masterstudy_app/ui/widgets/dialog_author.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:masterstudy_app/ui/bloc/course/bloc.dart';


class UserCourseLockedScreenArgs {
    final int courseId;

    UserCourseLockedScreenArgs(this.courseId);
}

class UserCourseLockedScreen extends StatelessWidget {
    static const routeName = "userCourseLockedScreen";
    final CourseBloc _bloc;

    UserCourseLockedScreen(this._bloc) : super();

    @override
    Widget build(BuildContext context) {
        final UserCourseLockedScreenArgs args = ModalRoute.of(context).settings.arguments;
        return BlocProvider(
            create: (context) => _bloc, child: UserCourseLockedWidget(args.courseId));
    }
}

class UserCourseLockedWidget extends StatefulWidget {
    final int courseId;

    const UserCourseLockedWidget(this.courseId) : super();

    @override
    State<StatefulWidget> createState() {
        return UserCourseLockedWidgetState();
    }
}

class UserCourseLockedWidgetState extends State<UserCourseLockedWidget> {
    ScrollController _scrollController;
    String courseTitle = "";
    String title = "";
    CourseBloc _bloc;

    bool get _isAppBarExpanded {
        print(kToolbarHeight);
        return _scrollController.hasClients &&
            _scrollController.offset >
                (MediaQuery.of(context).size.height / 3 - (kToolbarHeight));
    }

    @override
    void initState() {
        super.initState();
        _bloc = BlocProvider.of<CourseBloc>(context)
            ..add(FetchEvent(widget.courseId));
        _scrollController = ScrollController()
            ..addListener(() {
                if (!_isAppBarExpanded) {
                    setState(() {
                        title = "";
                    });
                } else {
                    setState(() {
                        title = courseTitle;
                    });
                }
            });
    }

    @override
    Widget build(BuildContext context) {
        return BlocListener(
            listener: (context,state){
                if(state.courseDetailResponse.has_access)
                   Navigator.of(context).pop();
            },
          child: BlocBuilder<CourseBloc, CourseState>(
              bloc: _bloc,
              builder: (context, state) {

                  return Scaffold(
                      body: NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                              return <Widget>[
                                  SliverAppBar(
                                      title: Text(
                                          title,
                                          textScaleFactor: 1.0,
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                      expandedHeight: MediaQuery.of(context).size.height / 3.3,
                                      floating: false,
                                      pinned: true,
                                      snap: false,
                                      flexibleSpace: _buildFlexSpaceBar(state),
                                  )
                              ];
                          },
                          body: _buildBody(state)),
                      bottomNavigationBar: _buildBottom(state),
                  );
              },
          ),
        );
    }

    _buildFlexSpaceBar(CourseState state) {
        if(state is LoadedCourseState) {
            courseTitle = state.courseDetailResponse.title;


            return FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Container(
                    child: Stack(
                        children: <Widget>[
                            Hero(
                                tag: state.courseDetailResponse.id,
                                child: FadeInImage.memoryNetwork(
                                    image: state.courseDetailResponse.images.full,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                    MediaQuery.of(context).size.height / 3.3 +
                                        MediaQuery.of(context).padding.top,
                                    placeholder: kTransparentImage,
                                ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: HexColor.fromHex("#2A3045")
                                        .withOpacity(0.7)),
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height / 3.3,
                                child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                    child: SafeArea(
                                        child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 0.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            children: <Widget>[
                                                                GestureDetector(
                                                                    onTap: () {
                                                                        showDialog(
                                                                            context: context,
                                                                            barrierDismissible: false,
                                                                            builder: (BuildContext context) => DialogAuthorWidget(state),
                                                                        );
                                                                    },
                                                                    child: CircleAvatar(
                                                                        backgroundImage:
                                                                        NetworkImage(
                                                                            (state is LoadedCourseState)
                                                                                ? state.courseDetailResponse.author.avatar_url
                                                                                : "",
                                                                        )),
                                                                )
                                                            ],
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 8.0),
                                                        child: Container(
                                                            height: 55,
                                                            child: Text(
                                                                (state is LoadedCourseState) ? state.courseDetailResponse.title : "",
                                                                textScaleFactor: 1.0,
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 24),
                                                            ),
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 16.0),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(30)),
                                                            child: SizedBox(
                                                                height: 6,
                                                                child: LinearProgressIndicator(
                                                                    value: 0,
                                                                    backgroundColor:
                                                                    HexColor.fromHex("#D7DAE2"),
                                                                    valueColor:
                                                                    new AlwaysStoppedAnimation<
                                                                        Color>(secondColor),
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 16.0),
                                                        child: MaterialButton(
                                                            minWidth: double.infinity,
                                                            color: secondColor,
                                                            onPressed: null,
                                                            child: Text(
                                                                localizations.getLocalization("continue_button"),
                                                                textScaleFactor: 1.0,
                                                            ),
                                                            textColor: Colors.white,
                                                            disabledColor: secondColor.withOpacity(0.5),
                                                            disabledTextColor: Colors.white.withOpacity(0.6),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                ),
                            )
                        ],
                    ),
                ),
            );
        }
    }

    _buildBody(state) {
        if (state is InitialCourseState) return _buildLoading();
        if (state is LoadedCourseState) return _buildLockedScreen(state);
    }

    _buildLockedScreen(LoadedCourseState state) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                            width: 48,
                            height: 61,
                            child: SvgPicture.asset(
                                'assets/icons/lock.svg')
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                            localizations.getLocalization("trial_version_is_over"),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700
                            ),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                            localizations.getLocalization("trial_version_is_over_description"),
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: HexColor.fromHex("#AAAAAA")
                            ),
                        ),
                    )
                ],
            )
        );
    }

    _buildBottom(CourseState state) {
        if (state is LoadedCourseState && state.courseDetailResponse.has_access) {
            return Container(
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#F6F6F6"),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _buildStartButton(state)));
        }
        return Container(
            decoration: BoxDecoration(
                color: HexColor.fromHex("#F6F6F6"),
            ),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        _buildPrice(state),
                        MaterialButton(
                            height: 40,
                            color: mainColor,
                            onPressed: () {
                                if (state is LoadedCourseState) {
                                    if (!state.courseDetailResponse.has_access) {
                                        if (_bloc.selectedPaymetId == -1) {
                                            _bloc.add(AddToCart(state.courseDetailResponse.id));
                                        } else {
                                            _bloc.add(UsePlan(state.courseDetailResponse.id));
                                        }
                                    }
                                }
                            },
                            child: setUpButtonChild(state),
                        )
                    ],
                ),
            ),
        );
    }

    _buildPrice(CourseState state) {
        if (state is LoadedCourseState) {
            if (!state.courseDetailResponse.has_access) {
                if (state.courseDetailResponse.price.free) {
                    return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                            Text(
                                localizations.getLocalization("course_free_price"),
                                textScaleFactor: 1.0,
                            ),
                            Icon(Icons.arrow_drop_down)],
                    );
                } else {
                    String selectedPlan;
                    if (_bloc.selectedPaymetId == -1)
                        selectedPlan =
                        "${localizations.getLocalization("course_regular_price")} ${state.courseDetailResponse.price.price}";
                    if (state.userPlans.isNotEmpty) {
                        state.userPlans.forEach((value) {
                            if (int.parse(value.id) == _bloc.selectedPaymetId)
                                selectedPlan = value.name;
                        });
                    }
                    return GestureDetector(
                        onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (builder) {
                                    return BlocProvider.value(
                                        child: Dialog(
                                            child: PurchaseDialog(),
                                        ),
                                        value: _bloc,
                                    );
                                });
                            setState(() {});
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                Text(
                                    selectedPlan,
                                    textScaleFactor: 1.0,
                                ),
                                Icon(Icons.arrow_drop_down)
                            ],
                        ),
                    );
                }
            } else {
                return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[],
                );
            }
        }
        return Text("");
    }

    Widget setUpButtonChild(CourseState state) {
        String buttonText;
        bool enable = state is LoadedCourseState;

        if (state is LoadedCourseState) {
            buttonText = state.courseDetailResponse.purchase_label;
        }

        if (enable == true) {
            return new Text(
                buttonText.toUpperCase(),
                textScaleFactor: 1.0,
            );
        } else {
            return SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
            );
        }
    }

    _buildStartButton(LoadedCourseState state) {
        return MaterialButton(
            height: 40,
            color: secondColor,
            onPressed: () {
                switch (state.courseDetailResponse.first_lesson_type) {
                    case "video":
                        Navigator.of(context).pushReplacementNamed(
                            LessonVideoScreen.routeName,
                            arguments: LessonVideoScreenArgs(
                                state.courseDetailResponse.id,
                                state.courseDetailResponse.first_lesson,
                                state.courseDetailResponse.author.avatar_url,
                                state.courseDetailResponse.author.login,
                                true, state.courseDetailResponse.trial),
                        );
                        break;
                    default:
                        Navigator.of(context).pushReplacementNamed(
                            TextLessonScreen.routeName,
                            arguments: TextLessonScreenArgs(
                                state.courseDetailResponse.id,
                                state.courseDetailResponse.first_lesson,
                                state.courseDetailResponse.author.avatar_url,
                                state.courseDetailResponse.author.login,
                                true, state.courseDetailResponse.trial),
                        );
                }
            },
            child: Text(
                localizations.getLocalization("start_course_button"),
                textScaleFactor: 1.0,
                style: TextStyle(color: white),
            ),
        );
    }


    _buildLoading() => Center(
        child: CircularProgressIndicator(),
    );
}