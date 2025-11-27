import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sports_app/data/repository/auth_repository.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoAnimation =
        Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));
    _logoController.repeat(reverse: true);

    _initializeApp();
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final authRepo = service<AuthRepository>();

    try {
      final tokenRefreshed = await authRepo.refreshToken();

      if (!mounted) return;

      if (tokenRefreshed) {
        // Navigate to home
        GoRouter.of(context).go('/home');
      } else {
        // Refresh failed → go to login
        await service<AppPreferencesManager>().logOut();
      }
    } catch (_) {
      if (!mounted) return;
      await service<AppPreferencesManager>().logOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _logoAnimation,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  width: 160,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // SpinKitFadingCube(
            //   color: theme.colorScheme.primary,
            //   size: 50.0,
            // ),
            const SizedBox(height: 55),
            Text(
              'Loading...',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
