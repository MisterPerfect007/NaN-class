import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nan_class/features/home/data/datasources/user_remote_data_source.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import '../../../../ui/svg_icons/svg_icons.dart';
import '../../../courses/data/datasources/courses_remote_data_source.dart';
import '../../../loginAndRegister/domain/entity.dart';
import '../../../loginAndRegister/utils/google_auth.dart';
import '../bloc/home_bloc.dart';
import '../widgets/bottomNavigationBar/custtom_navigation_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 41, 53, 1),
      appBar: buildAppBar(),
      body: HomeBody(size: size),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(26, 28, 52, 1),
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: SvgIcon(
            icon: SvgIcons.menuAltLeft,
            color: Colors.white,
          ),
        ),
        actions: [
          SvgPicture.asset(
            "assets/svg/bad-o.svg",
            color: Colors.white,
          )
        ]);
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with AutomaticKeepAliveClientMixin<HomeBody> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.read<HomeBloc>().add(const GetUser("116420318969971436809"));
    return SizedBox(
      height: widget.size.height,
      width: double.infinity,
      // padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
      child:BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }else if (state is HomeLoaded){
              return LoadedWidget(user: state.user,);
            }else if (state is HomeFailure){
              return Center(child: Text("${state.errorType}"),);
            }else{
              return const Text("Unexpected result");
            }
          },
        ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LoadedWidget extends StatelessWidget {
  final User user;
  const LoadedWidget({
    Key? key, required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(user.speciality?.id);
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: ()async {
                    final courses = await getCourcesRemoteDataSource("116420318969971436809");
                    courses.fold(
                      (l) => print(l), 
                      (r) => print("${r.first.month} = ${r.first.courses.first.toJson()}"), 
                      );
                  },
                  child: Text(
                    "Hello, ",
                    style: TextStyle(
                        fontSize: 18, color: Colors.white.withOpacity(0.6)),
                  ),
                ),
                Text(
                  user.login ?? '',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Specialisty: ",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white.withOpacity(0.6)),
                ),
                Text(
                  user.speciality?.name ?? '',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 15),
            StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                PointCard(name: 'Courses points', points: user.coursesPoints ?? 0,),
                PointCard(name: 'Projecst points', points: user.projectsPoints ?? 0,),
                PointCard(name: 'Rating points', points: user.ratingsPoints ?? 0,),
                PointCard(name: 'Total points', points: computeTotalPoints(), color: AppColors.mainGreen,),
              ],
            )
          ],
        ),
      ),
    );
  }
  ///add [user.coursesPoints] + [user.projectsPoints] + [user.ratingsPoints]
  ///
  double computeTotalPoints(){
    return (user.coursesPoints ?? 0) + (user.projectsPoints ?? 0) + (user.ratingsPoints ?? 0);
  }
}

class PointCard extends StatelessWidget {
  final String name;
  final double points;
  final Color? color;
  const PointCard({
    Key? key, required this.name, required this.points, this.color = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            '$points',
            style: TextStyle(
                fontSize: 60, color: color ?? Colors.white, fontWeight: FontWeight.w800),
          ),
          Container()
        ],
      ),
    );
  }
}
