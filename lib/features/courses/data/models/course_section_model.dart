import 'package:equatable/equatable.dart';

class CourseSectionModel extends Equatable {
  // final Section section;
  // const CourseSectionModel();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Section extends Equatable {
  final String name;
  final String? ext;
  final String? link;
  final bool isPass;
  final bool isActive;

  const Section({
    required this.name,
    this.ext,
    this.link,
    required this.isPass,
    required this.isActive,
  });

  @override
  List<Object?> get props => [name, ext];
}
/* 
{
  "status": true,
  "data": {
    "1-section one": {
      "data": [
        {
          "name": "video.mp4",
          "ext": ".mp4",
          "link": "FLUTTER/FR->matrisier_flutter_Oct_Nov/1-section_+one/video.mp4",
          "subtitles": [],
          "size": 0
        }
      ],
      "withoutQuiz": false,
      "active": true,
      "pass": false,
      "quiz": {
        "attempts": 2,
        "deductionPoints": 0,
        "seconds": 0,
        "endTime": 334567,
        "points": 3,
        "pass": false,
        "responses": {
          "C quoi Flutter": "Framework",
          "architecture en flutter": [
            "mvn",
            "mvc"
          ]
        }
      }
    },
    "2-section-two": {
      "data": [
        {
          "name": "video2.mp4",
          "ext": ".mp4",
          "link": "FLUTTER/FR->matrisier_flutter_Oct_Nov/2-section-two/video2.mp4",
          "subtitles": [],
          "size": 0
        }
      ],
      "withoutQuiz": false,
      "active": false,
      "pass": false,
      "quiz": {
        "attempts": 2,
        "deductionPoints": 0,
        "seconds": 0,
        "endTime": 334567,
        "points": 3,
        "pass": false,
        "responses": {
          "C quoi Flutter": "Framework",
          "architecture en flutter": [
            "mvn",
            "mvc"
          ]
        }
      }
    }
  }
}
 */