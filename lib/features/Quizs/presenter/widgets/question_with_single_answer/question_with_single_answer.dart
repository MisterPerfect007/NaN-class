import 'package:flutter/material.dart';
import 'package:nan_class/features/Quizs/presenter/widgets/question_with_single_answer/single_answer.dart';

import '../../../../../ui/colors/app_colors.dart';
import '../../../data/models/quiz_model.dart';

class QuestionWithSingleAnswers extends StatefulWidget {
  final Question question;
  const QuestionWithSingleAnswers({
    Key? key,
    required this.question,
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
    //
    Question question = widget.question;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.mainViolet,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            question.question,
            style: const TextStyle(
              color: AppColors.mainWhite,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: List<Widget>.generate(
                question.answers.length,
                (index) => SingleAnswer(
                    answer: question.answers[index],
                    setAnswer: setAnswer,
                    selectedAnswer: selectedAnswer)),
          ),

        ],
      ),
    );
  }
}
