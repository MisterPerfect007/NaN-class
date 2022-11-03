import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nan_class/features/loginAndRegister/data/models/user_model.dart';

import '../../../../core/failure/failures.dart';

///Get user data
///
///return a [UserModel] when a user is found 
///or [UserFailure] when somthing went wrong
Future<Either<UserFailure, UserModel>> getUserRemoteDataSource(
    String googleUserId) async {
  final Response response;
  try {
    response = await http
        .get(Uri.http('192.168.88.87:4000', '/api/mobile/getUser'), headers: {
      'auth': googleUserId
    }).timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      //Response is ok
      final body = response.body;
      final jsonBody = jsonDecode(body);
      if (!jsonBody['status']) {
        //if status is false, it means there is not such user is db
        return const Left(UserFailure(UserErrorType.noUserFound));
      } else {
        return Right(UserModel.fromJson(jsonBody['data']));
      }
    } else {
      return const Left(UserFailure(UserErrorType.failedRequest));
    }
  } catch (e) {
    return const Left(UserFailure(UserErrorType.networkError));
  }
}
