import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/data/models/purchase/UserPlansResponse.dart';
import 'package:masterstudy_app/data/repository/courses_repository.dart';
import 'package:masterstudy_app/data/repository/purchase_repository.dart';
import 'package:masterstudy_app/data/repository/review_respository.dart';

import './bloc.dart';

@provide
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CoursesRepository _coursesRepository;
  final ReviewRepository _reviewRepository;
  final PurchaseRepository _purchaseRepository;
  CourseDetailResponse courseDetailResponse;
  List<UserPlansBean> availablePlans = List();

  // if payment id is -1, selected type is one time payment
  int selectedPaymetId = -1;

  CourseBloc(this._coursesRepository, this._reviewRepository,
      this._purchaseRepository);

  @override
  CourseState get initialState => InitialCourseState();

  @override
  Stream<CourseState> mapEventToState(
    CourseEvent event,
  ) async* {
    if (event is FetchEvent) {
      yield* _mapFetchToState(event);
    }
    if (event is DeleteFromFavorite) {
      yield* _mapDeleteFavToState(event);
    }
    if (event is AddToFavorite) {
      yield* _mapAddFavToState(event);
    }

    if (event is PaymentSelectedEvent) {
      selectedPaymetId = event.selectedPaymentId;
      _fetchCourse(event.courseId);
    }

    if (event is UsePlan) {
      yield InitialCourseState();
      await _purchaseRepository.usePlan(event.courseId, selectedPaymetId);

      yield* _fetchCourse(event.courseId);
    }

    if (event is AddToCart) {
      var response = await _purchaseRepository.addToCart(event.courseId);
      yield OpenPurchaseState(response.cart_url);
      //yield* _fetchCourse(event.courseId);
    }
  }

  Stream<CourseState> _fetchCourse(courseId) async* {
    if (courseDetailResponse == null || state is ErrorCourseState) yield InitialCourseState();
    try {
      courseDetailResponse = await _coursesRepository.getCourse(courseId);
      var reviews = await _reviewRepository.getReviews(courseId);
      var plans = await _purchaseRepository.getUserPlans();
      availablePlans = await _purchaseRepository.getPlans();
      yield LoadedCourseState(courseDetailResponse, reviews, plans);
    } catch (e, s) {
      print(e);
      print(s);
      yield ErrorCourseState();
    }
  }

  Stream<CourseState> _mapFetchToState(FetchEvent event) async* {
    yield* _fetchCourse(event.courseId);
  }

  Stream<CourseState> _mapAddFavToState(event) async* {
    try {
      await _coursesRepository.addFavoriteCourse(event.courseId);
      yield* _fetchCourse(event.courseId);
    } catch (error) {
      print(error);
    }
  }

  Stream<CourseState> _mapDeleteFavToState(event) async* {
    try {
      await _coursesRepository.deleteFavoriteCourse(event.courseId);
      yield* _fetchCourse(event.courseId);
    } catch (error) {
      print(error);
    }
  }
}
