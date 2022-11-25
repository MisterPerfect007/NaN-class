
import 'package:flutter/material.dart';

class PointCard extends StatelessWidget {
  final String name;
  final double points;
  final Color? color;
  const PointCard(
      {Key? key,
      required this.name,
      required this.points,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            '$points',
            style: TextStyle(
                fontSize: 60,
                color: color ?? Colors.white,
                fontWeight: FontWeight.w800),
          ),
          Container()
        ],
      ),
    );
  }
}
