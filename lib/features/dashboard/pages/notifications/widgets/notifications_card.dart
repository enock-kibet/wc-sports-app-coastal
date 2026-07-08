import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/notifications/notification.dart';
import 'package:sports_app/theme/theme.dart';

class NotificationsCard extends StatelessWidget {
  final Notifications notification;
  final VoidCallback? onTap;

  const NotificationsCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(parsed);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 🎨 Backgrounds and colors for dark/light
    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.05)
        : Colors.black.withOpacity(0.05);
    final Color shadowColor = isDark ? Colors.black54 : Colors.black12;
    final Color titleColor = isDark ? Colors.white : AppColors.darkColor;
    final Color subtitleColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kXSmall),
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(kSmall * 3),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(kSmall * 3),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSmall * 3),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(kSmall * 1.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔔 Notification icon/avatar
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primaryColor
                        .withOpacity(isDark ? 0.25 : 0.15),
                    child: Icon(
                      Icons.notifications_active_rounded,
                      color: AppColors.primaryColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: kMedium),

                  // 📝 Notification content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.notificationType,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                        ),
                        if (notification.notificationText.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              notification.notificationText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: subtitleColor,
                              ),
                            ),
                          ),
                        const SizedBox(height: 6),
                        Text(
                          _formatDate(notification.updatedUtc),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: subtitleColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ➡️ Right arrow indicator
                  const SizedBox(width: kSmall),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: subtitleColor,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
