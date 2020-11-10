import 'dart:io';

import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/AssignmentResponse.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';

abstract class AssignmentRepository {
    Future<AssignmentResponse> getAssignmentInfo(int course_id, int assignment_id);
    Future<AssignmentResponse> startAssignment(int course_id, int assignment_id);
    Future<AssignmentResponse> addAssignment(int course_id, int user_assignment_id, String content);
    Future<String> uploadAssignmentFile(int course_id, int user_assignment_id, File file);
}

@provide
class AssignmentRepositoryImpl extends AssignmentRepository {
    final UserApiProvider apiProvider;

    AssignmentRepositoryImpl(this.apiProvider);

    @override
    Future<AssignmentResponse> getAssignmentInfo(int course_id, int assignment_id) {
        return apiProvider.getAssignmentInfo(course_id, assignment_id);
    }

    @override
    Future<AssignmentResponse> startAssignment(int course_id, int assignment_id) {
        return apiProvider.startAssignment(course_id, assignment_id);
    }

    @override
    Future<AssignmentResponse> addAssignment(int course_id, int user_assignment_id, String content) {
        return apiProvider.addAssignment(course_id, user_assignment_id, content);
    }

    @override
    Future<String> uploadAssignmentFile(int course_id, int user_assignment_id, File file) {
        return apiProvider.uploadAssignmentFile(course_id, user_assignment_id, file);
    }
}