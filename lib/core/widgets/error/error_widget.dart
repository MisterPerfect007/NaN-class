import 'package:flutter/material.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import '../../../ui/svg_icons/svg_icons.dart';

class CustomErrorWidget extends StatelessWidget {
  final Function()? onPressed;
  final String msg;
  final SvgIcons icon;
  final double iconSize;
  const CustomErrorWidget({
    Key? key,
    this.onPressed,
    required this.msg,
    required this.icon,
    this.iconSize = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              icon: icon,
              size: iconSize,
              color: AppColors.mainWhite,
            ),
            const SizedBox(height: 5),
            Text(msg, style: const TextStyle(color: AppColors.mainWhite),),
            const SizedBox(height: 10),
            if(onPressed != null) TextButton(
              onPressed: onPressed,
              child: const Text(
                  "Try again"), /* style: TextButton.styleFrom(primarys: AppColors.mainGreen) */
            ),
          ],
        ),
      ),
    );
  }
}
