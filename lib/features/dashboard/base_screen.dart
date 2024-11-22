// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';


import 'package:sports_app/common/dimens.dart';

import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/dashboard/pages/home/home_page.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/theme.dart';

import 'package:upgrader/upgrader.dart';


class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideMenuCubit, GlobalKey<ScaffoldState>>(
      builder: (context, state) {
        return UpgradeAlert(
          navigatorKey: router.routerDelegate.navigatorKey,
          child: Scaffold(
            key: state,
            drawer:  Drawer(
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
                          Image.asset("assets/images/drawer_bg.png",fit: BoxFit.fitWidth),
                          Positioned(
                              left: kXLMedium,
                              bottom: kXLMedium,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/profile_pic.png",height: 72,),
                                  Text("Alicia Ogwambo",style: TextStyle(color: AppColors.inputFillColor,fontSize: kMedium,fontWeight: FontWeight.bold),),
                                  Text("aliciaogwambo@gmail.com",style: TextStyle(color: AppColors.inputFillColor,fontSize: kSMedium,)),
                                  SizedBox(height: kXXLarge,),
                                ],
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: kXLMedium,top: kXXXLarge),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RowIconButton(Icons.arrow_circle_up_outlined, "Standings"),
                            const SizedBox(height: kLarge,),
                            RowIconButton(Icons.perm_media_outlined, "Team Media"),
                            const SizedBox(height: kLarge,),
                            RowIconButton(Icons.people, "Membership"),

                          ],
                        ),
                      ),
                    ],),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kXLMedium,vertical: kXLMedium),
                    child: RowIconButton(Icons.logout, "Logout"),

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
                selectedItemColor: AppColors.darkColor,
                unselectedItemColor: const Color(0xff919191),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/home.svg",
                      color: widget.navigationShell.currentIndex == 0
                          ? AppColors.darkColor
                          : null,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/date.svg",
                      color: widget.navigationShell.currentIndex == 1
                          ? AppColors.darkColor
                          : null,
                    ),
                    //Icon(LucideIcons.beer),
                    label: 'Schedule',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/shopping-basket.svg",
                      color: widget.navigationShell.currentIndex == 2
                          ? AppColors.darkColor
                          : null,
                    ),
                    label: 'Shop',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/profile.svg",
                      color: widget.navigationShell.currentIndex == 3
                          ? AppColors.darkColor
                          : null,
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
