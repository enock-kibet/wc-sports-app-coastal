import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';

import 'widget/season_highlight.dart';

class TeamMediaPage extends StatefulWidget {
  const TeamMediaPage({super.key});

  @override
  State<TeamMediaPage> createState() => _TeamMediaPageState();
}

class _TeamMediaPageState extends State<TeamMediaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMedium),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: kMedium),
                headerSection(),
                const SizedBox(height: kMedium),
                searchField(),
                const SizedBox(height: kMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Highlights",
                      style: TextStyle(
                          fontSize: kMedium,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("See All",
                            style: TextStyle(color: AppColors.whiteColor)))
                  ],
                ),
                const SizedBox(height: kMedium),
                Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSmall),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/shirt.png"),
                          ),
                          const SizedBox(
                            height: kXSmall,
                          ),
                          Text(
                            "Buckets",
                            style: TextStyle(color: AppColors.whiteColor),
                          )
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: kMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Season Highlights",
                      style: TextStyle(
                          fontSize: kMedium,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("See All",
                            style: TextStyle(color: AppColors.whiteColor)))
                  ],
                ),
                const SizedBox(height: kMedium),
                ...List.generate(4, (index) {
                  return const SeasonHightlightCard();
                })
              ],
            ),
          ),
        )),
      ),
    );
  }

  TextField searchField() {
    return TextField(
      decoration: InputDecoration(
          suffixIcon: Container(
              padding: const EdgeInsets.only(right: kSmall),
              child: Icon(LucideIcons.search, color: AppColors.whiteColor)),
          fillColor: AppColors.whiteColor.withOpacity(0.2),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              ),
              borderRadius: BorderRadius.circular(kLarge)),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: kMedium, vertical: kXLMedium * 0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          hintText: "Search HRBC events",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.whiteColor.withOpacity(0.8))),
    );
  }

  Row headerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.3),
                shape: BoxShape.circle),
            child: Icon(
              LucideIcons.arrowLeft,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Team Media!",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: kLarge,
                    fontWeight: FontWeight.bold)),
            Text("All Media Highlights",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: kMedium,
                    fontWeight: FontWeight.normal)),
          ],
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoute.notifications.name);
          },
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.3),
                shape: BoxShape.circle),
            child: Icon(
              LucideIcons.bell,
              color: AppColors.whiteColor,
            ),
          ),
        )
      ],
    );
  }
}
