import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/data/repository/auth_repository.dart';
import 'package:sports_app/localization/app_prefs.dart';
import 'package:sports_app/router/router.dart';

import 'data/repository/authentication.dart';
import 'data/services/service.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? currentPatchVersion;
  @override
  void initState() {
    
    Future.delayed(const Duration(seconds: 3), () {
      _init();
    });

    super.initState();
  }

  _init() async {
    var prefs = service<AppPreferences>();

    //Get authToken
    final String? data = await prefs.getAuthData();
    if (data != null) {
      //Login user
      AuthRepository.instance.login(data);
      AuthenticationRepository.instance.login();
      context.pushNamed(AppRoute.home.name);
      
    } else {
      // ignore: use_build_context_synchronously
      context.pushNamed(AppRoute.onboarding.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          
        ),
        child: Center(child: Image.asset("assets/playstore.png"),),
      ),
    );
  }
}
