
import 'package:flutter/material.dart';

import '../../../../../ui/svg_icons/svg_icons.dart';
import 'navigation_bar_item.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(int) changeIndex;
  final int currentIndex;
  const CustomNavigationBar({
    Key? key, required this.changeIndex, required this.currentIndex,
  }) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  

  

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
            changeIndex: widget.changeIndex,
            index: 0,
            currentIndex: widget.currentIndex,
          ),
          NavigationBarItem(
            icon: SvgIcons.course,
            text: 'Courses',
            changeIndex: widget.changeIndex,
            index: 1,
            currentIndex: widget.currentIndex,
          ),
          NavigationBarItem(
            icon: SvgIcons.thinking,
            text: 'Quizs',
            changeIndex: widget.changeIndex,
            index: 2,
            currentIndex: widget.currentIndex,
          ),
          NavigationBarItem(
            icon: SvgIcons.project,
            text: 'Projects',
            index: 3,
            currentIndex: widget.currentIndex,
            changeIndex: widget.changeIndex,
          ),
        ],
      ),
    );
  }
}
