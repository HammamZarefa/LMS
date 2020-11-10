import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/localization_repository.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/assignment/assignment_bloc.dart';
import 'package:masterstudy_app/ui/bloc/category_detail/bloc.dart';
import 'package:masterstudy_app/ui/bloc/course/bloc.dart';
import 'package:masterstudy_app/ui/bloc/courses/bloc.dart';
import 'package:masterstudy_app/ui/bloc/detail_profile/bloc.dart';
import 'package:masterstudy_app/ui/bloc/edit_profile_bloc/bloc.dart';
import 'package:masterstudy_app/ui/bloc/favorites/bloc.dart';
import 'package:masterstudy_app/ui/bloc/final/bloc.dart';
import 'package:masterstudy_app/ui/bloc/home/bloc.dart';
import 'package:masterstudy_app/ui/bloc/home_simple/bloc.dart';
import 'package:masterstudy_app/ui/bloc/lesson_stream/bloc.dart';
import 'package:masterstudy_app/ui/bloc/lesson_video/bloc.dart';
import 'package:masterstudy_app/ui/bloc/orders/orders_bloc.dart';
import 'package:masterstudy_app/ui/bloc/plans/plans_bloc.dart';
import 'package:masterstudy_app/ui/bloc/profile/bloc.dart';
import 'package:masterstudy_app/ui/bloc/profile_assignment/profile_assignment_bloc.dart';
import 'package:masterstudy_app/ui/bloc/question_ask/bloc.dart';
import 'package:masterstudy_app/ui/bloc/question_details/bloc.dart';
import 'package:masterstudy_app/ui/bloc/questions/bloc.dart';
import 'package:masterstudy_app/ui/bloc/quiz_lesson/quiz_lesson_bloc.dart';
import 'package:masterstudy_app/ui/bloc/quiz_screen/quiz_screen_bloc.dart';
import 'package:masterstudy_app/ui/bloc/review_write/bloc.dart';
import 'package:masterstudy_app/ui/bloc/search/bloc.dart';
import 'package:masterstudy_app/ui/bloc/search_detail/bloc.dart';
import 'package:masterstudy_app/ui/bloc/text_lesson/bloc.dart';
import 'package:masterstudy_app/ui/bloc/user_course/bloc.dart';
import 'package:masterstudy_app/ui/bloc/user_course_locked/bloc.dart';
import 'package:masterstudy_app/ui/bloc/video/bloc.dart';
import 'package:masterstudy_app/ui/screen/assignment/assignment_screen.dart';
import 'package:masterstudy_app/ui/screen/auth/auth_screen.dart';
import 'package:masterstudy_app/ui/screen/category_detail/category_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/course/course_screen.dart';
import 'package:masterstudy_app/ui/screen/detail_profile/detail_profile_screen.dart';
import 'package:masterstudy_app/ui/screen/final/final_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_stream/lesson_stream_screen.dart';
import 'package:masterstudy_app/ui/screen/lesson_video/lesson_video_screen.dart';
import 'package:masterstudy_app/ui/screen/main/main_screen.dart';
import 'package:masterstudy_app/ui/screen/plans/plans_screen.dart';
import 'package:masterstudy_app/ui/screen/profile_assignment/profile_assignment_screen.dart';
import 'package:masterstudy_app/ui/screen/profile_edit/profile_edit_screen.dart';
import 'package:masterstudy_app/ui/screen/question_ask/question_ask_screen.dart';
import 'package:masterstudy_app/ui/screen/question_details/question_details_screen.dart';
import 'package:masterstudy_app/ui/screen/questions/questions_screen.dart';
import 'package:masterstudy_app/ui/screen/quiz_lesson/quiz_lesson_screen.dart';
import 'package:masterstudy_app/ui/screen/quiz_screen/quiz_screen.dart';
import 'package:masterstudy_app/ui/screen/review_write/review_write_screen.dart';
import 'package:masterstudy_app/ui/screen/search_detail/search_detail_screen.dart';
import 'package:masterstudy_app/ui/screen/splash/splash_screen.dart';
import 'package:masterstudy_app/ui/screen/text_lesson/text_lesson_screen.dart';
import 'package:masterstudy_app/ui/screen/user_course/user_course.dart';
import 'package:masterstudy_app/ui/screen/user_course_locked/user_course_locked_screen.dart';
import 'package:masterstudy_app/ui/screen/video_screen/video_screen.dart';
import 'package:masterstudy_app/ui/screen/web_checkout/web_checkout_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/app_injector.dart';
import 'ui/screen/orders/orders.dart';
import 'ui/screen/user_course/user_course.dart';

typedef Provider<T> = T Function();

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

LocalizationRepository localizations;
Color mainColor, mainColorA, secondColor;

bool dripContentEnabled = false;

void main() async {

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.grey.withOpacity(0.4), //top bar color
        statusBarIconBrightness: Brightness.light, //top bar icons
      )
  );

  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  localizations = LocalizationRepositoryImpl(await getDefaultLocalization());
  await setColors();

  runZoned(() async {
    var container = await AppInjector.create();

    runApp(container.app);
  }, onError: Crashlytics.instance.recordError);
}

Future<bool> setColors() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  try {
    final mcr = sharedPreferences.getInt("main_color_r");
    final mcg = sharedPreferences.getInt("main_color_g");
    final mcb = sharedPreferences.getInt("main_color_b");
    final mca = sharedPreferences.getDouble("main_color_a");

    final scr = sharedPreferences.getInt("second_color_r");
    final scg = sharedPreferences.getInt("second_color_g");
    final scb = sharedPreferences.getInt("second_color_b");
    final sca = sharedPreferences.getDouble("second_color_a");

    mainColor = Color.fromRGBO(mcr, mcg, mcb, mca);
    mainColorA = Color.fromRGBO(mcr, mcg, mcb, 0.999);
    secondColor = Color.fromRGBO(scr, scg, scb, sca);

  } catch(e) {
    mainColor = blue_blue;
    mainColorA = blue_blue_a;
    secondColor = seaweed;
  }
  return true;
}

Future<String> getDefaultLocalization() async {
  String data =
      await rootBundle.loadString('assets/localization/default_locale.json');
  return data;
}

String appLogoUrl;

@provide
class MyApp extends StatelessWidget {
  final Provider<AuthScreen> authScreen;
  final Provider<HomeBloc> homeBloc;
  final Provider<FavoritesBloc> favoritesBloc;
  final Provider<SplashScreen> splashScreen;
  final Provider<ProfileBloc> profileBloc;
  final Provider<DetailProfileBloc> detailProfileBloc;
  final Provider<EditProfileBloc> editProfileBloc;
  final Provider<SearchScreenBloc> searchScreenBloc;
  final Provider<SearchDetailBloc> searchDetailBloc;
  final Provider<CourseBloc> courseBloc;
  final Provider<HomeSimpleBloc> homeSimpleBloc;
  final Provider<CategoryDetailBloc> categoryDetailBloc;
  final Provider<AssignmentBloc> assignmentBloc;
  final Provider<ProfileAssignmentBloc> profileAssignmentBloc;
  final Provider<ReviewWriteBloc> reviewWriteBloc;
  final Provider<UserCoursesBloc> userCoursesBloc;
  final Provider<UserCourseBloc> userCourseBloc;
  final Provider<UserCourseLockedBloc> userCourseLockedBloc;
  final Provider<TextLessonBloc> textLessonBloc;
  final Provider<LessonVideoBloc> lessonVideoBloc;
  final Provider<LessonStreamBloc> lessonStreamBloc;
  final Provider<VideoBloc> videoBloc;
  final Provider<QuizLessonBloc> quizLessonBloc;
  final Provider<QuestionsBloc> questionsBloc;
  final Provider<QuestionAskBloc> questionAskBloc;
  final Provider<QuestionDetailsBloc> questionDetailsBloc;
  final Provider<QuizScreenBloc> quizScreenBloc;
  final Provider<FinalBloc> finalBloc;
  final Provider<PlansBloc> plansBloc;
  final Provider<OrdersBloc> ordersBloc;

  const MyApp(
    this.authScreen,
    this.homeBloc,
    this.splashScreen,
    this.favoritesBloc,
    this.profileBloc,
    this.editProfileBloc,
    this.detailProfileBloc,
    this.searchScreenBloc,
    this.searchDetailBloc,
    this.courseBloc,
    this.homeSimpleBloc,
    this.categoryDetailBloc,
    this.profileAssignmentBloc,
    this.assignmentBloc,
    this.reviewWriteBloc,
    this.userCoursesBloc,
    this.userCourseBloc,
    this.userCourseLockedBloc,
    this.textLessonBloc,
    this.quizLessonBloc,
    this.lessonVideoBloc,
    this.lessonStreamBloc,
    this.videoBloc,
    this.questionsBloc,
    this.questionAskBloc,
    this.questionDetailsBloc,
    this.quizScreenBloc,
    this.finalBloc,
    this.plansBloc,
    this.ordersBloc,
  ) : super();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Masterstudy',
      theme: _buildShrineTheme(),
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
      // ignore: missing_return
      navigatorKey: navigatorKey,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case SplashScreen.routeName:
            // ignore: missing_return
            return MaterialPageRoute(builder: (context) => splashScreen());
          case AuthScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => authScreen(), settings: routeSettings);
          case MainScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => _getProvidedMainScreen(),
                settings: routeSettings);
          case CourseScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => CourseScreen(courseBloc()),
                settings: routeSettings);
          case SearchDetailScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => SearchDetailScreen(searchDetailBloc()),
                settings: routeSettings);
          case DetailProfileScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => DetailProfileScreen(detailProfileBloc()),
                settings: routeSettings);
          case ProfileEditScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => ProfileEditScreen(editProfileBloc()),
                settings: routeSettings);
          case CategoryDetailScreen.routeName:
            return MaterialPageRoute(
                builder: (context) =>
                    CategoryDetailScreen(categoryDetailBloc()),
                settings: routeSettings);
          case ProfileAssignmentScreen.routeName:
            return MaterialPageRoute(
                builder: (context) =>
                    ProfileAssignmentScreen(profileAssignmentBloc()),
                settings: routeSettings);
          case AssignmentScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => AssignmentScreen(assignmentBloc()),
                settings: routeSettings);
          case ReviewWriteScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => ReviewWriteScreen(reviewWriteBloc()),
                settings: routeSettings);
          case UserCourseScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => UserCourseScreen(userCourseBloc()),
                settings: routeSettings);
          case TextLessonScreen.routeName:
            return PageTransition(child:TextLessonScreen(textLessonBloc()),type: PageTransitionType.leftToRight,settings: routeSettings);
          case LessonVideoScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => LessonVideoScreen(lessonVideoBloc()),
                settings: routeSettings);
          case LessonStreamScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => LessonStreamScreen(lessonStreamBloc()),
                settings: routeSettings);
          case VideoScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => VideoScreen(videoBloc()),
                settings: routeSettings);
          case QuizLessonScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => QuizLessonScreen(quizLessonBloc()),
                settings: routeSettings);
          case QuestionsScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => QuestionsScreen(questionsBloc()),
                settings: routeSettings);
          case QuestionAskScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => QuestionAskScreen(questionAskBloc()),
                settings: routeSettings);
          case QuestionDetailsScreen.routeName:
            return MaterialPageRoute(
                builder: (context) =>
                    QuestionDetailsScreen(questionDetailsBloc()),
                settings: routeSettings);
          case FinalScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => FinalScreen(finalBloc()),
                settings: routeSettings);
          case QuizScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => QuizScreen(quizScreenBloc()),
                settings: routeSettings);
          case PlansScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => PlansScreen(plansBloc()),
                settings: routeSettings);
          case WebCheckoutScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => WebCheckoutScreen(),
                settings: routeSettings);
          case OrdersScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => OrdersScreen(ordersBloc()),
                settings: routeSettings);
          case UserCourseLockedScreen.routeName:
            return MaterialPageRoute(
                builder: (context) => UserCourseLockedScreen(courseBloc()),
                settings: routeSettings);
          default:
            return MaterialPageRoute(builder: (context) => splashScreen());
        }
      },
    );
  }

  _getProvidedMainScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (BuildContext context) => homeBloc()),
        BlocProvider<HomeSimpleBloc>(
            create: (BuildContext context) => homeSimpleBloc()),
        BlocProvider<FavoritesBloc>(
            create: (BuildContext context) => favoritesBloc()),
        BlocProvider<ProfileBloc>(
            create: (BuildContext context) => profileBloc()),
        BlocProvider<SearchScreenBloc>(
            create: (BuildContext context) => searchScreenBloc()),
        BlocProvider<UserCoursesBloc>(
            create: (BuildContext context) => userCoursesBloc()),
      ],
      child: MainScreen(),
    );
  }

  ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: mainColor,
      primaryColor: mainColor,
      buttonTheme: buttonThemeData,
      buttonBarTheme: base.buttonBarTheme.copyWith(
        buttonTextTheme: ButtonTextTheme.accent,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      textTheme: getTextTheme(base.primaryTextTheme),
      primaryTextTheme: getTextTheme(base.primaryTextTheme).apply(
        bodyColor: mainColor,
        displayColor: mainColor,
      ),
      accentTextTheme: textTheme,
      textSelectionColor: mainColor.withOpacity(0.4),
      errorColor: Colors.red[400],
    );
  }
}
