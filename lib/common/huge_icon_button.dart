import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sports_app/common/dimens.dart';

class HugeIconButton extends StatelessWidget {
  const HugeIconButton(
      {super.key,
      required this.icon,
      this.color,
      this.tooltip,
      this.onPressed,
      this.iconColor});
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final String? tooltip;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip ?? '',
      triggerMode: TooltipTriggerMode.tap,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(kLarge),
        child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(kSmall)),
            child: HugeIcon(icon: icon, color: Colors.white ?? theme.primary)
            //Icon(icon, color: iconColor ?? AppColors.primaryColor),
            ),
      ),
    );
  }
}
