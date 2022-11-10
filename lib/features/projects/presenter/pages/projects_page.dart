import 'package:flutter/material.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:nan_class/ui/svg_icons/svg_icons.dart';

import '../../../../core/widgets/default_app_bar.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defautAppBar("Projects"),
      backgroundColor: AppColors.darkBg,
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // height: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 0),
                    blurRadius: 3,
                    spreadRadius: 3,
                  )
                ]
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Closed",
                        style: TextStyle(color: Colors.red, fontSize: 9),
                      )
                    ],
                  ),
                  const Expanded(
                      child: Center(
                          child: Text(
                    "L'immobilier",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ))),
                  const SvgIcon(icon: SvgIcons.chevronRight)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
