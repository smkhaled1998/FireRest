import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  double iconSize;
  Color iconBG;
  Color iconColor;
  double containerSize;

  AppIcon(
      {Key? key,
      required this.icon,
      this.iconColor = Colors.black,
      this.iconBG = Colors.green,
      this.iconSize = 20,
      this.containerSize = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(containerSize / 2),
          color: iconBG),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
