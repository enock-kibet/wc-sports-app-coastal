import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget? childWidget;

  const AppBackground({super.key, this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Base dark background
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFF050007),
        ),

        /// Purple glow (top-left)
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.2,
              colors: [
                Color(0xFF5A0A6E), // rich purple
                Color(0xFF2A0033),
                Color(0xFF050007), // fades to black
              ],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
        ),

        /// Dark fade overlay (bottom emphasis)
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

        /// Content
        if (childWidget != null) childWidget!,
      ],
    );
  }
}
