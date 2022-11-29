import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/alertDialog/custom_alert_dialog.dart';
import '../../../home/presenter/widgets/app_bar.dart';
import '../widgets/appBar/app_bar.dart';
import '../widgets/question_with_multiple_answers/question_with_multiple_answers.dart';
import '../widgets/question_with_single_answer/question_with_single_answer.dart';

class QuizPassing extends StatefulWidget {
  const QuizPassing({super.key});

  @override
  State<QuizPassing> createState() => _QuizPassingState();
}

class _QuizPassingState extends State<QuizPassing> {
  //
  Color color = AppColors.mainWhite;

  //if user is ready to take the quiz
  bool isUserReady = false;

  ///set [isUserReady] to true and start
  void setUserReady() {
    setState(() {
      isUserReady = true;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      //
      if (quizTime > 0) {
        setState(() {
          quizTime -= 1;
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

        print("Finishhhhhhhhhhhhhhhhhh");
        showCustomDialog(
          context,
          icon: Icons.close,
          topColor: AppColors.mainred,
          barrierColor: AppColors.darkBg,
          bodyText: 'Are you ready',
          title: 'Are you ready',
          onBtnTap: () {},
        );
      }
    });
  }

  ///Quiz time
  int quizTime = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showCustomDialog(
          context,
          icon: Icons.close,
          topColor: AppColors.mainred,
          barrierColor: AppColors.darkBg,
          bodyText: 'Are you ready',
          title: 'Are you ready',
          onBtnTap: () {
            setUserReady();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // show visible if user is ready by confirming in the dialog
      visible: isUserReady,
      child: Scaffold(
        appBar: buildQuizPassingAppBar(quizTime: quizTime, color: color),
        backgroundColor: AppColors.darkBg,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              QuestionWithMultipleAnswers(),
              const SizedBox(height: 20),
              QuestionWithMultipleAnswers(),
              const SizedBox(height: 20),
              QuestionWithMultipleAnswers(),
              const SizedBox(height: 20),
              QuestionWithSingleAnswers(),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
