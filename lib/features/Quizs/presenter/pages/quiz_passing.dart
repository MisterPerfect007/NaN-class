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
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Container(
          color: AppColors.mainViolet,
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Row(
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
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: const Text(
                        "End Quiz",
                        style: TextStyle(
                            color: AppColors.mainred,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                /////////////:
                Column(
                  children: [
                    // Text
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
