part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class GetCourses extends CoursesEvent{
  final String googleUserId;

  const GetCourses(this.googleUserId);
  
  @override
  List<Object> get props => [googleUserId];
}
