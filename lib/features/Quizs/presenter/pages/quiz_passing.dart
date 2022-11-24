import 'package:flutter/material.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

class QuizPassing extends StatefulWidget {
  const QuizPassing({super.key});

  @override
  State<QuizPassing> createState() => _QuizPassingState();
}

class _QuizPassingState extends State<QuizPassing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: AppColors.darkBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            QuestionMultipleAnswers(),
            const SizedBox(height: 20),
            QuestionMultipleAnswers(),
            const SizedBox(height: 20),
            QuestionMultipleAnswers(),
          ],
        ),
      ),
    );
  }
}

class QuestionMultipleAnswers extends StatefulWidget {
  const QuestionMultipleAnswers({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionMultipleAnswers> createState() =>
      _QuestionMultipleAnswersState();
}

class _QuestionMultipleAnswersState extends State<QuestionMultipleAnswers> {
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
              MultiAnswer(setAnswer: setAnswer, answerText: 'Answer 1', answers: answers,),
              const SizedBox(height: 10),
              MultiAnswer(setAnswer: setAnswer, answerText: 'Answer 2', answers: answers,)
            ],
          )
        ],
      ),
    );
  }
}

class MultiAnswer extends StatelessWidget {
  final void Function(String) setAnswer;
  final String answerText;
  final List<String> answers;
  const MultiAnswer({
    Key? key, required this.setAnswer, required this.answerText, required this.answers,
  }) : super(key: key);

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
                    color: AppColors.mainWhite.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  "$answers",
                  // overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.mainWhite,
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

class SingleAnswer extends StatelessWidget {
  const SingleAnswer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
                    color: AppColors.mainWhite.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  "This is a very very long long long answer wdhghjs db fubsdkjf dsfuhgs sdhsd sdfhdjflf",
                  // overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.mainWhite,
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

PreferredSize buildAppBar() {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 70),
    child: Container(
      color: AppColors.mainViolet,
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, right: 15, bottom: 10),
                  decoration: BoxDecoration(
                      color: AppColors.mainred.withOpacity(0.3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Text(
                    "End Quiz",
                    style: TextStyle(
                        color: AppColors.mainred, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            /////////////:
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "2/10",
                  style: TextStyle(
                      color: AppColors.mainWhite, fontWeight: FontWeight.w700),
                ),
                Text(
                  "answered",
                  style: TextStyle(color: AppColors.mainWhite.withOpacity(0.5)),
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: const Text(
                "4:56",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
