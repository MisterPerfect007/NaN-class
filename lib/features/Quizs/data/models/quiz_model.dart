import 'package:equatable/equatable.dart';

class QuizModel extends Equatable {
  final String id;
  final String title;
  final List<Question> questions;
  final int percentOfValidation;
  final int points;
  final int time;
  const QuizModel({
    required this.id,
    required this.title,
    required this.questions,
    required this.percentOfValidation,
    required this.points,
    required this.time,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["_id"],
        title: json["title"],
        questions: List<Map<String, dynamic>>.from(json["questions"])
            .map((question) => Question.formJson(question))
            .toList(),
        percentOfValidation: json["percentOfValidation"] as int,
        points: json["points"] as int,
        time: json["time"] as int,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "questions": questions.map((e) => e.toJson()).toList(),
        "percentOfValidation": percentOfValidation,
        "points": points,
        "time": time
      };

  @override
  List<Object?> get props => [
        id,
        title,
        questions,
        percentOfValidation,
        points,
        time,
      ];
}

class Question extends Equatable {
  final String question;
  final List<String> answers;
  final bool isMultiAnswer;
  const Question({
    required this.question,
    required this.answers,
    required this.isMultiAnswer,
  });

  factory Question.formJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers: List<String>.from(json["responses"]),
        isMultiAnswer: json["manyResponses"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "responses": answers,
        "manyResponses": isMultiAnswer
      };

  @override
  List<Object?> get props => [
        question,
        answers,
        isMultiAnswer,
      ];
}
