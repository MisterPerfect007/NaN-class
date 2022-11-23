import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/course_section_model.dart';

///Get course sections data
///
///return a [CourseSectionModel] when everything went fine
///or [SectionFailure] when somthing went wrong
Future<Either<SectionFailure, CourseSectionModel>>
    getSectionsRemoteDataSource({
      String? speciality,
      required String courseName,
      List<String>? months,
      String? language,
    }) async {

  final Map<String, dynamic> requestBody = {
    "speciality": speciality?? "INTRO",
    "courseName": courseName,
    "months": months,
    "language": language
  };

  final Response response;

  try {
    response = await http
        .post(
          Uri.http('192.168.88.31:4000', '/api/mobile/getCourses'),
          body: requestBody,
        )
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

String bodyString = '''{
    "status": true,
    "data": {
      "1-section one": {
        "data": [
          {
            "name": "video.mp4",
            "ext": ".mp4",
            "link": "FLUTTER/FR->matrisier_flutter_Oct_Nov/1-section_+one/video.mp4",
            "subtitles": [],
            "size": 0
          }
        ],
        "withoutQuiz": false,
        "active": true,
        "pass": false,
        "quiz": {
          "attempts": 2,
          "deductionPoints": 0,
          "seconds": 0,
          "endTime": 334567,
          "points": 3,
          "pass": false,
          "responses": {
            "C quoi Flutter": "Framework",
            "architecture en flutter": [
              "mvn",
              "mvc"
            ]
          }
        }
      },
      "2-section-two": {
        "data": [
          {
            "name": "video2.mp4",
            "ext": ".mp4",
            "link": "FLUTTER/FR->matrisier_flutter_Oct_Nov/2-section-two/video2.mp4",
            "subtitles": [],
            "size": 0
          }
        ],
        "withoutQuiz": false,
        "active": false,
        "pass": false,
        "quiz": {
          "attempts": 2,
          "deductionPoints": 0,
          "seconds": 0,
          "endTime": 334567,
          "points": 3,
          "pass": false,
          "responses": {
            "C quoi Flutter": "Framework",
            "architecture en flutter": [
              "mvn",
              "mvc"
            ]
          }
        }
      }
    }
  }''';
