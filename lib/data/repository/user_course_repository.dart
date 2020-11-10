import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/data/models/curriculum.dart';
import 'package:masterstudy_app/data/models/user_course.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';

abstract class UserCourseRepository {
  Future<UserCourseResponse> getUserCourses();

  Future<CurriculumResponse> getCourseCurriculum(int id);

  Future<CourseDetailResponse> getCourse(int courseId);
}

class UserCourseRepositoryImpl extends UserCourseRepository {
  final UserApiProvider _apiProvider;

  UserCourseRepositoryImpl(this._apiProvider);

  @override
  Future<UserCourseResponse> getUserCourses() {
    return _apiProvider.getUserCourses();
  }

  @override
  Future<CurriculumResponse> getCourseCurriculum(int id) {
    return _apiProvider.getCourseCurriculum(id);
  }

  @override
  Future<CourseDetailResponse> getCourse(int courseId) {
    return _apiProvider.getCourse(courseId);
  }
}
