import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sports_app/features/app/blocs/matches/match_schedule/schedule_bloc.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';

import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';

import 'data/services/service.dart';
import 'features/app/blocs/matches/match_bloc.dart';
import 'features/app/blocs/products/product_bloc.dart';
import 'router/router.dart';
import 'theme/light_theme.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  setUpService();
  await service<AppPreferencesManager>().init();
  // Stripe.publishableKey = "pk_test_51O9SmpIPfdPAIvZjlRwm4hFZ6VFixUHEdBHSl8OfNDnY8UrPfDHHjfgAl7eCQSxZkHBp4WDuRpF46Ct184dH6fPm00sTQAWXJH";
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  // await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(_)=>UserBloc(service<AppPreferencesManager>().currentUserValue)),
        BlocProvider(create: (_) => SideMenuCubit()),
        BlocProvider(create: (_) => HideCubit()),
        BlocProvider(create: (_) => ScheduleBloc()),

        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc()
            ..add(
              const ProductEvent.products(),
            ),
        ),
        BlocProvider<MatchBloc>(
          create: (_) => MatchBloc()
            ..add(
              const MatchEvent.matches(),
            ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Sports App',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        routerConfig: router,
      ),
    );
  }
}
