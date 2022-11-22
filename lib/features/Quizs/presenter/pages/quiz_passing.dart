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
            QuestionAndAnswers(),
            const SizedBox(height: 20),
            QuestionAndAnswers(),
            const SizedBox(height: 20),
            QuestionAndAnswers(),
          ],
        ),
      ),
    );
  }
}

class QuestionAndAnswers extends StatelessWidget {
  const QuestionAndAnswers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
      color: AppColors.mainViolet,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
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
              Container(
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
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20))),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Answer 1",
                      style: TextStyle(
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
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
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20))),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Answer 1",
                      style: TextStyle(
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
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
