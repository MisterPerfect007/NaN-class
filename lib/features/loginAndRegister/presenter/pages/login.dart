import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/app/logo/nan-logo.png",
                  width: 100,
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome NaNien",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SocialMediaFormField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaFormField extends StatelessWidget {
  const SocialMediaFormField({
    Key? key,
  }) : super(key: key);

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
      child: TextButton(
        onPressed: googleLoginAndRegister,
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
        ),
      ),
    );
  }

}

Future googleLoginAndRegister() async {
  final googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser == null) return null;

  final googleAuth = await googleUser.authentication;

  
  return null;
}