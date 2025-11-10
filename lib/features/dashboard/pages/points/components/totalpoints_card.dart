import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/common/dimens.dart';

class TotalpointsCard extends StatelessWidget {
  final String? totalpoints;
  const TotalpointsCard({super.key, this.totalpoints});

  @override
  Widget build(BuildContext context) {
    final isLoading = totalpoints == null || totalpoints!.isEmpty;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: kMedium),
      padding: const EdgeInsets.all(kMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(kLarge),
        border: Border.all(color: AppColors.greyColor),
      ),
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 28,
                width: 100,
                color: Colors.white,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  totalpoints ?? "0",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Total Points",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
    );
  }
}
