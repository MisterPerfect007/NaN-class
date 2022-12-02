import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/features/Quizs/presenter/pages/quiz_passing.dart';
import 'package:nan_class/features/home/presenter/bloc/home_bloc.dart';
import 'package:nan_class/features/loginAndRegister/presenter/pages/login.dart';
import 'package:nan_class/features/loginAndRegister/utils/google_auth.dart';

import 'appRoot/root.dart';
import 'core/widgets/loaders/loading_page.dart';
import 'features/Quizs/data/dataSourses/quiz_remote_data_source.dart';
import 'features/Quizs/presenter/bloc/quiz_bloc.dart';
import 'features/courses/presenter/bloc/courses/courses_bloc.dart';

void main() async {
  runApp(const MyApp());
  // print(await getQuizRemoteDataSource(courseName: '1-cours-one-maining', sectionName: 'Introduction'));
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
        home: const LoginFlow(),
        // const Login(),
        );
  }
}

class LoginFlow extends StatelessWidget {
  const LoginFlow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
          BlocProvider<CoursesBloc>(create: (context) => CoursesBloc()),
          BlocProvider<QuizBloc>(create: (context) => QuizBloc(),),
          
          // BlocProvider<CourseBloc>(create: (context) => CourseBloc()),
        ],
        child: FutureBuilder<bool>(
          future: isUserLogedIn(), // if user is loged in or not
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                if (snapshot.data!) {
                  
                  return const Root();
                } else {
                  return const Login();
                }
              }
            }
            return const LoadingPage();
          },
        ));
  }
}
