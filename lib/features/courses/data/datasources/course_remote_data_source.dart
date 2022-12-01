import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nan_class/core/constants/constants.dart';
import 'package:nan_class/features/loginAndRegister/utils/google_auth.dart';

import '../../utils/utils.dart';
import '../models/course_section_model.dart';

///Get course sections data
///
///return a [CourseSectionModel] when everything went fine
///or [SectionFailure] when somthing went wrong
Future<Either<SectionFailure, CourseSectionModel>> getSectionsRemoteDataSource({
  required String courseName,
  List<String>? months,
  String? forr,
  String? language,
}) async {
  //
  String? googleUserId = await getUserGoogleIdFromLocal();
  //
  String? speciality = await getUserSpeciality();
  //
  ///* if [forr] is not null so we send "INTRO" as speciality
  final requestBody = {
    "speciality": forr == null ? speciality?.toUpperCase() : "INTRO",
    "courseName": courseName,
    "months": months,
    "for": forr,
    "language": language
  };

  if (googleUserId == null) {
    return const Left(SectionFailure(SectionErrorType.unexpectedError));
  }
  //
  final Response response;

  try {
    response = await http
        .post(Uri.https(apiBaseUrl, '/api/mobile/getCourseSections/'),
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
    return const Left(SectionFailure(SectionErrorType.noInternet));
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
  unexpectedError,
  noInternet
}
