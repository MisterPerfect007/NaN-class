import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nan_class/features/loginAndRegister/data/models/user_model.dart';

import '../../../../core/failure/failures.dart';
import '../../../loginAndRegister/utils/google_auth.dart';

///Get user data
///
///return a [UserModel] when a user is found
///or [UserFailure] when somthing went wrong
Future<Either<UserFailure, UserModel>> getUserRemoteDataSource() async {
  //
  final googleUserId = await getUserGoogleIdFromLocal();
  final Response response;

  ///!should check if googleUserId is not before
  if (googleUserId != null) {
    try {
      response = await http.get(
          Uri.https('classe.nan.ci', '/api/mobile/getUser'),
          headers: {'auth': googleUserId}).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        //Response is ok
        final body = response.body;
        final jsonBody = jsonDecode(body);
        if (!jsonBody['status']) {
          //if status is false, it means there is not such user is db
          return const Left(UserFailure(UserErrorType.noUserFound));
        } else {
          try {
            return Right(UserModel.fromJson(jsonBody['data']));
          } catch (e) {
            return const Left(UserFailure(UserErrorType.unexpectedError));
          }
        }
      } else {
        return const Left(UserFailure(UserErrorType.failedRequest));
      }
    } catch (e) {
      return const Left(UserFailure(UserErrorType.noInternet));
    }
  }else{
    return const Left(UserFailure(UserErrorType.unexpectedError));
  }
}
