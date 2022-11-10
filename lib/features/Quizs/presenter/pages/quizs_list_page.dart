import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/default_app_bar.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/svg_icons/svg_icons.dart';

class QuizsListPage extends StatelessWidget {
  const QuizsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defautAppBar("Quizs"),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: AppColors.darkBg,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                color: AppColors.mainViolet,
                child: ExpansionTile(
                  title: const Text(
                    'Course : 1-bien-utiliser-votre-mac 1-bien-utiliser-votre-mac',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  collapsedIconColor: Colors.white,
                  leading: SvgPicture.asset(
                      "assets/app/content/i-exam-multiple-choice.svg",
                      width: 30, color: Colors.blue,),
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 5, top: 10, bottom: 10),
                          color: Colors.white.withOpacity(0.1),
                          child: Row(
                            children: const [
                              SvgIcon(
                                icon: SvgIcons.rankingStar,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Text(
                                "1. Bien utiliser son mac utiliser son mac utiliser son mac",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              )),
                              
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
    );
  }
}
