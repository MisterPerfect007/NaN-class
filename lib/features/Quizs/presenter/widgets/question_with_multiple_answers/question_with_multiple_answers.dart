
import 'package:flutter/material.dart';

import '../../../../../ui/colors/app_colors.dart';
import '../../../data/models/quiz_model.dart';

class QuestionWithMultipleAnswers extends StatefulWidget {
  final Question question;
  final void Function(List<String>, String) setQuestionAnswer;
  const QuestionWithMultipleAnswers({
    Key? key, required this.question, required this.setQuestionAnswer,
  }) : super(key: key);

  @override
  State<QuestionWithMultipleAnswers> createState() =>
      _QuestionWithMultipleAnswersState();
}

class _QuestionWithMultipleAnswersState extends State<QuestionWithMultipleAnswers> {
  List<String> answers = [];

  void setAnswer(String answer) {
    if (answers.contains(answer)) {
      setState(() {
        answers.remove(answer);
      });
    } else {
      setState(() {
        answers.add(answer);
      });
    }
    widget.setQuestionAnswer(answers, widget.question.question);
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
          Text(
            widget.question.question,
            style: const TextStyle(
              color: AppColors.mainWhite,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
             itemCount: widget.question.answers.length,
            itemBuilder:(context, index) {
              String answer = widget.question.answers[index];
              return MultiAnswer(setAnswer: setAnswer, answerText: answer, answers: answers,);
          },),
          /* Column(
            children: [
              //answer
              MultiAnswer(setAnswer: setAnswer, answerText: 'Answer 1', answers: answers,),
              const SizedBox(height: 10),
              MultiAnswer(setAnswer: setAnswer, answerText: 'Answer 2', answers: answers,)
            ],
          ) */
        ],
      ),
    );
  }
}


//
//

class MultiAnswer extends StatelessWidget {
  final void Function(String) setAnswer;
  final String answerText;
  final List<String> answers;
  const MultiAnswer({
    Key? key, required this.setAnswer, required this.answerText, required this.answers,
  }) : super(key: key);

  bool get isAnswerSelected => answers.contains(answerText);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setAnswer(answerText);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: AppColors.mainWhite.withOpacity(0.2),
          child: Row(
            children: [
              // const SizedBox(width: 20),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.mainWhite.withOpacity(0.5)),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                    child: isAnswerSelected? const Center(child: Icon(Icons.close, size: 15, color: AppColors.mainGreen,)) : Container(),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  "$answers",
                  // overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: isAnswerSelected? AppColors.mainGreen : AppColors.mainWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}