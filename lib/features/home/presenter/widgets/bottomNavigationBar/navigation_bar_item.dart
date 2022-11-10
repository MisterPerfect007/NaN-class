import 'package:flutter/material.dart';

import '../../../../../ui/svg_icons/svg_icons.dart';

class NavigationBarItem extends StatelessWidget {
  final String text;
  final SvgIcons icon;
  final int currentIndex;
  final int index;
  final void Function(int) changeIndex;
  // final int index;
  // final int selectedIndex;

  const NavigationBarItem(
      {Key? key,
      required this.text,
      required this.icon,
      required this.currentIndex,
      required this.changeIndex,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.2),
          onTap: () {
            changeIndex(index);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  icon: icon,
                  color: isSelected
                      ? const Color.fromRGBO(51, 255, 0, 1)
                      : Colors.white,
                ),
                Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: isSelected
                          ? const Color.fromRGBO(51, 255, 0, 1)
                          : Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
