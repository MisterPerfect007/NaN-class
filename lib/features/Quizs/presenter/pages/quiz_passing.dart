import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/features/Quizs/presenter/bloc/quiz_bloc.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/alertDialog/custom_alert_dialog.dart';
import '../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../home/presenter/widgets/app_bar.dart';
import '../../data/models/quiz_model.dart';
import '../widgets/appBar/app_bar.dart';
import '../widgets/question_with_multiple_answers/question_with_multiple_answers.dart';
import '../widgets/question_with_single_answer/question_with_single_answer.dart';

class QuizPassing extends StatefulWidget {
  final String courseName;
  final String sectionName;
  const QuizPassing(
      {super.key, required this.courseName, required this.sectionName});

  @override
  State<QuizPassing> createState() => _QuizPassingState();
}

class _QuizPassingState extends State<QuizPassing> {
  late Timer timer;
  //
  Color color = AppColors.mainWhite;

  //if user is ready to take the quiz
  bool isUserReady = false;

  ///set [isUserReady] to true and start timer
  void setUserReady(int quizTimeToSet){

    setState(() {
      isUserReady = true;
      quizTime = quizTimeToSet;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //
      if (quizTime != null) {
        //!! quizTime not null
        if (quizTime! > 0) {
          setState(() {
            quizTime = quizTime! - 1;
          });
        }
        //
        if (quizTime! < 60) {
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
        }
      }
    });
  }

  ///Quiz time
  int? quizTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //! to be moved
      if (context.read<QuizBloc>().state is! QuizLoaded) {
        context.read<QuizBloc>().add(GetQuiz(
              courseName: widget.courseName,
              sectionName: widget.sectionName,
            ));
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // show visible if user is ready by confirming in the dialog
      visible: true,
      child: Scaffold(
        appBar: buildQuizPassingAppBar(quizTime: quizTime, color: color),
        backgroundColor: AppColors.darkBg,
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            // print(state);
            if (state is QuizLoading || state is QuizInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is QuizLoaded) {

              return QuizLoadedWidget(quiz: state.quiz, setUserReady:  setUserReady,);
            }
            return Container();
            // showDialog(context: context, builder: builder);
          },
        ),
      ),
    );
  }
}

class QuizLoadedWidget extends StatefulWidget {
  final Function(int) setUserReady;
  const QuizLoadedWidget({
    Key? key,
    required this.quiz, required this.setUserReady,
  }) : super(key: key);

  final QuizModel quiz;

  @override
  State<QuizLoadedWidget> createState() => _QuizLoadedWidgetState();
}

class _QuizLoadedWidgetState extends State<QuizLoadedWidget> {
  //
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //
      showCustomDialog(
        context,
        icon: Icons.close,
        topColor: AppColors.mainred,
        barrierColor: AppColors.darkBg,
        bodyText: 'Are you ready',
        title: 'Are you ready',
        onBtnTap: () {
          Navigator.pop(context);
          widget.setUserReady(widget.quiz.time);
        },
      );
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
          padding: const EdgeInsets.all(20),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            Question currentQuestion = questions[index];
            return currentQuestion.isMultiAnswer
                ? QuestionWithMultipleAnswers(
                    question: currentQuestion,
                  )
                : QuestionWithSingleAnswers(
                    question: currentQuestion,
                  );
          },
        ),
      ),
    );
  }
}

//
//
