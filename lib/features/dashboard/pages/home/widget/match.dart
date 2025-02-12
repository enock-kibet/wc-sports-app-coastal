import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/router/router.dart';

import 'package:sports_app/theme/theme.dart';

class ProductCard extends StatelessWidget {
  final MatchType match;
  const ProductCard({
    super.key, required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              AppRoute.matchDetails.name,
              extra: match
            );
          },
          child: Container(
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
                  child: CachedNetworkImage(
                    imageUrl: RandomImageUrl(),
                    errorWidget: (context, url, error) => Icon(Icons.person,size: 48,color: AppColors.whiteColor,),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
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
                            Text(match.matchName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kSMedium,
                                    color: AppColors.darkColor)),
                            const SizedBox(
                              height: kXSmall,
                            ),
                             Text(
                              "${match.matchVenue} ${getStringDate(match.matchDate)}",
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
