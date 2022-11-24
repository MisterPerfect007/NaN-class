import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nan_class/core/constants/constants.dart';

import '../models/course_section_model.dart';

///Get course sections data
///
///return a [CourseSectionModel] when everything went fine
///or [SectionFailure] when somthing went wrong
Future<Either<SectionFailure, CourseSectionModel>> getSectionsRemoteDataSource({
  required String googleUserId,
  String? speciality,
  required String courseName,
  List<String>? months,
  String? language,
}) async {

  final requestBody = {
    "speciality": speciality ?? "INTRO",
    "courseName": courseName,
    "months": months,
    "language": language
  };

  final Response response;

  try {
    response = await http
        .post(Uri.https(apiBaseUrl, '/api/mobile/getCourseSections'),
            headers: {
              'auth': googleUserId,
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
            encoding: Encoding.getByName("utf-8"))
        .timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      //Response is ok
      final body = response.body;
      // final body = bodyString;
      
      final Map<String, dynamic> jsonBody =
          Map<String, dynamic>.from(jsonDecode(body));

      if (jsonBody["status"] as bool == true) {
        try {
          return Right(CourseSectionModel.fromJson(jsonBody));
        } catch (e) {
          return const Left(SectionFailure(SectionErrorType.unexpectedError));
        }
      } else {
        return const Left(SectionFailure(SectionErrorType.failedRequest));
      }
    } else {
      return const Left(SectionFailure(SectionErrorType.failedRequest));
    }
  } catch (e) {
    return const Left(SectionFailure(SectionErrorType.networkError));
  }
}

class SectionFailure extends Equatable {
  final SectionErrorType error;
  const SectionFailure(this.error);

  @override
  List<Object?> get props => [error];
}

enum SectionErrorType {
  failedRequest,
  noSection,
  networkError,
  unexpectedError
}
