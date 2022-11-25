import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/svg_icons/svg_icons.dart';
import '../bloc/home_bloc.dart';

AppBar buildAppBar(context) {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(26, 28, 52, 1),
        leading: InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: SvgIcon(
              icon: SvgIcons.menuAltLeft,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: state.user.avatar ?? "",

                    // errorWidget: (context, url, error) => ,
                    fadeOutDuration: const Duration(milliseconds: 300),
                    fadeInDuration: const Duration(milliseconds: 300),
                  ),
                ),
              );
            }
            return Container();
          }),
        ]);
  }