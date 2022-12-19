import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../data/models/quiz_model.dart';
import '../widgets/appBar/app_bar.dart';
import '../widgets/question_with_multiple_answers/question_with_multiple_answers.dart';
import '../widgets/question_with_single_answer/question_with_single_answer.dart';

class QuizPassing extends StatefulWidget {
  final QuizModel quiz;
  const QuizPassing({super.key, required this.quiz});

  @override
  State<QuizPassing> createState() => _QuizPassingState();
}

class _QuizPassingState extends State<QuizPassing> with WidgetsBindingObserver {
  late Timer timer;
  //
  Color color = AppColors.mainWhite;
  //
  late int quizTime;

  @override
  void initState() {
    super.initState();
    //
    quizTime = widget.quiz.time;
    //
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //

      //!! quizTime not null
      if (quizTime > 0) {
        setState(() {
          quizTime = quizTime - 1;
        });
      }
      //
      if (quizTime < 60) {
        setState(
          () {
            color = (color == AppColors.mainWhite)
                ? AppColors.mainred
                : AppColors.mainWhite;
          },
        );
      }
      //
      if (quizTime == 0) {
        timer.cancel();

        // print("Finishhhhhhhhhhhhhhhhhh");
      }
    });
    //
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer.cancel();
    super.dispose();
  }

  //
  //
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    /* AppLifecycleState.paused;
    AppLifecycleState.inactive;
    AppLifecycleState.resumed;
    AppLifecycleState.detached; */
    print("----------------------------------");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showToast("You can't go back");
        return false;
      },
      child: Scaffold(
        appBar: buildQuizPassingAppBar(quizTime: quizTime, color: color),
        backgroundColor: AppColors.darkBg,
        body: QuizLoadedWidget(quiz: widget.quiz),
      ),
    );
  }
}

class QuizLoadedWidget extends StatefulWidget {
  const QuizLoadedWidget({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final QuizModel quiz;

  @override
  State<QuizLoadedWidget> createState() => _QuizLoadedWidgetState();
}

class _QuizLoadedWidgetState extends State<QuizLoadedWidget> {
  List<Map<String, dynamic>> answers = [];
  //
  ///
  void setQuestionAnswer(List<String> answer, String question) {
    bool isAnswerSet = false;
    for (var el in answers) {
      if (el["question"] == question) {
        el["answers"] = answer;
        isAnswerSet = true;
      }
    }
    if (!isAnswerSet) {
      answers.add({"question": question, "answers": answer});
    }
    print(answers);
  }

  //
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //
    });
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    List<Question> questions = widget.quiz.questions;
    return CustomOpacityAnimation(
      duration: const Duration(seconds: 1),
      child: SizedBox(
        height: size.height,
        child: ListView.builder(
          cacheExtent: 9999,
          padding: const EdgeInsets.all(20),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            Question currentQuestion = questions[index];
            return currentQuestion.isMultiAnswer
                ? QuestionWithMultipleAnswers(
                    question: currentQuestion,
                    setQuestionAnswer: setQuestionAnswer,
                  )
                : QuestionWithSingleAnswers(
                    question: currentQuestion,
                    setQuestionAnswer: setQuestionAnswer,
                  );
          },
        ),
      ),
    );
  }
}

//
//
