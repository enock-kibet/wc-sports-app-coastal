import 'package:flutter/material.dart';
import 'package:sports_app/data/repository/auth_repository.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/router/router.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Short delay to show splash logo
    await Future.delayed(const Duration(milliseconds: 800));

    final authRepo = service<AuthRepository>();

    try {
      final tokenRefreshed = await authRepo.refreshToken();

      if (!mounted) return;

      if (tokenRefreshed) {
        // Refresh succeeded → navigate to shell's home
        GoRouter.of(context).go('/home');
      } else {
        // Refresh failed → go to login
        GoRouter.of(context).go('/signIn');
      }
    } catch (_) {
      if (!mounted) return;
      GoRouter.of(context).go('/signIn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              width: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
