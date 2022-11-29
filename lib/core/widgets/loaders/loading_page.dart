
import 'package:flutter/material.dart';

import '../../../ui/colors/app_colors.dart';
import '../animation/custom_opacity_animation.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomOpacityAnimation(
        child: Center(
          child: SizedBox(
            child: SizedBox(width: 40, height: 40, child: CircularProgressIndicator(color: AppColors.mainWhite,)),
          ),
        ),
      ),
    );
  }
}
