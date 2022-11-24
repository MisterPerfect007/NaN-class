import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/widgets/default_app_bar.dart';
import 'package:nan_class/features/courses/presenter/bloc/course/course_bloc.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

import '../../data/models/course_section_model.dart';
import '../../data/models/courses_model.dart';

class CoursePage extends StatefulWidget {
  final MonthCourse monthCourse;
  const CoursePage({super.key, required this.monthCourse});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  //
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    context.read<CourseBloc>().add(GetCourseSections(
          googleUserId: "116420318969971436809",
          courseName: widget.monthCourse.name,
          months: widget.monthCourse.months ?? [],
          language: widget.monthCourse.language,
          speciality: "FLUTTER",
        ));

    return Scaffold(
      appBar: defautAppBar(widget.monthCourse.name),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: AppColors.darkBg,
        child: const MainWidget(),
      ),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is CourseLoaded) {
          //
          final List<Section> allSections = state.courseSections.sections;
          return SizedBox(
            height: height,
            //
            //build the sections 
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: allSections.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SectionWidget(
                      section: allSections[index],
                    ),
                  ],
                );
              },
            ),
          );
        }
        return Center(
          child: Text("$state"),
        );
      },
    );
  }
}

class SectionWidget extends StatelessWidget {
  final Section section;

  const SectionWidget({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    bool canUserPassTakeQuiz =
        section.withoutQuiz ? false : (section.isActive && !section.isPass);
    //

    return Column(
      children: [
        Container(
          color: AppColors.mainViolet,
          child: ExpansionTile(
            collapsedIconColor: AppColors.mainWhite,
            title: Text(
              section.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            children: [
              SectionRessourceWidget(
                ressourseList: section.sectionRessourses,
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        //
        //
        if (canUserPassTakeQuiz)
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

class SectionRessourceWidget extends StatelessWidget {
  final List<SectionRessourse> ressourseList;
  const SectionRessourceWidget({
    Key? key,
    required this.ressourseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Column(
        children: ressourseList.map((ressource) {
      //
      bool isVideo = ressource.ext == ".mp4";
      final icon = isVideo ? SvgIcons.baselineVideoFile : SvgIcons.filePresent;
      final iconColor = isVideo ? Colors.red.shade300 : Colors.blue;
      //
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            color: AppColors.mainWhite.withOpacity(0.2),
            width: double.infinity,
            // height: 30,
            child: Row(
              children: [
                SvgIcon(icon: icon, color: iconColor),
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    ressource.name,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: AppColors.mainWhite.withOpacity(0.7)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const SvgIcon(
                    icon: SvgIcons.chevronRight, color: AppColors.mainWhite),
              ],
            ),
          ),
        ),
      );
    }).toList());
  }
}
