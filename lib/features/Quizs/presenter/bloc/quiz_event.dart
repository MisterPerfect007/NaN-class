part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class GetQuiz extends QuizEvent {
  final String courseName;
  final String sectionName;

  const GetQuiz({
    required this.courseName,
    required this.sectionName,
  });

  @override
  List<Object> get props => [
        courseName,
        sectionName,
      ];
}
/* 
class SetQuizLoaded extends QuizEvent {
  final QuizModel quiz;

  const SetQuizLoaded(this.quiz);

  @override
  List<Object> get props => [quiz];
}

class SetQuizLoading extends QuizEvent {

  const SetQuizLoading();

  @override
  List<Object> get props => [];
}
 */