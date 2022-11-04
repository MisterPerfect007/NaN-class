import '../../domain/courses_entity.dart';

class CoursesModel extends Courses{

  const CoursesModel({month, required courses}) : super(month: month, courses: courses);

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

  MonthCourse({this.id, this.name, this.sections, this.forr, this.language});

  factory MonthCourse.fromJSON(Map<String, dynamic> json) => MonthCourse(
      id: json["id"],
      name: json["name"],
      sections: json["sections"],
      forr: json["for"],
      language: json["language"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "language": language,
        "for": forr,
        "sections": sections,
      };
}
