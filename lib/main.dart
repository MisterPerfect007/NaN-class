import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/features/Quizs/presenter/pages/quiz_passing.dart';
import 'package:nan_class/features/courses/data/models/courses_model.dart';
import 'package:nan_class/features/courses/presenter/pages/course_page.dart';
import 'package:nan_class/features/home/presenter/bloc/home_bloc.dart';

import 'appRoot/root.dart';
import 'features/courses/data/datasources/course_remote_data_source.dart';
import 'features/courses/presenter/bloc/course/course_bloc.dart';
import 'features/courses/presenter/bloc/courses/courses_bloc.dart';

void main() async {
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
            // BlocProvider<CourseBloc>(create: (context) => CourseBloc()),
          ],
          child: const Root(),
        ));
  }
}
