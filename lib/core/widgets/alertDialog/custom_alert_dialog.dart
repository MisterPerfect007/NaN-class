import 'package:flutter/material.dart';

Future showCustomDialog(
  BuildContext context, {
  Color? barrierColor,
  required Color topColor,
  required IconData icon,
  required String title,
  required String bodyText,
  required Function() onBtnTap,
}) async {
  double radius = 10;
  //
  // final theme = Theme.of(context);
  return showDialog(
    barrierColor: barrierColor,
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: topColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                )),
            child: const Center(
              child: Icon(
                Icons.warning,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                const SizedBox(height: 20),
                Text(bodyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    )),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      onBtnTap();
                    },
                    child: const Text("OK"))
              ],
            ),
          )
        ],
      ),
    ),
  );
}

//
Future showLoadingDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const AlertDialog(
            content: SizedBox(
              width: 50,
              height: 50,
              child: Center(child: CircularProgressIndicator()),
            ),
          ));
}
