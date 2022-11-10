import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nan_class/core/widgets/default_app_bar.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defautAppBar(
          "1. Bien utiliser son Mac avec Mr ramjzljle ekekrkez [EN]"),
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
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Material(
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
        ),
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
