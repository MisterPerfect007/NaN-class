import 'package:flutter/material.dart';

import '../features/Quizs/presenter/pages/quizs_list_page.dart';
import '../features/courses/presenter/pages/courses_page.dart';
import '../features/home/presenter/pages/home.dart';
import '../features/home/presenter/widgets/bottomNavigationBar/custtom_navigation_bar.dart';
import '../features/projects/presenter/pages/projects_page.dart';
import '../ui/colors/app_colors.dart';
import 'widgets/drawer.dart';

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
      drawer: const CustomDrawer(),
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