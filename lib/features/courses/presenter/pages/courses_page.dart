import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

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
                      title: const Text('Data', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),),
                      collapsedIconColor: Colors.white,
                      leading: SvgPicture.asset(
                          "assets/app/content/closed-book.svg",
                          width: 30),
                      children: [
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        // Text("data"),
                        // Text("data"),
                        // Text("data"),
                        // Text("data"),
                      ],
                    ))
                /* ListTile(leading: Container(height: 5, width: 5, color: Colors.red, ),title: Text('title'),) */
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
