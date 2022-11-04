import 'package:flutter/material.dart';

import '../../ui/colors/app_colors.dart';

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