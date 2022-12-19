import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/failure/failures.dart';
import '../../../loginAndRegister/utils/google_auth.dart';

Future<Either<RequestFailure, String>> startQuiz(String courseName, String quizId) async {
  //
  String? googleUserId = await getUserGoogleIdFromLocal();
  //
  if (googleUserId == null) {
    return const Left(RequestFailure(RequestFailureType.unexpectedError));
  }
  //
  final requestBody = {
    "course": courseName,
    "quizId": quizId
  };
  //
  final Response response;

  try {
    response = await http
        .post(Uri.http(localApiUrl, '/api/mobile/startQuiz'),
            headers: {
              'auth': googleUserId,
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
            encoding: Encoding.getByName("utf-8"))
        .timeout(const Duration(seconds: 60));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (body["status"] as bool) {
        return const Right("started");
      } else {
        //
        return const Left(RequestFailure(RequestFailureType.unexpectedError));
      }
    } else {
      //
      return const Left(RequestFailure(RequestFailureType.failedRequest));
    }
  } catch (e) {
    //
    return const Left(RequestFailure(RequestFailureType.noInternet));
  }
}
