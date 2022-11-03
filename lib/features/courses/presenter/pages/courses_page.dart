import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defautAppBar("Available courses"),
      body: Container(
        width: size.width,
        height: size.height,
        color: AppColors.darkBg,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    color: AppColors.mainViolet,
                    child: ExpansionTile(
                      title: const Text(
                        'Data',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      collapsedIconColor: Colors.white,
                      leading: SvgPicture.asset(
                          "assets/app/content/closed-book.svg",
                          width: 30),
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            // splashColor: Colors.red,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 5, top: 10, bottom: 10),
                              color: Colors.white.withOpacity(0.1),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                          "1. Bien utiliser son mac utiliser son mac utiliser son mac",
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                  ),
                                  SvgIcon(
                                    icon: SvgIcons.chevronRight,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBar defautAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.mainViolet,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
