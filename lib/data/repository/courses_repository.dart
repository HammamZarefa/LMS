import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/PopularSearchesResponse.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';
import 'package:masterstudy_app/data/utils.dart';

enum Sort { free, date_low, price_low, price_high, rating, popular, favorite }

abstract class CoursesRepository {
  Future<CourcesResponse> getCourses(
      {int perPage,
      int page,
      Sort sort,
      int authorId,
      int categoryId,
      String searchQuery});

  Future<CourcesResponse> getFavoriteCourses();

  Future addFavoriteCourse(int courseId);

  Future deleteFavoriteCourse(int courseId);

  Future<CourseDetailResponse> getCourse(int courseId);

  Future<PopularSearchesResponse> getPopularSearches();
}

@provide
class CoursesRepositoryImpl extends CoursesRepository {
  final UserApiProvider _apiProvider;

  CoursesRepositoryImpl(this._apiProvider);

  @override
  Future<CourcesResponse> getCourses(
      {int perPage,
      int page,
      Sort sort,
      int authorId,
      int categoryId,
      String searchQuery}) {
    Map<String, dynamic> query = Map();
    query.addParam("per_page", perPage);
    query.addParam("page", page);
    query.addParam("author_id", authorId);
    query.addParam("category", categoryId);
    query.addParam("s", searchQuery);
    if (sort != null) {
      var sortValue;
      switch (sort) {
        case Sort.free:
          sortValue = "free";
          break;
        case Sort.date_low:
          sortValue = "date_low";
          break;
        case Sort.price_low:
          sortValue = "price_low";
          break;
        case Sort.price_high:
          sortValue = "price_high";
          break;
        case Sort.rating:
          sortValue = "rating";
          break;
        case Sort.popular:
          sortValue = "popular";
          break;
        case Sort.favorite:
          sortValue = "favorite";
          break;
      }
      query.addParam("sort", sortValue);
    }

    return _apiProvider.getCourses(query);
  }

  @override
  Future<CourcesResponse> getFavoriteCourses() {
    return _apiProvider.getFavoriteCourses();
  }

  @override
  Future addFavoriteCourse(int courseId) {
    return _apiProvider.addFavoriteCourse(courseId);
  }

  @override
  Future deleteFavoriteCourse(int courseId) {
    return _apiProvider.deleteFavoriteCourse(courseId);
  }

  @override
  Future<CourseDetailResponse> getCourse(int courseId) {
    return _apiProvider.getCourse(courseId);
  }

  @override
  Future<PopularSearchesResponse> getPopularSearches() {
    return _apiProvider.popularSearches(10);
  }
}
