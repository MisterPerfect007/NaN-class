import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import '../../../../ui/svg_icons/svg_icons.dart';
import '../../../loginAndRegister/domain/entity.dart';
import '../bloc/home_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 41, 53, 1),
      appBar: buildAppBar(context),
      body: HomeBody(size: size),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(26, 28, 52, 1),
        leading: InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: SvgIcon(
              icon: SvgIcons.menuAltLeft,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl:
                        state.user.avatar ?? "",
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    // errorWidget: (context, url, error) => ,
                    fadeOutDuration: const Duration(milliseconds: 300),
                    fadeInDuration: const Duration(milliseconds: 300),
                  ),
                ),
              );
            }
            return Container();
          }),
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

class _HomeBodyState extends State<HomeBody>
    with AutomaticKeepAliveClientMixin<HomeBody> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.read<HomeBloc>().add(const GetUser("116420318969971436809"));
    return SizedBox(
      height: widget.size.height,
      width: double.infinity,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // print(state);
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return LoadedWidget(
              user: state.user,
            );
          } else if (state is HomeFailure) {
            return Center(
              child: Text("${state.errorType}"),
            );
          } else {
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
    Key? key,
    required this.user,
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
                Text(
                  "Hello, ",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white.withOpacity(0.6)),
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
                PointCard(
                  name: 'Courses points',
                  points: user.coursesPoints ?? 0,
                ),
                PointCard(
                  name: 'Projecst points',
                  points: user.projectsPoints ?? 0,
                ),
                PointCard(
                  name: 'Rating points',
                  points: user.ratingsPoints ?? 0,
                ),
                PointCard(
                  name: 'Total points',
                  points: computeTotalPoints(),
                  color: AppColors.mainGreen,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///add [user.coursesPoints] + [user.projectsPoints] + [user.ratingsPoints]
  ///
  double computeTotalPoints() {
    return (user.coursesPoints ?? 0) +
        (user.projectsPoints ?? 0) +
        (user.ratingsPoints ?? 0);
  }
}

class PointCard extends StatelessWidget {
  final String name;
  final double points;
  final Color? color;
  const PointCard(
      {Key? key,
      required this.name,
      required this.points,
      this.color = Colors.white})
      : super(key: key);

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
                fontSize: 60,
                color: color ?? Colors.white,
                fontWeight: FontWeight.w800),
          ),
          Container()
        ],
      ),
    );
  }
}
