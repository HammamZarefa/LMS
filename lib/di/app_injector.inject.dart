import 'app_injector.dart' as _i1;
import 'modules.dart' as _i2;
import 'package:dio/src/dio.dart' as _i3;
import '../data/network/api_provider.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i5;
import '../data/repository/auth_repository.dart' as _i6;
import '../data/repository/home_repository.dart' as _i7;
import '../data/repository/courses_repository.dart' as _i8;
import '../data/repository/instructors_repository.dart' as _i9;
import '../data/repository/review_respository.dart' as _i10;
import '../data/repository/assignment_repository.dart' as _i11;
import '../data/repository/questions_repository.dart' as _i12;
import '../data/repository/final_repository.dart' as _i13;
import 'dart:async' as _i14;
import '../main.dart' as _i15;
import '../ui/screen/auth/auth_screen.dart' as _i16;
import '../ui/bloc/auth/auth_bloc.dart' as _i17;
import '../ui/bloc/home/home_bloc.dart' as _i18;
import '../ui/screen/splash/splash_screen.dart' as _i19;
import '../ui/bloc/splash/splash_bloc.dart' as _i20;
import '../ui/bloc/favorites/favorites_bloc.dart' as _i21;
import '../ui/bloc/profile/profile_bloc.dart' as _i22;
import '../data/repository/account_repository.dart' as _i23;
import '../ui/bloc/edit_profile_bloc/edit_profile_bloc.dart' as _i24;
import '../ui/bloc/detail_profile/detail_profile_bloc.dart' as _i25;
import '../ui/bloc/search/search_screen_bloc.dart' as _i26;
import '../ui/bloc/search_detail/search_detail_bloc.dart' as _i27;
import '../ui/bloc/course/course_bloc.dart' as _i28;
import '../data/repository/purchase_repository.dart' as _i29;
import '../ui/bloc/home_simple/home_simple_bloc.dart' as _i30;
import '../ui/bloc/category_detail/category_detail_bloc.dart' as _i31;
import '../ui/bloc/profile_assignment/profile_assignment_bloc.dart' as _i32;
import '../ui/bloc/assignment/assignment_bloc.dart' as _i33;
import '../ui/bloc/review_write/review_write_bloc.dart' as _i34;
import '../ui/bloc/courses/user_courses_bloc.dart' as _i35;
import '../data/repository/user_course_repository.dart' as _i36;
import '../ui/bloc/user_course/user_course_bloc.dart' as _i37;
import '../ui/bloc/user_course_locked/user_course_locked_bloc.dart' as _i38;
import '../ui/bloc/text_lesson/text_lesson_bloc.dart' as _i39;
import '../data/repository/lesson_repository.dart' as _i40;
import '../ui/bloc/quiz_lesson/quiz_lesson_bloc.dart' as _i41;
import '../ui/bloc/lesson_video/lesson_video_bloc.dart' as _i42;
import '../ui/bloc/lesson_stream/lesson_stream_bloc.dart' as _i43;
import '../ui/bloc/video/video_bloc.dart' as _i44;
import '../ui/bloc/questions/questions_bloc.dart' as _i45;
import '../ui/bloc/question_ask/question_ask_bloc.dart' as _i46;
import '../ui/bloc/question_details/question_details_bloc.dart' as _i47;
import '../ui/bloc/quiz_screen/quiz_screen_bloc.dart' as _i48;
import '../ui/bloc/final/final_bloc.dart' as _i49;
import '../ui/bloc/plans/plans_bloc.dart' as _i50;
import '../ui/bloc/orders/orders_bloc.dart' as _i51;
import '../ui/screen/home/home_screen.dart' as _i52;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._(this._appModule);

  final _i2.AppModule _appModule;

  _i3.Dio _singletonDio;

  _i4.UserApiProvider _singletonUserApiProvider;

  _i5.SharedPreferences _sharedPreferences;

  _i6.AuthRepository _singletonAuthRepository;

  _i7.HomeRepository _singletonHomeRepository;

  _i8.CoursesRepository _singletonCoursesRepository;

  _i9.InstructorsRepository _singletonInstructorsRepository;

  _i10.ReviewRepository _singletonReviewRepository;

  _i11.AssignmentRepository _singletonAssignmentRepository;

  _i12.QuestionsRepository _singletonQuestionsRepository;

  _i13.FinalRepository _singletonFinalRepository;

  static _i14.Future<_i1.AppInjector> create(_i2.AppModule appModule) async {
    final injector = AppInjector$Injector._(appModule);
    injector._sharedPreferences =
        await injector._appModule.provideSharedPreferences();
    return injector;
  }

  _i15.MyApp _createMyApp() => _i15.MyApp(
      _createAuthScreen,
      _createHomeBloc,
      _createSplashScreen,
      _createFavoritesBloc,
      _createProfileBloc,
      _createEditProfileBloc,
      _createDetailProfileBloc,
      _createSearchScreenBloc,
      _createSearchDetailBloc,
      _createCourseBloc,
      _createHomeSimpleBloc,
      _createCategoryDetailBloc,
      _createProfileAssignmentBloc,
      _createAssignmentBloc,
      _createReviewWriteBloc,
      _createUserCoursesBloc,
      _createUserCourseBloc,
      _createUserCourseLockedBloc,
      _createTextLessonBloc,
      _createQuizLessonBloc,
      _createLessonVideoBloc,
      _createLessonStreamBloc,
      _createVideoBloc,
      _createQuestionsBloc,
      _createQuestionAskBloc,
      _createQuestionDetailsBloc,
      _createQuizScreenBloc,
      _createFinalBloc,
      _createPlansBloc,
      _createOrdersBloc);
  _i16.AuthScreen _createAuthScreen() => _i16.AuthScreen(_createAuthBloc());
  _i17.AuthBloc _createAuthBloc() =>
      _appModule.provideAuthBloc(_createAuthRepository());
  _i6.AuthRepository _createAuthRepository() =>
      _singletonAuthRepository ??= _appModule.userRepository(
          _createUserApiProvider(), _createSharedPreferences());
  _i4.UserApiProvider _createUserApiProvider() => _singletonUserApiProvider ??=
      _appModule.provideUserApiProvider(_createDio());
  _i3.Dio _createDio() => _singletonDio ??= _appModule.provideDio();
  _i5.SharedPreferences _createSharedPreferences() => _sharedPreferences;
  _i18.HomeBloc _createHomeBloc() => _i18.HomeBloc(_createHomeRepository(),
      _createCoursesRepository(), _createInstructorsRepository());
  _i7.HomeRepository _createHomeRepository() =>
      _singletonHomeRepository ??= _appModule.homeRepository(
          _createUserApiProvider(), _createSharedPreferences());
  _i8.CoursesRepository _createCoursesRepository() =>
      _singletonCoursesRepository ??=
          _appModule.coursesRepository(_createUserApiProvider());
  _i9.InstructorsRepository _createInstructorsRepository() =>
      _singletonInstructorsRepository ??=
          _appModule.instructorsRepository(_createUserApiProvider());
  _i19.SplashScreen _createSplashScreen() =>
      _i19.SplashScreen(_createSplashBloc());
  _i20.SplashBloc _createSplashBloc() => _appModule.provideSplashBloc(
      _createAuthRepository(),
      _createHomeRepository(),
      _createUserApiProvider());
  _i21.FavoritesBloc _createFavoritesBloc() =>
      _i21.FavoritesBloc(_createCoursesRepository());
  _i22.ProfileBloc _createProfileBloc() =>
      _i22.ProfileBloc(_createAccountRepository(), _createAuthRepository());
  _i23.AccountRepository _createAccountRepository() =>
      _appModule.provideAccountRepository(_createUserApiProvider());
  _i24.EditProfileBloc _createEditProfileBloc() =>
      _i24.EditProfileBloc(_createAccountRepository());
  _i25.DetailProfileBloc _createDetailProfileBloc() => _i25.DetailProfileBloc(
      _createAccountRepository(), _createCoursesRepository());
  _i26.SearchScreenBloc _createSearchScreenBloc() =>
      _i26.SearchScreenBloc(_createCoursesRepository());
  _i27.SearchDetailBloc _createSearchDetailBloc() =>
      _i27.SearchDetailBloc(_createCoursesRepository());
  _i28.CourseBloc _createCourseBloc() => _i28.CourseBloc(
      _createCoursesRepository(),
      _createReviewRepository(),
      _createPurchaseRepository());
  _i10.ReviewRepository _createReviewRepository() =>
      _singletonReviewRepository ??=
          _appModule.reviewRepository(_createUserApiProvider());
  _i29.PurchaseRepository _createPurchaseRepository() =>
      _appModule.providePurchaseRepository(_createUserApiProvider());
  _i30.HomeSimpleBloc _createHomeSimpleBloc() =>
      _i30.HomeSimpleBloc(_createCoursesRepository());
  _i31.CategoryDetailBloc _createCategoryDetailBloc() =>
      _i31.CategoryDetailBloc(
          _createHomeRepository(), _createCoursesRepository());
  _i32.ProfileAssignmentBloc _createProfileAssignmentBloc() =>
      _i32.ProfileAssignmentBloc();
  _i33.AssignmentBloc _createAssignmentBloc() =>
      _i33.AssignmentBloc(_createAssignmentRepository());
  _i11.AssignmentRepository _createAssignmentRepository() =>
      _singletonAssignmentRepository ??=
          _appModule.assignmentRepository(_createUserApiProvider());
  _i34.ReviewWriteBloc _createReviewWriteBloc() => _i34.ReviewWriteBloc(
      _createAccountRepository(), _createReviewRepository());
  _i35.UserCoursesBloc _createUserCoursesBloc() =>
      _i35.UserCoursesBloc(_createUserCourseRepository());
  _i36.UserCourseRepository _createUserCourseRepository() =>
      _appModule.provideUserCourseRepository(_createUserApiProvider());
  _i37.UserCourseBloc _createUserCourseBloc() =>
      _i37.UserCourseBloc(_createUserCourseRepository());
  _i38.UserCourseLockedBloc _createUserCourseLockedBloc() =>
      _i38.UserCourseLockedBloc(_createUserCourseRepository());
  _i39.TextLessonBloc _createTextLessonBloc() =>
      _i39.TextLessonBloc(_createLessonRepository());
  _i40.LessonRepository _createLessonRepository() =>
      _appModule.provideLessonRepository(_createUserApiProvider());
  _i41.QuizLessonBloc _createQuizLessonBloc() =>
      _i41.QuizLessonBloc(_createLessonRepository());
  _i42.LessonVideoBloc _createLessonVideoBloc() =>
      _i42.LessonVideoBloc(_createLessonRepository());
  _i43.LessonStreamBloc _createLessonStreamBloc() =>
      _i43.LessonStreamBloc(_createLessonRepository());
  _i44.VideoBloc _createVideoBloc() => _i44.VideoBloc();
  _i45.QuestionsBloc _createQuestionsBloc() =>
      _i45.QuestionsBloc(_createQuestionsRepository());
  _i12.QuestionsRepository _createQuestionsRepository() =>
      _singletonQuestionsRepository ??=
          _appModule.questionsRepository(_createUserApiProvider());
  _i46.QuestionAskBloc _createQuestionAskBloc() =>
      _i46.QuestionAskBloc(_createQuestionsRepository());
  _i47.QuestionDetailsBloc _createQuestionDetailsBloc() =>
      _i47.QuestionDetailsBloc(_createQuestionsRepository());
  _i48.QuizScreenBloc _createQuizScreenBloc() =>
      _appModule.provideQuizScreenBloc(_createLessonRepository());
  _i49.FinalBloc _createFinalBloc() => _i49.FinalBloc(_createFinalRepository());
  _i13.FinalRepository _createFinalRepository() => _singletonFinalRepository ??=
      _appModule.finalRepository(_createUserApiProvider());
  _i50.PlansBloc _createPlansBloc() =>
      _i50.PlansBloc(_createPurchaseRepository());
  _i51.OrdersBloc _createOrdersBloc() =>
      _i51.OrdersBloc(_createPurchaseRepository());
  _i52.HomeScreen _createHomeScreen() => _i52.HomeScreen();
  @override
  _i15.MyApp get app => _createMyApp();
  @override
  _i16.AuthScreen get authScreen => _createAuthScreen();
  @override
  _i52.HomeScreen get homeScreen => _createHomeScreen();
  @override
  _i19.SplashScreen get splashScreen => _createSplashScreen();
}
