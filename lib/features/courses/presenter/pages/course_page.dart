import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/constants/constants.dart';
import 'package:nan_class/core/widgets/default_app_bar.dart';
import 'package:nan_class/core/widgets/loading_widget.dart';
import 'package:nan_class/features/Quizs/presenter/bloc/quiz_bloc.dart';
import 'package:nan_class/features/Quizs/presenter/pages/quiz_passing.dart';
import 'package:nan_class/features/courses/presenter/bloc/course/course_bloc.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

import '../../../../core/package/internet_connection_checker.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../core/widgets/error/error_widget.dart';
import '../../../videoPlayer/video_player.dart';
import '../../data/datasources/course_remote_data_source.dart';
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
    callCourseSections(context,
        courseName: widget.monthCourse.name,
        months: widget.monthCourse.months ?? [],
        language: widget.monthCourse.language,
        forr: widget.monthCourse.forr);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print(widget.monthCourse.name);
    return Scaffold(
      appBar: defautAppBar(widget.monthCourse.name),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: AppColors.darkBg,
        child: MainWidget(
          monthCourse: widget.monthCourse,
        ),
      ),
    );
  }
}

class MainWidget extends StatelessWidget {
  final MonthCourse monthCourse;
  const MainWidget({
    Key? key,
    required this.monthCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is CourseLoaded) {
          //
          final List<Section> allSections = state.courseSections.sections;
          //
          return CustomOpacityAnimation(
            child: SizedBox(
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
                        courseName: monthCourse.name,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        } else if (state is CourseLoading || state is CourseInitial) {
          // loading
          return const LoaderWidget();
        } else if (state is CourseFailed) {
          if (state.failure.error == SectionErrorType.noInternet) {
            return CustomErrorWidget(
              icon: SvgIcons.noWifiLine,
              onPressed: () async {
                if (!(await InternetConnection.hasConnection)) {
                  showToast("you still offline");
                } else {
                  callCourseSections(context,
                      courseName: monthCourse.name,
                      months: monthCourse.months ?? [],
                      language: monthCourse.language,
                      forr: monthCourse.forr);
                }
              },
              msg: "No internet",
            );
          }
        }
        return CustomErrorWidget(
          icon: SvgIcons.badO,
          onPressed: () {
            callCourseSections(context,
                courseName: monthCourse.name,
                months: monthCourse.months ?? [],
                language: monthCourse.language,
                forr: monthCourse.forr);
          },
          msg: "Something went wrong",
        );
      },
    );
  }
}

///Trigger the [GetCourseSections]
void callCourseSections(
  BuildContext context, {
  required String courseName,
  required List<String> months,
  String? language,
  String? forr,
}) {
  context.read<CourseBloc>().add(GetCourseSections(
        forr: forr,
        courseName: courseName,
        months: months,
        language: language,
      ));
}

class SectionWidget extends StatelessWidget {
  final String courseName;
  final Section section;

  const SectionWidget({
    Key? key,
    required this.section,
    required this.courseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    bool canUserPassTakeQuiz =
        section.withoutQuiz ? false : (section.isActive && !section.isPass);
    //
    bool isActive = section.isActive;

    return Column(
      children: [
        Container(
          color: isActive ? AppColors.mainViolet : AppColors.grey_1,
          child: IgnorePointer(
            ignoring: !isActive,
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
        ),
        const SizedBox(height: 5),
        //
        //
        if (canUserPassTakeQuiz)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => QuizBloc(),
                      child: QuizPassing(
                        courseName: courseName,
                        sectionName: section.name,
                      ),
                    ),
                  ),
                );
              },
              child: Row(
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
    // print(apiBaseUrl + ressourseList.first.link);
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
          onTap: () {
            print(apiBaseUrl + ressource.link);
            //
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(
                        videoLink: apiBaseUrl + ressource.link,
                      )),
            );

            //! Go to videoPlayer if it is a video
          },
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
