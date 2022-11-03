import 'package:equatable/equatable.dart';

class UserFailure extends Equatable{
  final UserErrorType error;
  const UserFailure(this.error);

  @override
  List<Object?> get props => [error];

}

enum UserErrorType{
  failedRequest,
  noUserFound,
  networkError
}