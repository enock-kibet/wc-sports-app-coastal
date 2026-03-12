import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget? childWidget;

  const AppBackground({super.key, this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF050007),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.2,
              colors: [
                Color(0xFF5A0A6E),
                Color(0xFF2A0033),
                Color(0xFF050007),
              ],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xCC000000),
              ],
            ),
          ),
        ),
        if (childWidget != null) childWidget!,
      ],
    );
  }
}
