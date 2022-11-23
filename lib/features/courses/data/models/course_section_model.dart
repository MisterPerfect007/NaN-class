import 'package:equatable/equatable.dart';

class CourseSectionModel extends Equatable {
  final List<Section> sections;
  const CourseSectionModel({required this.sections});

  factory CourseSectionModel.fromJson(Map<String, dynamic> json) {
    final List<Section> sections = [];

    final map = Map<String, dynamic>.from(json["data"]);

    for (var section in map.entries) {
      sections.add(Section.fromJson(section.value, section.key));
    }
    return CourseSectionModel(sections: sections);
  }

  @override
  List<Object?> get props => [sections];
}

class Section extends Equatable {
  final String name;
  final bool isPass;
  final bool isActive;
  final bool withoutQuiz;
  final List<SectionRessourse> sectionRessourses;
  final SectionQuiz? quiz;

  const Section(
      {required this.name,
      required this.sectionRessourses,
      required this.withoutQuiz,
      required this.isPass,
      required this.isActive,
      this.quiz});

  factory Section.fromJson(Map<String, dynamic> json, String name) => Section(
      name: name,
      sectionRessourses: List<Map<String, dynamic>>.from(json["data"])
          .map((e) => SectionRessourse.fromJson(e))
          .toList(),
      withoutQuiz: json["withoutQuiz"],
      isPass: json["pass"],
      isActive: json["active"],
      quiz: SectionQuiz.fromJson(json["quiz"]));

  @override
  List<Object?> get props => [
        name,
        sectionRessourses,
        withoutQuiz,
        isPass,
        isActive,
      ];
}

//
//Quiz
class SectionQuiz extends Equatable {
  final int attempts;
  final double deductionPoints;
  final int seconds;
  final int endTime;
  final double points;
  final bool isPass;

  const SectionQuiz({
    required this.attempts,
    required this.deductionPoints,
    required this.seconds,
    required this.endTime,
    required this.points,
    required this.isPass,
  });

  factory SectionQuiz.fromJson(Map<String, dynamic> json) => SectionQuiz(
      attempts: json["attempts"],
      deductionPoints: json["deductionPoints"].toDouble(),
      seconds: json["seconds"],
      endTime: json["endTime"],
      points: json["points"].toDouble(),
      isPass: json["pass"]);

  Map<String, dynamic> toJson() => {
        "attempts": attempts,
        "deductionPoints": deductionPoints,
        "seconds": seconds,
        "endTime": endTime,
        "points": points,
        "pass": isPass,
      };

  @override
  List<Object?> get props => [
        attempts,
        deductionPoints,
        seconds,
        endTime,
        points,
        isPass,
      ];
}

class SectionRessourse extends Equatable {
  final String name;
  final String ext;
  final String link;

  const SectionRessourse({
    required this.name,
    required this.ext,
    required this.link,
  });

  factory SectionRessourse.fromJson(Map<String, dynamic> json) =>
      SectionRessourse(
          name: json["name"], ext: json["ext"], link: json["link"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "ext": ext,
        "link": link,
      };

  @override
  List<Object?> get props => [name, ext, link];
}
