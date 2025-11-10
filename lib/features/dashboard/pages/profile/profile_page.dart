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
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/circular_icon_container.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/circular_toggle.dart';
import 'package:sports_app/localization/app_prefs.dart';
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
  bool loading = false;
  late final AppPreferences _prefs;

  @override
  void initState() {
    currentUser = service<AppPreferencesManager>().currentUserValue!;
    _prefs = AppPreferences();
    super.initState();
  }

  Future<void> _loadCurrentUser() async {
    setState(() => loading = true);

    try {
      final user = await _prefs.getUserData();

      if (mounted && user != null) {
        setState(() {
          currentUser = user;
        });
      }
    } catch (e) {
      debugPrint("❌ Failed to load user: $e");
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadCurrentUser, // 👈 Pull to refresh manually
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: kXSmall),
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
                              width: 1.4,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(88),
                            child: CachedNetworkImage(
                              imageUrl: currentUser?.picture ?? "",
                              width: 88,
                              height: 88,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 48,
                                color: AppColors.defaultAppPurple,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentUser?.name ?? "",
                          style: const TextStyle(
                            fontSize: kMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("0 Points"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kMedium),

              // Menu Cards
              InforCard(
                image: LucideIcons.edit,
                title: "Edit Profile",
                press: () async {
                  await context.pushNamed(AppRoute.editProfile.name);
                  await _loadCurrentUser(); // 👈 Refresh after edit
                },
              ),
              InforCard(
                image: LucideIcons.footprints,
                title: "Points Management",
                press: () {
                  context.pushNamed(AppRoute.pointsManagement.name);
                },
              ),
              InforCard(
                image: LucideIcons.moon,
                title: "Change Theme",
                press: () {
                  _showBottomSheet(context);
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
                press: () {
                  context.pushNamed(AppRoute.help.name);
                },
              ),
              InforCard(
                image: LucideIcons.logOut,
                title: "Logout",
                press: () {
                  logoutDialog(context);
                },
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
                  child: GestureDetector(
                    onTap: () {
                      context.go('/home');
                    },
                    child: Icon(
                      LucideIcons.arrowLeft,
                      color: AppColors.whiteColor,
                    ),
                  )),
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
            onPressed: () async {
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

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full-screen height if needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return _BottomSheetContent();
    },
  );
}

class _BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final themeMode = context.watch<ThemeCubit>().state;

    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55, // 40% height initially
        minChildSize: 0.2, // Minimum size
        maxChildSize: 1.0, // Almost full screen
        builder: (context, scrollController) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Drag Handle
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xffc4c4c4),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 20),

                // Sheet Content
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Center(
                        child: Text(
                          'Choose Theme',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      // Light Mode
                      Row(
                        children: [
                          const CircularIconButton(
                              icon: Icons.light_mode_outlined),
                          const SizedBox(width: 16),
                          const Text("Light Mode"),
                          const Spacer(),
                          DotToggleButton(
                            isOn: themeMode == ThemeMode.light,
                            onToggle: () => {
                              themeCubit.toggleTheme(false),
                              context.pop(true)
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Dark Mode
                      Row(
                        children: [
                          const CircularIconButton(
                              icon: Icons.dark_mode_outlined),
                          const SizedBox(width: 16),
                          const Text("Dark Mode"),
                          const Spacer(),
                          DotToggleButton(
                            isOn: themeMode == ThemeMode.dark,
                            onToggle: () => {
                              themeCubit.toggleTheme(true),
                              context.pop(true)
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // System Mode
                      Row(
                        children: [
                          const CircularIconButton(
                              icon: Icons.phone_iphone_rounded),
                          const SizedBox(width: 16),
                          const Text("Set to Device Mode"),
                          const Spacer(),
                          DotToggleButton(
                            isOn: themeMode == ThemeMode.system,
                            onToggle: () => {
                              themeCubit.emit(ThemeMode.system),
                              context.pop(true)
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
