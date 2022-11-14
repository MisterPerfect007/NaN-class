import 'package:flutter/material.dart';

import '../../ui/colors/app_colors.dart';
import '../../ui/svg_icons/svg_icons.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.darkBg,
      width: size.width * 0.8,
      height: size.height,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //!Header
              Container(
                  color: AppColors.mainViolet,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Parfait Tapsoba",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: const [
                    SizedBox(height: 20),
                    DrawerItem(
                      text: "Week challenges",
                      icon: SvgIcons.calendarWeek,
                    ),
                    SizedBox(height: 20),
                    DrawerItem(
                      text: "My Ranking",
                      icon: SvgIcons.rankingStar,
                    ),
                    SizedBox(height: 20),
                    DrawerItem(
                      text: "My Calendar & Meets ",
                      icon: SvgIcons.calendar,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final SvgIcons icon;
  const DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgIcon(
          icon: icon,
          color: AppColors.mainWhite,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.mainWhite),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
