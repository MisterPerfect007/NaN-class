import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nan_class/core/constants/constants.dart';
import 'package:nan_class/features/Quizs/data/models/quiz_model.dart';
import 'package:nan_class/features/loginAndRegister/utils/google_auth.dart';

import '../../../../core/failure/failures.dart';

///Get quiz
///
///return a [QuizModel] when everything went fine
///or [RequestFailure] when somthing went wrong
Future<Either<RequestFailure, QuizModel>> getQuizRemoteDataSource({
  required String courseName,
  required String sectionName,
}) async {
  //
  String? googleUserId = await getUserGoogleIdFromLocal();
  //

  if (googleUserId == null) {
    return const Left(RequestFailure(RequestFailureType.unexpectedError));
  }
  //
  final Response response;

  try {

    response = await http.get(
      Uri.https(apiBaseUrl, '/api/mobile/getQuiz/$courseName/$sectionName'),
      headers: {
        'auth': googleUserId,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 60));

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(response.body);

    if (response.statusCode == 200) {
      //Response is ok
      final body = response.body;

      // print(body);

      final Map<String, dynamic> jsonBody =
          Map<String, dynamic>.from(jsonDecode(body));

      if (jsonBody["status"] as bool) {
        try {
          return Right(QuizModel.fromJson(jsonBody["data"]));
        } catch (e) {
          return const Left(RequestFailure(RequestFailureType.unexpectedError));
        }
      } else {
        return const Left(RequestFailure(RequestFailureType.noResultFound));
      }
    } else {
      return const Left(RequestFailure(RequestFailureType.failedRequest));
    }
  } catch (e) {
    return const Left(RequestFailure(RequestFailureType.noInternet));
  }
}
