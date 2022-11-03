part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends HomeEvent{
  final String googleUserId;
  const GetUser(this.googleUserId);

  @override
  List<Object> get props => [googleUserId];
}