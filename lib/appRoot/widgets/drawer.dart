import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nan_class/features/home/presenter/bloc/home_bloc.dart';
import 'package:nan_class/features/loginAndRegister/presenter/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';
import '../../core/package/local_storage/keys.dart';
import '../../features/loginAndRegister/domain/entity.dart';
import '../../ui/colors/app_colors.dart';
import '../../ui/svg_icons/svg_icons.dart';

class CustomDrawer extends StatefulWidget {
  final User user;
  const CustomDrawer({Key? key, required this.user}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                      //avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: 80,
                          width: 80,
                          imageUrl: widget.user.avatar ?? "",
                          fadeOutDuration: const Duration(milliseconds: 300),
                          fadeInDuration: const Duration(milliseconds: 300),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.user.login ?? '',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const DrawerItem(
                      text: "Week challenges",
                      icon: SvgIcons.calendarWeek,
                    ),
                    const SizedBox(height: 20),
                    const DrawerItem(
                      text: "My Ranking",
                      icon: SvgIcons.rankingStar,
                    ),
                    const SizedBox(height: 20),
                    const DrawerItem(
                      text: "My Calendar & Meets ",
                      icon: SvgIcons.calendar,
                    ),
                    const SizedBox(height: 40),
                    //Logout
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: logout,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.logout),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Logout",
                                style: TextStyle(color: AppColors.mainWhite),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    final googleSignIn = GoogleSignIn(serverClientId: googleServerClientId);
    googleSignIn.disconnect();
    //
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(googleUserIdKEY);
    //
    navigateTo(const Login());
  }

  //
  //:separated method to access context
  void navigateTo(Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
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
