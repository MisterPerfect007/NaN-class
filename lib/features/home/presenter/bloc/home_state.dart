part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final User user;

  const HomeLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class HomeFailure extends HomeState {
  final UserErrorType errorType;
  const HomeFailure(this.errorType);

  @override
  List<Object> get props => [errorType];
}
