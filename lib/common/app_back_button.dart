import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;

  const AppBackButton({
    super.key,
    this.onPressed,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? Colors.white.withValues(alpha: 0.16)
        : colorScheme.surface.withValues(alpha: 0.92);
    final iconColor = isDark ? Colors.white : colorScheme.onSurface;

    return IconButton(
      onPressed: onPressed ?? () => context.pop(),
      icon: const Icon(LucideIcons.arrowLeft),
      color: iconColor,
      iconSize: size * 0.5,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.tight(Size.square(size)),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: backgroundColor,
        shape: const CircleBorder(),
      ),
    );
  }
}
