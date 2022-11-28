
import 'package:flutter/material.dart';
import 'package:nan_class/features/Quizs/presenter/widgets/question_with_single_answer/single_answer.dart';

import '../../../../../ui/colors/app_colors.dart';

class QuestionWithSingleAnswers extends StatefulWidget {
  const QuestionWithSingleAnswers({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWithSingleAnswers> createState() =>
      _QuestionWithSingleAnswersState();
}

class _QuestionWithSingleAnswersState extends State<QuestionWithSingleAnswers> {
  String selectedAnswer = "";

  void setAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.mainViolet,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "1. What's Flutter this is the question What's Flutter this is the question What's Flutter this is the question",
            style: TextStyle(
              color: AppColors.mainWhite,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              //answer
              SingleAnswer(
                answer: "answer 1",
                setAnswer: setAnswer,
                selectedAnswer: selectedAnswer,
              ),
              const SizedBox(height: 10),
              SingleAnswer(
                answer: "answer 2",
                setAnswer: setAnswer,
                selectedAnswer: selectedAnswer,
              ),
            ],
          )
        ],
      ),
    );
  }
}
