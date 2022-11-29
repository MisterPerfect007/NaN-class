import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/features/home/presenter/bloc/home_bloc.dart';
import 'package:nan_class/features/loginAndRegister/presenter/pages/login.dart';
import 'package:nan_class/features/loginAndRegister/utils/google_auth.dart';

import 'appRoot/root.dart';
import 'core/widgets/loaders/loading_page.dart';
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
        home: const LoginFlow()
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
          // BlocProvider<CourseBloc>(create: (context) => CourseBloc()),
        ],
        child: FutureBuilder<bool>(
          future: isUserLogedIn(), // if user is loged in
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
