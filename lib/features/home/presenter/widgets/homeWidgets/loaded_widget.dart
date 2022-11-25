
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../ui/colors/app_colors.dart';
import '../../../../loginAndRegister/domain/entity.dart';

import 'point_card.dart';

class LoadedWidget extends StatelessWidget {
  final User user;
  const LoadedWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(user.speciality?.id);
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hello, 👋 ",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white.withOpacity(0.6)),
                ),
                Text(
                  user.login ?? '',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Specialisty: ",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white.withOpacity(0.6)),
                ),
                Text(
                  user.speciality?.name ?? '',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 15),
            StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                PointCard(
                  name: 'Courses points',
                  points: user.coursesPoints ?? 0,
                ),
                PointCard(
                  name: 'Project points',
                  points: user.projectsPoints ?? 0,
                ),
                PointCard(
                  name: 'Rating points',
                  points: user.ratingsPoints ?? 0,
                ),
                PointCard(
                  name: 'Total points',
                  points: computeTotalPoints(),
                  color: AppColors.mainGreen,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///add [user.coursesPoints] + [user.projectsPoints] + [user.ratingsPoints]
  ///
  double computeTotalPoints() {
    return (user.coursesPoints ?? 0) +
        (user.projectsPoints ?? 0) +
        (user.ratingsPoints ?? 0);
  }
}