// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';

import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/dashboard/pages/home/home_page.dart';
import 'package:sports_app/features/dashboard/pages/profile/profile_page.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/theme.dart';

import 'package:upgrader/upgrader.dart';

import '../../main.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  User currentUser = service<AppPreferencesManager>().currentUserValue!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideMenuCubit, GlobalKey<ScaffoldState>>(
      builder: (context, state) {
        return UpgradeAlert(
          navigatorKey: router.routerDelegate.navigatorKey,
          child: Scaffold(
            key: state,
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Image.asset("assets/images/drawer_bg.png",
                              fit: BoxFit.fitWidth),
                          Positioned(
                              left: kXLMedium,
                              bottom: kXLMedium,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.asset("assets/images/profile_pic.png",height: 72,),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.whiteColor,
                                            width: 1.4)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(72),
                                      child: BlocBuilder<UserBloc, User?>(
                                          builder: (context, user) {
                                        return CachedNetworkImage(
                                          imageUrl: user?.picture ?? "",
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.person,
                                            size: 48,
                                            color: AppColors.whiteColor,
                                          ),
                                          width: 72,
                                          height: 72,
                                          fit: BoxFit.cover,
                                        );
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    currentUser.name,
                                    style: TextStyle(
                                        color: AppColors.inputFillColor,
                                        fontSize: kMedium,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(currentUser.email,
                                      style: TextStyle(
                                        color: AppColors.inputFillColor,
                                        fontSize: kSMedium,
                                      )),
                                  SizedBox(
                                    height: kXXLarge,
                                  ),
                                ],
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kXLMedium, top: kXXXLarge),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRoute.team.name,
                                    extra: true);
                                context.pop();
                              },
                              child: RowIconButton(
                                  Icons.arrow_circle_up_outlined, "Standings"),
                            ),
                            const SizedBox(
                              height: kLarge,
                            ),
                            // RowIconButton(Icons.perm_media_outlined, "Team Media"),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRoute.media.name,
                                    extra: true);
                                context.pop();
                              },
                              child: RowIconButton(
                                  Icons.perm_media_outlined, "Team Media"),
                            ),
                            const SizedBox(
                              height: kLarge,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                    AppRoute.pointsManagement.name,
                                    extra: true);
                                context.pop();
                              },
                              child: RowIconButton(Icons.people, "Membership"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      logoutDialog(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kXLMedium, vertical: kXLMedium),
                      child: RowIconButton(Icons.logout, "Logout"),
                    ),
                  )
                ],
              ),
            ),
            body: widget.navigationShell,
            bottomNavigationBar: BottomNavigationBar(
                elevation: kSmall,
                currentIndex: widget.navigationShell.currentIndex,
                unselectedFontSize: kSMedium,
                selectedFontSize: kSMedium,
                onTap: _onTap,
                selectedItemColor: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(1),
                unselectedItemColor: const Color(0xff919191),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      widget.navigationShell.currentIndex == 0
                          ? "assets/icons/home_b.svg"
                          : "assets/icons/home.svg",
                      color: widget.navigationShell.currentIndex == 0
                          ? Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(1)
                          : AppColors.greyColor,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      widget.navigationShell.currentIndex == 1
                          ? "assets/icons/date_b.svg"
                          : "assets/icons/date.svg",
                      color: widget.navigationShell.currentIndex == 1
                          ? Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(1)
                          : AppColors.greyColor,
                    ),
                    //Icon(LucideIcons.beer),
                    label: 'Schedule',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      widget.navigationShell.currentIndex == 2
                          ? "assets/icons/shop_b.svg"
                          : "assets/icons/shop.svg",
                      color: widget.navigationShell.currentIndex == 2
                          ? Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(1)
                          : AppColors.greyColor,
                    ),
                    label: 'Shop',
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        widget.navigationShell.currentIndex == 3
                            ? "assets/icons/team_b.svg"
                            : "assets/icons/team.svg",
                        color: widget.navigationShell.currentIndex == 3
                            ? Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(1)
                            : AppColors.greyColor,
                      ),
                      label: 'Team'),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      widget.navigationShell.currentIndex == 4
                          ? "assets/icons/profile_b.svg"
                          : "assets/icons/profile.svg",
                      color: widget.navigationShell.currentIndex == 4
                          ? Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(1)
                          : AppColors.greyColor,
                    ),
                    label: 'Profile',
                  ),
                ]),
          ),
        );
      },
    );
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
