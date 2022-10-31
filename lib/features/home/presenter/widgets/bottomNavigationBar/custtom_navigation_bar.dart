
import 'package:flutter/material.dart';

import '../../../../../ui/svg_icons/svg_icons.dart';
import 'navigation_bar_item.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color.fromRGBO(26, 28, 52, 1),
      // padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationBarItem(
            icon: SvgIcons.homeAlt,
            text: 'Home',
            changeIndex: changeIndex,
            index: 0,
            currentIndex: currentIndex,
          ),
          NavigationBarItem(
            icon: SvgIcons.course,
            text: 'Courses',
            changeIndex: changeIndex,
            index: 1,
            currentIndex: currentIndex,
          ),
          NavigationBarItem(
            icon: SvgIcons.thinking,
            text: 'Quizs',
            changeIndex: changeIndex,
            index: 2,
            currentIndex: currentIndex,
          ),
          NavigationBarItem(
            icon: SvgIcons.project,
            text: 'Projects',
            index: 3,
            currentIndex: currentIndex,
            changeIndex: changeIndex,
          ),
        ],
      ),
    );
  }
}
