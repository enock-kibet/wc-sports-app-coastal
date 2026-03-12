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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768;
    final horizontalPadding = isTablet ? kXLMedium : kMedium;
    final sectionGap = isTablet ? kLarge : kMedium;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 900 : constraints.maxWidth,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: sectionGap),
                      headerSection(isTablet),
                      SizedBox(height: sectionGap),
                      searchField(isTablet),
                      SizedBox(height: sectionGap),
                      _sectionTitle("Recent Highlights"),
                      SizedBox(height: sectionGap),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: isTablet ? kMedium : kSmall,
                        runSpacing: kSmall,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: isTablet ? 100 : 78,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: isTablet ? 28 : 22,
                                  backgroundImage: const AssetImage(
                                    "assets/images/shirt.png",
                                  ),
                                ),
                                const SizedBox(height: kXSmall),
                                Text(
                                  "Buckets",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: isTablet ? 14 : 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: sectionGap),
                      _sectionTitle("Season Highlights"),
                      SizedBox(height: sectionGap),
                      ...List.generate(4, (index) {
                        return const SeasonHightlightCard();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        })),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: kMedium,
            fontWeight: FontWeight.w700,
            color: AppColors.whiteColor,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "See All",
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
      ],
    );
  }

  TextField searchField(bool isTablet) {
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
              borderRadius:
                  BorderRadius.circular(isTablet ? kXLMedium : kLarge)),
          contentPadding: EdgeInsets.symmetric(
              horizontal: isTablet ? kLarge : kMedium,
              vertical: isTablet ? kLarge : kXLMedium * 0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(isTablet ? kXLMedium : kLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(isTablet ? kXLMedium : kLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          hintText: "Search HRBC events",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.whiteColor.withOpacity(0.8))),
    );
  }

  Row headerSection(bool isTablet) {
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Team Media!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: isTablet ? kXLMedium : kLarge,
                      fontWeight: FontWeight.bold)),
              Text("All Media Highlights",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: isTablet ? kMedium : kSMedium,
                      fontWeight: FontWeight.normal)),
            ],
          ),
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
