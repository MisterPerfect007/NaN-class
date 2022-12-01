import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/failure/failures.dart';
import 'package:nan_class/features/Quizs/data/dataSourses/quiz_remote_data_source.dart';
import 'package:nan_class/features/Quizs/data/models/quiz_model.dart';

import '../../../../core/package/internet_connection_checker.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<QuizEvent>((event, emit) async {
      if (event is GetQuiz) {
        emit(QuizLoading());
        if (await InternetConnection.hasConnection) {
          final quizOrFailure = await getQuizRemoteDataSource(
              courseName: event.courseName, sectionName: event.sectionName);
          quizOrFailure.fold(
            (failure) => emit(QuizFailed(failure)),
            (quiz) => emit(QuizLoaded(quiz)),
          );
        }else{
          emit(const QuizFailed(RequestFailure(RequestFailureType.noInternet)));
        }
      }
    });
  }
}
