import '../../domain/courses_entity.dart';

class CoursesModel extends Courses {
  const CoursesModel({
    month,
    required courses,
  }) : super(month: month, courses: courses);

  factory CoursesModel.fromJSON(
          {required List<Map<String, dynamic>> json, String? month}) =>
      CoursesModel(
          month: month,
          courses: json.map((e) => MonthCourse.fromJSON(e)).toList());
}

class MonthCourse {
  final String? id;
  final String? name;
  final String? language;
  final String? forr;
  final int? sections;
  final List<String>? months;

  MonthCourse({
    this.id,
    this.name,
    this.sections,
    this.forr,
    this.language,
    this.months,
  });

  factory MonthCourse.fromJSON(Map<String, dynamic> json) => MonthCourse(
        id: json["id"],
        name: json["name"],
        sections: json["sections"],
        forr: json["for"],
        language: json["language"],
        months: List<String>.from(json["months"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "language": language,
        "for": forr,
        "sections": sections,
        "months": months
      };
}
