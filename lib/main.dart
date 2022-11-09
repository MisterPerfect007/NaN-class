import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/features/Quizs/presenter/pages/quizs_list_page.dart';
import 'package:nan_class/features/home/presenter/bloc/home_bloc.dart';
import 'package:nan_class/features/home/presenter/pages/home.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import 'features/courses/presenter/bloc/courses_bloc.dart';
import 'features/courses/presenter/pages/courses_page.dart';
import 'features/home/presenter/widgets/bottomNavigationBar/custtom_navigation_bar.dart';
import 'features/loginAndRegister/presenter/pages/login.dart';

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
        child: const Root(),)
      
    );
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
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn);
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
      backgroundColor: AppColors.darkBg,
      body: PageView(
        controller: pageController,
        onPageChanged: changeIndex,
        padEnds: false,
        physics: const BouncingScrollPhysics(),
        children: const [Home(), CoursesPage(), QuizsListPage()],
      ),
      bottomNavigationBar: CustomNavigationBar(
        changeIndex: changeIndex,
        currentIndex: currentIndex,
      ),
    );
  }
}
