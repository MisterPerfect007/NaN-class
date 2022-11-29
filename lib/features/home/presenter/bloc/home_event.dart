part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends HomeEvent{
  const GetUser();

  @override
  List<Object> get props => [];
}

class SetUserLoadedState extends HomeEvent{
  final User user;
  const SetUserLoadedState(this.user);

  @override
  List<Object> get props => [user];
}