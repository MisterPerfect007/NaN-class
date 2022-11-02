import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:http/http.dart' as http;

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
                  const SizedBox(height: 100),
                  const SocialMediaFormField(),
                  const SizedBox(height: 10),
                  const Text(
                    "Sign in to your Google account and click enter",
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
        style:
            TextButton.styleFrom(minimumSize: const Size(double.infinity, 0)),
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
  final googleSignIn = GoogleSignIn(
      serverClientId:
          '342579524909-ip6rf92vnse3n7bfid8e7s4aud2vajf2.apps.googleusercontent.com');
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser == null) return null;

  final googleAuth = await googleUser.authentication;

  final Response response;
  try {
    response = await http.get(
        Uri.http('192.168.88.87:4000', '/api/getInfoSession'),
        headers: {'cookie': "nan-session=${googleUser.id}"}).timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      print("Body:  ${json.decode(response.body)}");
    }
  } catch (e) {
    print(">>>>>>>>>>>>Request error");
    print(e);
  }
  print("googleUser>>>>>>>>>>>>>>>>>>>>>>>$googleUser");


  //192.168.50.4:4000/api/auth/mobile

  /* 
  scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        serverClientId: isIOS ? null : googleClientId,
        clientId: isIOS ? googleClientIdIOS : null);
   */

  return null;
}
