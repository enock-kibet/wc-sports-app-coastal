import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/notifications/notification.dart';
import 'package:sports_app/router/router.dart';

import 'package:sports_app/theme/theme.dart';

class NotificationsCard extends StatelessWidget {
  final Notifications notification;
  const NotificationsCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              AppRoute.notifications.name,
              extra: notification,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(kSmall * 3),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: kXSmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey,
                              child: Text(''),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification.message,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: kSMedium,
                                        color: AppColors.darkColor)),
                                const SizedBox(
                                  height: kXSmall,
                                ),
                                Text(
                                  notification.time,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: kSMedium * 0.8,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: kXSmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kSmall,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
