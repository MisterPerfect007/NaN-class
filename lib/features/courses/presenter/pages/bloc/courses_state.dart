part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();
  
  @override
  List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<Courses> courses;

  const CoursesLoaded(this.courses);
}

class CoursesFailed extends CoursesState {
  final CourseErrorType errorType;

  const CoursesFailed(this.errorType);
}
