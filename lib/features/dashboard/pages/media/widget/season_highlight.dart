import 'package:flutter/material.dart';

import 'package:sports_app/common/dimens.dart';

import 'package:sports_app/theme/theme.dart';

class SeasonHightlightCard extends StatelessWidget {
  const SeasonHightlightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // context.pushNamed(
            //   AppRoute.matchDetails.name,
            // );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: kMedium),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(kSmall),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kSmall),
                    topRight: Radius.circular(kSmall),
                  ),
                  child: Image.asset(
                    "assets/images/rugby2.png",
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: kXSmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Afro Pacers Vs Mamluki Game 1 Recap",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kSMedium,
                                    color: AppColors.darkColor)),
                            const SizedBox(
                              height: kXSmall,
                            ),
                            const Text(
                              "10mins * posted on 4th June 2024",
                              style: TextStyle(
                                  fontSize: kSMedium * 0.8,
                                  fontWeight: FontWeight.normal),
                            ),
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
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(kXSmall),
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.3),
                shape: BoxShape.circle),
            child: Icon(
              Icons.bookmark_outline,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
