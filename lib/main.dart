import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/features/Quizs/presenter/pages/quiz_passing.dart';
import 'package:nan_class/features/Quizs/presenter/pages/quizs_list_page.dart';
import 'package:nan_class/features/home/presenter/bloc/home_bloc.dart';
import 'package:nan_class/features/home/presenter/pages/home.dart';
import 'package:nan_class/features/projects/presenter/pages/projects_page.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

import 'features/courses/presenter/bloc/courses_bloc.dart';
import 'features/courses/presenter/pages/courses_page.dart';
import 'features/home/presenter/widgets/bottomNavigationBar/custtom_navigation_bar.dart';
import 'features/loginAndRegister/presenter/pages/login.dart';
import 'features/videoPlayer/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
            BlocProvider<CoursesBloc>(create: (context) => CoursesBloc()),
          ],
          child: const QuizPassing(),
        ));
  }
}

class Root extends StatefulWidget {
  const Root({
    Key? key,
  }) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController pageController;

  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: AppColors.darkBg,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) => onPageChanged(index),
        padEnds: false,
        physics: const BouncingScrollPhysics(),
        children: const [
          Home(),
          CoursesPage(),
          QuizsListPage(),
          ProjectsPage()
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        changeIndex: changeIndex,
        currentIndex: currentIndex,
      ),
    );
  }
}

class Drawer extends StatelessWidget {
  const Drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.darkBg,
      width: size.width * 0.8,
      height: size.height,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //!Header
              Container(
                  color: AppColors.mainViolet,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Parfait Tapsoba",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: const [
                    SizedBox(height: 20),
                    DrawerItem(
                      text: "Week challenges",
                      icon: SvgIcons.calendarWeek,
                    ),
                    SizedBox(height: 20),
                    DrawerItem(
                      text: "My Ranking",
                      icon: SvgIcons.rankingStar,
                    ),
                    SizedBox(height: 20),
                    DrawerItem(
                      text: "My Calendar & Meets ",
                      icon: SvgIcons.calendar,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final SvgIcons icon;
  const DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgIcon(
          icon: icon,
          color: AppColors.mainWhite,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.mainWhite),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
