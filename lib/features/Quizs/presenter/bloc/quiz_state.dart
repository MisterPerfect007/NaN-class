part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  
  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final QuizModel quiz;

  const QuizLoaded(this.quiz);

  @override
  List<Object> get props => [quiz];
}

class QuizFailed extends QuizState {
  final RequestFailure failure;
  const QuizFailed(this.failure);

  @override
  List<Object> get props => [failure];
}