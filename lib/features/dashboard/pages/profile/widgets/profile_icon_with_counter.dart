import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/user/user.dart';

class ProfileWithCounter extends StatelessWidget {
  final User? user;
  const ProfileWithCounter({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80, // The width of the profile icon container
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Border color of the profile icon
                  width: 2.58,
                ),
              ),
              child:
                  // user.user != null && user.user!.picture != null
                  //     ? ClipRRect(
                  //         borderRadius: BorderRadius.circular(77),
                  //         child: CachedNetworkImage(
                  //           imageUrl: user.user!.picture!,
                  //           width: 124,
                  //           height: 124,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       )
                  //     :
                  FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: Icon(
                  CupertinoIcons
                      .person_alt_circle_fill, // Fallback icon if no image is provided
                  color: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: kSmall),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user?.firstName} ${user?.lastName}", // The full name of the user
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: kLarge,
              ),
            ),
            Text(
              "${user?.email}",
              style: const TextStyle(
                fontSize: kSMedium,
              ),
            ),
            Text(
              "21 years old . 80kg . 170cm", // The location of the user
              style: TextStyle(
                fontSize: kSMedium,
                color: theme.inverseSurface.withOpacity(0.3),
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
