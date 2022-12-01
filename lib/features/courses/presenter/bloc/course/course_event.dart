part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class GetCourseSections extends CourseEvent {
  final String courseName;
  final List<String> months;
  final String? language;
  final String? forr;

  const GetCourseSections( {
    this.forr,
    required this.courseName,
    required this.months,
    this.language,
  });

  @override
  List<Object> get props => [
        forr!,
        courseName,
        months,
        language!,
      ];
}
