part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  
  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final CourseSectionModel courseSections;

  const CourseLoaded(this.courseSections);

  @override
  List<Object> get props => [courseSections];
}

class CourseFailed extends CourseState {
  final SectionFailure failure;

  const CourseFailed(this.failure);

  @override
  List<Object> get props => [failure];
}

