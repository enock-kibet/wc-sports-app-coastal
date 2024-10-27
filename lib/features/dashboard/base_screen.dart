// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';


import 'package:sports_app/common/dimens.dart';

import 'package:sports_app/features/app/side_menu_cubit.dart';
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
