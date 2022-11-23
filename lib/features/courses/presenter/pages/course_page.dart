import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nan_class/core/widgets/default_app_bar.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

import '../../data/models/courses_model.dart';

class CoursePage extends StatelessWidget {
  final MonthCourse monthCourse;
  const CoursePage({super.key, required this.monthCourse});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: defautAppBar(monthCourse.name ?? ""),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: AppColors.darkBg,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                CourseCard(),
                CourseCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
              color: AppColors.mainViolet,
            ),
            child: ExpansionTile(
              collapsedIconColor: AppColors.mainWhite,
              title: const Text(
                "Section title Section title Section title Section title Section title",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.mainWhite.withOpacity(0.3),
                      width: double.infinity,
                      // height: 30,
                      child: Row(
                        children: [
                          SvgIcon(
                              icon: SvgIcons.baselineVideoFile,
                              color: Colors.red.shade300),
                          const SizedBox(
                            width: 10,
                          ),
                          const SvgIcon(
                            icon: SvgIcons.filePresent,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "File name File name File name File name File name File name vFile name",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.mainWhite.withOpacity(0.7)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SvgIcon(
                              icon: SvgIcons.chevronRight,
                              color: AppColors.mainWhite),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
        const SizedBox(height: 5),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            // splashColor: Colors.red,
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 15),
                SvgIcon(
                  icon: SvgIcons.roundSubdirectoryArrowRight,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  "Take Quiz",
                  style: TextStyle(
                    color: AppColors.mainGreen,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}


/* 
Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              // radius: 5,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              splashColor: Colors.white.withOpacity(0.2),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "1 - Tilte ksbdfkjb bflljfqkjsjqjbjqsfk Tilte ksbdfkjb bflljfqkjsjqjbjqsfk",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/video-file.svg",
                                    width: 15,
                                  ),
                                  const Text(
                                    "1",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/document.svg",
                                    width: 15,
                                  ),
                                  const Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SvgIcon(
                      icon: SvgIcons.circleChevronRight,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
 */