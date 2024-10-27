import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/common/dimens.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    super.key,
    required this.title,
    this.color,
    required this.iconData,
    required this.onTap,
    this.badgeCount,
  });

  final String title;
  final Color? color;
  final IconData iconData;
  final VoidCallback onTap;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kMedium, vertical: kSMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: badgeCount != null
                  ? Badge(
                      backgroundColor: theme.error,
                      label: Text('$badgeCount'),
                      child: Icon(
                        iconData,
                        color: theme.primary, // Color of the icon
                        size: 24,
                      ),
                    )
                  : Icon(
                      iconData,
                      color: Colors.black54, // Color of the icon
                      size: 24,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.inverseSurface.withOpacity(0.7)),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right, // iOS style icon
              color: theme.inverseSurface, // Icon color
            ),
          ],
        ),
      ),
    );
  }
}
