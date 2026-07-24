import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/products/product.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/product_image_placeholder.dart';
import 'package:sports_app/router/router.dart';

import 'package:sports_app/theme/theme.dart';

class TopSellersCard extends StatelessWidget {
  final Product product;
  const TopSellersCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              AppRoute.shopDetails.name,
              pathParameters: {'productId': product.id},
              extra: product,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(kSmall),
            ),
            child: Column(
              children: [
                ShopProductImage(
                  imageUrl: product.imageUrl,
                  width: double.infinity,
                  height: 150,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kSmall),
                    topRight: Radius.circular(kSmall),
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
                            Text(product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kSMedium,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface)),
                            const SizedBox(
                              height: kXSmall,
                            ),
                            Text(
                              product.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: kSMedium * 0.8,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: kXSmall,
                            ),
                            Text(
                              "Ksh ${product.price}",
                              style: const TextStyle(
                                  fontSize: kSMedium,
                                  fontWeight: FontWeight.bold),
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
                color: AppColors.pink2Color.withValues(alpha: 0.3),
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
