import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/package/internet_connection_checker.dart';
import 'package:nan_class/features/courses/domain/courses_entity.dart';

import '../../../data/datasources/courses_remote_data_source.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial()) {
    on<CoursesEvent>((event, emit) async {
      if (event is GetCourses) {
        emit(CoursesLoading());
        if (await InternetConnection.hasConnection) {
          final coursesOrFailure =
              await getCourcesRemoteDataSource(event.googleUserId);
          coursesOrFailure.fold((failure) => emit(CoursesFailed(failure.error)),
              (courses) => emit(CoursesLoaded(courses)));
        }else{
          emit(const CoursesFailed(CourseErrorType.noInternet));
        }
      }
    });
  }
}
