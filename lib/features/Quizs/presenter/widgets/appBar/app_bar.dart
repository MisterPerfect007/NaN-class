import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../ui/colors/app_colors.dart';

PreferredSize buildQuizPassingAppBar({required int? quizTime, required Color color}) {

  return PreferredSize(
    preferredSize: const Size(double.infinity, 60),
    child: Container(
      color: AppColors.mainViolet,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SafeArea(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  quizTime != null ? formatTimeMMSS(quizTime) : '00:00',
                  style:
                      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w500),
                ),
              ),
            ), 
            /////////////:
            Expanded(child: Container()),
            /* Column(
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
            ), */
            // Expanded(child: Container()),
            
            //
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  /* padding: const EdgeInsets.only(
                      left: 15, top: 10, right: 15, bottom: 10), */
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.mainGreen.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Text(
                      "End Quiz",
                      style: TextStyle(
                          color: AppColors.mainGreen,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) ,
      ),
    ),
  );
}
