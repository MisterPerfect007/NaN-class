part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  
  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {}

class CourseFailed extends CourseState {}

