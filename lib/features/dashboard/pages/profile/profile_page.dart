// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: kXSmall),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  imageStack(context),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/shirt.png'),
                        ),
                        Text("John Mbugua",
                            style: TextStyle(
                                fontSize: kLarge, fontWeight: FontWeight.bold)),
                        Text("0 Points")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: kMedium,
              ),
              InforCard(
                image: LucideIcons.edit,
                title: "Edit Profile",
                press: () {
                  context.pushNamed(AppRoute.editProfile.name);
                },
              ),
              InforCard(
                image: LucideIcons.footprints,
                title: "Points Management",
                press: () {
                  context.pushNamed(AppRoute.standings.name);
                },
              ),
              InforCard(
                image: LucideIcons.moon,
                title: "Change Theme",
                press: () {
                  context.pushNamed(AppRoute.teamMedia.name);
                },
              ),
              InforCard(
                image: LucideIcons.badgeInfo,
                title: "About Us",
                press: () {},
              ),
              InforCard(
                image: LucideIcons.helpCircle,
                title: "Help",
                press: () {context.pushNamed(AppRoute.help.name);},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack imageStack(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image.asset(
              "assets/images/Rectangle2.png",
              fit: BoxFit.cover,
              height: 200,
              width: context.width,
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
        Positioned(
          top: kSmall,
          left: kMedium,
          child: SafeArea(
            child: GestureDetector(
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
          ),
        ),
      ],
    );
  }
}

class InforCard extends StatelessWidget {
  const InforCard({
    super.key,
    required this.image,
    required this.title,
    required this.press,
  });
  final IconData image;
  final String title;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMedium),
      child: InkWell(
        onTap: press,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(kSMedium),
                    decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(kSmall)),
                    child: Icon(
                      image,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(title),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: kMedium,
                  )
                ],
              ),
            ),
            Divider(
              color: AppColors.greyColor,
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
