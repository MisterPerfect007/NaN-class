import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/features/courses/data/models/course_section_model.dart';

import '../../../../../core/package/internet_connection_checker.dart';
import '../../../data/datasources/course_remote_data_source.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial()) {
    on<CourseEvent>((event, emit) async {
      if (event is GetCourseSections) {
        emit(CourseLoading());
        if (await InternetConnection.hasConnection) {
          final resultOrFailure = await getSectionsRemoteDataSource(
            forr: event.forr,
            courseName: event.courseName,
            months: event.months,
            language: event.language,
          );

          resultOrFailure.fold(
            (failure) { 
              print(failure);
              emit(CourseFailed(failure));},
            (courseSections) => emit(CourseLoaded(courseSections)),
          );
        } else {
          emit(const CourseFailed(SectionFailure(SectionErrorType.noInternet)));
        }
      }
    });
  }
}
