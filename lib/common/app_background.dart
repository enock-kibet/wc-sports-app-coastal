import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget? childWidget;

  const AppBackground({super.key, this.childWidget});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isDark
                ? Theme.of(context).scaffoldBackgroundColor
                : const Color(0xFFF2F2F2),
          ),
        ),
        if (!isDark)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFF2F2F2),
          ),
        if (childWidget != null) childWidget!,
      ],
    );
  }
}
