import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nan_class/features/loginAndRegister/data/models/user_model.dart';

import '../models/courses_model.dart';

///Get user data
///
///return a [UserModel] when a user is found
///or [CourseFailure] when somthing went wrong
Future<Either<CourseFailure, List<CoursesModel>>> getCourcesRemoteDataSource(
    String googleUserId) async {
  final Response response;
  try {
    response = await http.get(
        Uri.http('192.168.88.31:4000', '/api/mobile/getCourses'),
        headers: {'auth': googleUserId}).timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      //Response is ok
      final body = response.body;
      final Map<String, List<dynamic>> jsonBody =
          Map<String, List<dynamic>>.from(jsonDecode(body));

      try {
        List<CoursesModel> courses = [];
        jsonBody.forEach((month, coursesJson) {
          courses.add(CoursesModel.fromJSON(
              month: month,
              json: List<Map<String, dynamic>>.from(coursesJson)));
        });
        return Right(courses);
      } catch (e) {
        return const Left(CourseFailure(CourseErrorType.noCourseFound));
      }
    } else {
      return const Left(CourseFailure(CourseErrorType.failedRequest));
    }
  } catch (e) {
    return const Left(CourseFailure(CourseErrorType.networkError));
  }
}

class CourseFailure extends Equatable {
  final CourseErrorType error;
  const CourseFailure(this.error);

  @override
  List<Object?> get props => [error];
}

enum CourseErrorType { failedRequest, noCourseFound, networkError }
