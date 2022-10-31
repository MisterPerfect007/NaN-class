import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgIcons {
  chartLineUp,
  chartLineDown,
  homeFilled,
  homeRegular,
  homeAlt,
  listLine,
  listSolid,
  settingsOutline,
  settingsFill,  
  search,  
  arrowLeft,  
  noWifiLine,  
  chevronLeft,  
  badO,
  menuAltLeft,
  project,
  thinking,
  course,
}

Map<SvgIcons, String> svgLink = {
  SvgIcons.chartLineUp: 'assets/svg/chart-line-up.svg',
  SvgIcons.chartLineDown: 'assets/svg/chat-arrow-down.svg',
  SvgIcons.homeFilled: 'assets/svg/home-filled.svg',
  SvgIcons.homeRegular: 'assets/svg/home-regular.svg',
  SvgIcons.homeAlt: 'assets/svg/home-alt.svg',
  SvgIcons.listLine: 'assets/svg/list-line.svg',
  SvgIcons.listSolid: 'assets/svg/list-solid.svg',
  SvgIcons.settingsOutline: 'assets/svg/settings-outline.svg',
  SvgIcons.settingsFill: 'assets/svg/settings-fill.svg',  
  SvgIcons.search: 'assets/svg/search.svg',  
  SvgIcons.arrowLeft: 'assets/svg/arrow-left.svg',  
  SvgIcons.noWifiLine: 'assets/svg/no-wifi-line.svg',  
  SvgIcons.chevronLeft: 'assets/svg/chevron-left.svg',  
  SvgIcons.badO: 'assets/svg/bad-o.svg',
  SvgIcons.menuAltLeft: 'assets/svg/menu-alt-left.svg',
  SvgIcons.project: 'assets/svg/project.svg',
  SvgIcons.thinking: 'assets/svg/thinking-problem.svg',
  SvgIcons.course: 'assets/svg/publish-course.svg',
};

class SvgIcon extends StatelessWidget {
  final Color? color;
  final double size;
  final SvgIcons? icon;
  const SvgIcon({
    Key? key,
    this.color = Colors.black,
    this.size = 20,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? SizedBox(
            child: SvgPicture.asset(svgLink[icon]!, width: size, color: color),
          )
        : Container();
  }
}