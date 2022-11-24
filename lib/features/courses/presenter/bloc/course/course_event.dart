part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class GetCourseSections extends CourseEvent {
  final String googleUserId;
  final String? speciality;
  final String courseName;
  final List<String> months;
  final String? language;

  const GetCourseSections({
    required this.googleUserId,
    this.speciality,
    required this.courseName,
    required this.months,
    this.language,
  });

  @override
  List<Object> get props => [
        googleUserId,
        speciality!,
        courseName,
        months,
        language!,
      ];
}
