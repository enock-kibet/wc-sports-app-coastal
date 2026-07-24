import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/models/session/frontend_context.dart';
import 'package:sports_app/features/app/blocs/address/address_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sports_app/features/app/blocs/matches/match_schedule/schedule_bloc.dart';
import 'package:sports_app/features/app/blocs/media/media_bloc.dart';
import 'package:sports_app/features/app/blocs/notifications/notification_bloc.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/app/blocs/products/cart_bloc.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';

import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/firebase_options.dart';
import 'package:sports_app/localization/app_prefs.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:upgrader/upgrader.dart';

import 'data/services/service.dart';
import 'data/services/upgrade_service.dart';
import 'features/app/blocs/matches/match_bloc.dart';
import 'features/app/blocs/products/product_bloc.dart';
import 'router/router.dart';
import 'theme/app_colors.dart';
import 'theme/light_theme.dart';
import 'dart:io' show Platform;

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
    );

    Future<void> initFirebase() async {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } on FirebaseException catch (e) {
        if (e.code == 'duplicate-app') {
          Firebase.app();
        } else {
          rethrow;
        }
      }
    }

    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      if (Firebase.apps.isEmpty) {
        await initFirebase();
      }

      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    setUpService();
    await service<AppPreferencesManager>().init();
    await _bootstrapFrontendBranding();

    final runnableApp = _buildRunnableApp(
      isWeb: kIsWeb,
      webAppWidth: 560.0,
      app: const MyApp(),
    );

    runApp(runnableApp);
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      fatal: true,
    );
  });
}

Future<void> _bootstrapFrontendBranding() async {
  final prefsManager = service<AppPreferencesManager>();
  final cachedContext = prefsManager.currentContextValue;

  AppColors.applyBranding(
    primaryColorHex: cachedContext?.brandingPrimaryColor,
    secondaryColorHex: cachedContext?.brandingSecondaryColor,
    accentColorHex: cachedContext?.brandingAccentColor,
  );

  if (cachedContext?.hasBranding ?? false) {
    return;
  }

  final result = await service<ContextService>().getContext();
  await result.when(
    onError: (_) async {},
    onSuccess: (context) async {
      await prefsManager.saveFrontendContext(context);
      AppColors.applyBranding(
        primaryColorHex: context.brandingPrimaryColor,
        secondaryColorHex: context.brandingSecondaryColor,
        accentColorHex: context.brandingAccentColor,
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final prefs = AppPreferences();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AndroidInAppUpdates.checkAndUpdate(immediate: true);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                UserBloc(service<AppPreferencesManager>().currentUserValue)),
        BlocProvider(
          create: (_) => BrandingCubit(
            service<AppPreferencesManager>(),
            service<ContextService>(),
          )..refreshBranding(),
        ),
        BlocProvider(create: (_) => SideMenuCubit()),
        BlocProvider(create: (_) => HideCubit()),
        BlocProvider(create: (_) => ScheduleBloc()),
        BlocProvider(create: (_) => ThemeCubit(prefs)),
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
        BlocProvider<NotificationBloc>(
          create: (_) => NotificationBloc()
            ..add(
              const NotificationEvent.notifications(),
            ),
        ),
        BlocProvider<MediaBloc>(
          create: (_) => MediaBloc()
            ..add(
              const MediaEvent.media(),
            ),
        ),
        BlocProvider<CartBloc>(
          create: (_) {
            final cartBloc = CartBloc();
            final currentUser =
                service<AppPreferencesManager>().currentUserValue;
            if (currentUser?.email != null && currentUser!.email.isNotEmpty) {
              cartBloc.add(
                CartEvent.getCartItems(
                  request: {
                    "email": currentUser.email,
                  },
                ),
              );
            }
            return cartBloc;
          },
        ),
        BlocProvider<AddressBloc>(
          create: (_) => AddressBloc()
            ..add(
              const AddressEvent.getAddresses(
                request: {},
              ),
            ),
        ),
        BlocProvider<PointsBloc>(
          create: (_) => PointsBloc(),
        ),
      ],
      child: BlocBuilder<BrandingCubit, FrontendContextData>(
        builder: (context, brandingState) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                scaffoldMessengerKey: SnackbarService.messengerKey,
                title: brandingState.resolvedBrandName,
                debugShowCheckedModeBanner: false,
                theme: buildLightTheme(),
                darkTheme: buildDarkTheme(),
                themeMode: themeMode,
                routerConfig: router,
                builder: (context, child) {
                  return UpgradeAlert(
                    navigatorKey: router.routerDelegate.navigatorKey,
                    showIgnore: false,
                    showLater: false,
                    barrierDismissible: false,
                    shouldPopScope: () => false,
                    upgrader: Upgrader(
                      debugLogging: true,
                      durationUntilAlertAgain: Duration.zero,
                    ),
                    child: child ?? const SizedBox.shrink(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }
  return Center(
    child: ClipRect(
      child: SizedBox(
        width: webAppWidth,
        child: app,
      ),
    ),
  );
}
// _$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
//   name: json['name']??json["username"]as String,
//   email: json['email'] as String,
//   emailVerified: json['emailVerified']??false as bool,
//   picture: addDomain(json['picture']??"") as String?,
// );
//
// Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
//     <String, dynamic>{
//       'name': instance.name,
//       'email': instance.email,
//       'emailVerified': instance.emailVerified,
//       'picture': instance.picture,
//     };

class ThemeCubit extends Cubit<ThemeMode> {
  final AppPreferences _prefs;

  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedMode = await _prefs.getThemeMode();
    emit(savedMode);
  }

  void toggleTheme(bool darkMode) async {
    final newMode = darkMode ? ThemeMode.dark : ThemeMode.light;
    emit(newMode);
    await _prefs.saveThemeMode(newMode);
  }

  void useSystemTheme() {
    emit(ThemeMode.system);
  }

  void setSystemTheme() async {
    emit(ThemeMode.system);
    await _prefs.saveThemeMode(ThemeMode.system);
  }
}

class BrandingCubit extends Cubit<FrontendContextData> {
  BrandingCubit(this._prefsManager, this._contextService)
      : super(_prefsManager.currentContextValue ?? const FrontendContextData()) {
    _applyBranding(state);
    _subscription = _prefsManager.contextStream.listen((context) {
      final next = context ?? const FrontendContextData();
      _applyBranding(next);
      emit(next);
    });
  }

  final AppPreferencesManager _prefsManager;
  final ContextService _contextService;
  StreamSubscription<FrontendContextData?>? _subscription;

  Future<void> refreshBranding() async {
    final result = await _contextService.getContext();
    await result.when(
      onError: (_) async {},
      onSuccess: (context) async {
        await _prefsManager.saveFrontendContext(context);
      },
    );
  }

  void _applyBranding(FrontendContextData context) {
    AppColors.applyBranding(
      primaryColorHex: context.brandingPrimaryColor,
      secondaryColorHex: context.brandingSecondaryColor,
      accentColorHex: context.brandingAccentColor,
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
