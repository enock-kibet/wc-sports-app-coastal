// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/dimens.dart';

import 'package:sports_app/common/extension/extension.dart';

import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/theme.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.7,
      height: double.infinity,
      color: AppColors.whiteColor,
      child: Column(
        children: [
          const ProfileCard(),
          SideMenuIconTile(
            title: "Team",
            icon: Icons.list_alt_outlined,
            press: () {
              context.read<SideMenuCubit>().closeDrawer();
              context.pushNamed(AppRoute.team.name);
            },
          ),
          SideMenuIconTile(
            title: "Team Media",
            icon: LucideIcons.tv,
            press: () {
              context.read<SideMenuCubit>().closeDrawer();

              context.pushNamed(AppRoute.media.name);
            },
          ),
          SideMenuIconTile(
            title: "Membership",
            icon: LucideIcons.activity,
            press: () {
              context.read<SideMenuCubit>().closeDrawer();
            },
          ),
          Expanded(child: Container()),
          ListTile(
            minLeadingWidth: 5,
            onTap: () {},
            leading: const Icon(LucideIcons.logOut, color: Colors.black54),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(
            height: kMedium,
          )
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.7,
      padding: const EdgeInsets.only(left: 15),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Rectangle.png"),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 42,
              backgroundColor: Theme.of(context).cardColor,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.error,
                backgroundImage: const AssetImage(
                  "assets/images/shirt.png",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Alicia Ogwambo",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            Text(
              "Alicia@gmail.com",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            SizedBox(
              width: 250,
              child: Divider(
                thickness: 0.8,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.svg,
    required this.title,
    required this.press,
  });

  final String svg, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Theme.of(context).colorScheme.secondary,
      splashColor: Theme.of(context).colorScheme.secondary,
      minLeadingWidth: 5,
      autofocus: true,
      onTap: press,
      leading: SizedBox(
        height: 26,
        width: 26,
        child: SvgPicture.asset(
          svg,
          color: Colors.black54,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}

class SideMenuIconTile extends StatelessWidget {
  const SideMenuIconTile({
    super.key,
    required this.icon,
    required this.title,
    required this.press,
  });

  final IconData icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Theme.of(context).colorScheme.secondary,
      splashColor: Theme.of(context).colorScheme.secondary,
      minLeadingWidth: 5,
      autofocus: true,
      onTap: press,
      leading: SizedBox(
        height: 26,
        width: 26,
        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.email,
  });
  final String name, email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(CupertinoIcons.person, color: Theme.of(context).cardColor),
      ),
      title: Text(
        name,
        style: TextStyle(color: Theme.of(context).cardColor),
      ),
      subtitle: Text(
        email,
        style: TextStyle(color: Theme.of(context).cardColor),
      ),
    );
  }
}
