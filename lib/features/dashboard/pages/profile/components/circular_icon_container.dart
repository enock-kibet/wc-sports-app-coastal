import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  const CircularIconButton({
    Key? key,
    required this.icon,
    this.size = 52,
    this.backgroundColor = const Color(0xffe8e8e8),
    this.iconColor = const Color(0xff404040),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: size / 2, // Icon size relative to container size
          color: iconColor,
        ),
      ),
    );
  }
}
