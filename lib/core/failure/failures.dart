import 'package:equatable/equatable.dart';

class UserFailure extends Equatable{
  final UserErrorType error;
  const UserFailure(this.error);

  @override
  List<Object?> get props => [error];

}

enum UserErrorType{
  noInternet,
  failedRequest,
  noUserFound,
  networkError,
  unexpectedError
}

class RequestFailure extends Equatable{
  final RequestFailureType type;

  const RequestFailure(this.type);

  @override
  List<Object?> get props => [type];

}

enum RequestFailureType{
  noInternet,
  noResultFound,
  failedRequest,
  networkError,
  unexpectedError
}