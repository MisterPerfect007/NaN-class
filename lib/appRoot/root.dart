import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/widgets/error/error_page.dart';
import 'package:nan_class/core/widgets/loaders/loading_page.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

import '../core/failure/failures.dart';
import '../core/widgets/animation/custom_opacity_animation.dart';
import '../features/Quizs/presenter/pages/quizs_list_page.dart';
import '../features/courses/presenter/pages/courses_page.dart';
import '../features/home/presenter/bloc/home_bloc.dart';
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
    triggerGetUser();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          //* Main scaffold holding the bottomNavigationBar and his navigation staff
          return Scaffold(
            drawer: CustomDrawer(
              user: state.user,
            ),
            backgroundColor: AppColors.darkBg,
            body: CustomOpacityAnimation(
              child: PageView(
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
            ),
            bottomNavigationBar: CustomNavigationBar(
              changeIndex: changeIndex,
              currentIndex: currentIndex,
            ),
          );
        } else if (state is HomeLoading) {
          return const LoadingPage();
        }else if (state is HomeFailure){
          if (state.errorType == UserErrorType.noUserFound) {
           return ErrorPage(msg: "No user found", icon: SvgIcons.userBlock, onPressed: (){triggerGetUser();},);
          }else{
            return ErrorPage(msg: "Something went wrong", icon: SvgIcons.badO, onPressed: (){triggerGetUser();},);
          }
        }
        return ErrorPage(msg: "Something went wrong", icon: SvgIcons.badO, onPressed: (){triggerGetUser();},);
      },
    );
  }

  void triggerGetUser(){
    context.read<HomeBloc>().add(const GetUser());
  }
}
