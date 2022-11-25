import 'package:flutter/material.dart';

import '../../ui/colors/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: AppColors.mainWhite,));
  }
}