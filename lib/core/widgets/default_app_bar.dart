import 'package:flutter/material.dart';

import '../../ui/colors/app_colors.dart';

AppBar defautAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.mainViolet,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
