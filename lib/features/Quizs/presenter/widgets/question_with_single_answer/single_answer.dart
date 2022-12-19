
import 'package:flutter/material.dart';

import '../../../../../ui/colors/app_colors.dart';

class SingleAnswer extends StatelessWidget {
  final String answer;
  final String selectedAnswer;
  final void Function(String) setAnswer;
  const SingleAnswer({
    Key? key,
    required this.answer,
    required this.setAnswer,
    required this.selectedAnswer,
  }) : super(key: key);

  bool get isAnswerSelected => answer == selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setAnswer(answer);
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
                      color: isAnswerSelected
                          ? AppColors.mainGreen
                          : AppColors.mainWhite.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    answer,
                    // overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: isAnswerSelected
                          ? AppColors.mainGreen
                          : AppColors.mainWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
