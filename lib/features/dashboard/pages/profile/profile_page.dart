// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  late User currentUser;
  bool loading=false;


  @override
  void initState() {
    currentUser  = service<AppPreferencesManager>().currentUserValue!;
    super.initState();
  }

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
                   Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [

                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.whiteColor,
                                    width: 1.4
                                )
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(88),
                              child: BlocBuilder<UserBloc,User?>(
                                builder: (context,user){
                                  return CachedNetworkImage(
                                    errorWidget: (context, url, error) => Icon(Icons.person,size: 48,color: AppColors.defaultAppPurple,),
                                    imageUrl: user?.picture??"",
                                    width: 88,
                                    height: 88,
                                    fit: BoxFit.cover,
                                  );
                                }

                              ),
                            ),
                          ),
                        Text(currentUser.name, style: const TextStyle(fontSize: kMedium, fontWeight: FontWeight.bold)),
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
                press: () {
                  context.pushNamed(AppRoute.aboutUs.name);
                },
              ),
              InforCard(
                image: LucideIcons.helpCircle,
                title: "Help",
                press: () {context.pushNamed(AppRoute.help.name);},
              ),
              InforCard(
                image: LucideIcons.logOut,
                title: "Logout",
                press: () {
                   logoutDialog(context);
                }
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
Future<void> logoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext dialogcontext) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You are about to logout!!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Yes, logout'),
            onPressed: () async{
              await service<AppPreferencesManager>().logOut();
            },
          ),
          TextButton(
            child: const Text('No, stay loggedIn'),
            onPressed: () {
              Navigator.of(dialogcontext).pop();
            },
          ),
        ],
      );
    },
  );
}