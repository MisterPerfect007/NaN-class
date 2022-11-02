import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../ui/svg_icons/svg_icons.dart';
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

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: double.infinity,
      // padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
      child: SingleChildScrollView(
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
                    "MisterPerfect007",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
                    "Flutter",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 15),
              StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  PointCard(),
                  PointCard(),
                  PointCard(),
                  PointCard(),
                  PointCard(),
                  PointCard(),
                  PointCard(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PointCard extends StatelessWidget {
  const PointCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Courses points",
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "22.5",
            style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.w800),
          ),
          Container()
        ],
      ),
    );
  }
}
