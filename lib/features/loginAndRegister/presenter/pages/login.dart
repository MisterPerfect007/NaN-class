import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nan_class/appRoot/root.dart';
import 'package:nan_class/core/widgets/alertDialog/custom_alert_dialog.dart';
import 'package:nan_class/features/home/data/datasources/user_remote_data_source.dart';
import 'package:nan_class/features/home/presenter/bloc/home_bloc.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/failure/failures.dart';
import '../../../../core/package/local_storage/keys.dart';
import '../../../../core/package/local_storage/local_storage_key_value.dart';
import '../../../../main.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: AppColors.darkBg,
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/app/logo/nan-logo.png",
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome NaNien",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 60),
                    const SocialMediaFormField(),
                    const SizedBox(height: 10),
                    const Text(
                      "Sign in with your Google account",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaFormField extends StatefulWidget {
  const SocialMediaFormField({
    Key? key,
  }) : super(key: key);

  @override
  State<SocialMediaFormField> createState() => _SocialMediaFormFieldState();
}

class _SocialMediaFormFieldState extends State<SocialMediaFormField> {
  //
  bool loginIsProcessing = false;
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: AppColors.darkBg,
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 0.5,
                spreadRadius: 0.5,
                offset: const Offset(0, 0))
          ],
          border: Border.all(color: Colors.white.withOpacity(0.1))),
      height: 40,
      child: !loginIsProcessing
          ? TextButton(
              onPressed: () async {
                setState(() {
                  loginIsProcessing = true;
                });
                await googleLoginAndRegister();
                setState(() {
                  loginIsProcessing = false;
                });
              },
              style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/media_logos/google.svg",
                    width: 20,
                  ),
                  const Text(
                    "Login with Google",
                    style: TextStyle(color: Colors.white),
                  ),
                  Visibility(
                    visible: false,
                    child: SvgPicture.asset(
                      "assets/media_logos/google.svg",
                      width: 20,
                    ),
                  ),
                ],
              )
              // : const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(color: AppColors.mainWhite, strokeWidth: 2,)),
              )
          : const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: AppColors.mainWhite,
              )),
    );
  }

  Future googleLoginAndRegister() async {
    final googleSignIn = GoogleSignIn(serverClientId: googleServerClientId);

    GoogleSignInAccount? googleUser;

    try {
      googleUser = await googleSignIn.signIn();
    } catch (e) {
      //
      //show message
      showCustomDialog(
        context,
        icon: Icons.close,
        topColor: AppColors.mainred,
        title: "Google Sign in failed",
        bodyText: "Something went wrong, try again please.",
        onBtnTap: () {
          Navigator.pop(context);
        },
      );
    }

    if (googleUser == null) {
      customShowDialog(
        title: "Google Sign in failed",
        bodyText: "Something went wrong, try again please.",
        onBtnTap: () {
          Navigator.pop(context);
        },
      );
      return null;
    } else {
      //first set the googleUserId to local storage
      //
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(googleUserIdKEY, googleUser.id);
      //
      final userOrFailure = await getUserRemoteDataSource();
      userOrFailure.fold(
          //when a failure
          (failure) {
        //remove the googleUserId in the local storage
        //when there a failure
        prefs.remove(googleUserIdKEY);
        if (failure.error == UserErrorType.noUserFound) {
          showCustomDialog(
            context,
            icon: Icons.close,
            topColor: AppColors.mainred,
            title: "No user found",
            bodyText: "It seems like your are not register yet",
            onBtnTap: () {
              Navigator.pop(context);
            },
          );
        } else {
          showCustomDialog(
            icon: Icons.close,
            topColor: AppColors.mainred,
            context,
            title: "Something went wrong",
            bodyText:
                "Somthing went wrong when try to find your account. Please try a again",
            onBtnTap: () {
              Navigator.pop(context);
            },
          );
        }
      },
          //
          //when a user is found
          (user) async {
        context.read<HomeBloc>().add(SetUserLoadedState(user));

        //navigate to LoginFlow widget instead of Root widget to access  Bloc providers
        navigateTo(const LoginFlow());
      });
    }
  }

  //
  //to access the BuildContext
  void customShowDialog(
          {required String title,
          required String bodyText,
          required void Function() onBtnTap}) =>
      showCustomDialog(
        context,
        icon: Icons.close,
        topColor: AppColors.mainred,
        title: title,
        bodyText: bodyText,
        onBtnTap: onBtnTap,
      );

  //
  //:separated method (to access BuildContext easily)
  void navigateTo(Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }
}
