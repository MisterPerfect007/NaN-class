import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nan_class/features/courses/domain/courses_entity.dart';
import 'package:nan_class/features/courses/presenter/bloc/course/course_bloc.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

import '../../../../core/package/internet_connection_checker.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/error/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../data/datasources/courses_remote_data_source.dart';
import '../bloc/courses/courses_bloc.dart';
import 'course_page.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
    with AutomaticKeepAliveClientMixin<CoursesPage> {
  //
  @override
  void initState() {
    super.initState();
    callCourses(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: defautAppBar("Available courses"),
      body: Container(
        width: size.width,
        height: size.height,
        color: AppColors.darkBg,
        child: SizedBox(
          child: BlocBuilder<CoursesBloc, CoursesState>(
            builder: (context, state) {
              if (state is CoursesInitial || state is CoursesLoading) {
                return const LoaderWidget();
              } else if (state is CoursesLoaded) {
                return CoursesLoadedWidget(courses: state.courses);
              } else if (state is CoursesFailed) {
                if (state.errorType == CourseErrorType.noInternet) {
                  return CustomErrorWidget(
                    icon: SvgIcons.noWifiLine,
                    onPressed: () async {
                      if (!(await InternetConnection.hasConnection)) {
                        showToast("you still offline");
                      } else {
                        callCourses(context);
                      }
                    },
                    msg: "No internet",
                  );
                } else {
                  return CustomErrorWidget(
                    icon: SvgIcons.badO,
                    onPressed: () {
                      callCourses(context);
                    },
                    msg: "Something went wrong",
                  );
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

///Trigger the [GetCourses] event
///
void callCourses(BuildContext context) {
  context.read<CoursesBloc>().add(const GetCourses("116420318969971436809"));
}

class CoursesLoadedWidget extends StatelessWidget {
  const CoursesLoadedWidget({
    Key? key,
    required this.courses,
  }) : super(key: key);

  final List<Courses> courses;

  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    //
    return SizedBox(
      height: size.height,
      child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return CourseExpansionTile(course: courses[index]);
          }),
    );
  }
}

class CourseExpansionTile extends StatelessWidget {
  const CourseExpansionTile({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Courses course;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
              color: AppColors.mainViolet,
              child: ExpansionTile(
                title: Text(
                  course.month ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
                collapsedIconColor: Colors.white,
                leading: SvgPicture.asset("assets/app/content/closed-book.svg",
                    width: 30),
                children: List<Widget>.from(
                    course.courses.map((monthCourse) => ListTile(
                          title: Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                                create: (context) =>
                                                    CourseBloc(),
                                                child: CoursePage(
                                                  monthCourse: monthCourse,
                                                ),
                                              )));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 5, top: 10, bottom: 10),
                                  color: Colors.white.withOpacity(0.1),
                                  child: Row(
                                    children: [
                                      //langage && name && number of sections
                                      Expanded(
                                          child: Text(
                                        (monthCourse.language != null
                                                ? "[${monthCourse.language}] "
                                                : "") +
                                            (monthCourse.name),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      Text(
                                        "[${monthCourse.sections} sections]",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const SvgIcon(
                                        icon: SvgIcons.chevronRight,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))),
              ))
        ],
      ),
    );
  }
}
