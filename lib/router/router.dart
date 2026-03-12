import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/data/models/match/match-recarp.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/models/player/player.dart';
import 'package:sports_app/data/models/points/points.dart';
import 'package:sports_app/data/models/products/product.dart';
import 'package:sports_app/data/models/roaster/roaster.dart';

import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/auth/onboarding.dart';
import 'package:sports_app/features/auth/otp_page.dart';
import 'package:sports_app/features/auth/sign_up_page.dart';
import 'package:sports_app/features/dashboard/pages/about/about_us.dart';
import 'package:sports_app/features/dashboard/pages/home/match_details_page.dart';
import 'package:sports_app/features/dashboard/pages/media/media_page.dart';
import 'package:sports_app/features/dashboard/pages/media/team_media_page.dart';
import 'package:sports_app/features/dashboard/pages/notifications/notification_page.dart';
import 'package:sports_app/features/dashboard/pages/points/points_page.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/edit_profile.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/personal_details.dart';
import 'package:sports_app/features/dashboard/pages/profile/profile_page.dart';
import 'package:sports_app/features/dashboard/pages/schedule/schedule_page.dart';
import 'package:sports_app/features/dashboard/pages/shop/shop_item_details_page.dart';
import 'package:sports_app/features/dashboard/pages/splash_screen.dart';
import 'package:sports_app/features/dashboard/pages/standings/standinds_page.dart';
import 'package:sports_app/features/dashboard/pages/team/game-recarp.dart';
import 'package:sports_app/features/dashboard/pages/team/player/player.dart';
import 'package:sports_app/features/dashboard/pages/team/team.dart';
import 'package:sports_app/features/dashboard/pages/webview/paymentwebview.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../features/dashboard/base_screen.dart';
import '../features/dashboard/pages/help/help.dart';
import '../features/dashboard/pages/pages.dart';

enum AppRoute {
  team,
  splash,
  home,
  schedule,
  shop,
  shopDetails,
  matchDetails,
  profile,
  standings,
  notifications,
  teamMedia,
  media,
  profileDetails,
  editProfile,
  onboarding,
  signUp,
  signIn,
  otp,
  help,
  aboutUs,
  pointsManagement,
  paymentWebView,
  playerProfile
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    stream.listen((event) {
      debugPrint(event.toString());
      notifyListeners();
    });
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorAKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorBKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorCKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorDKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorEKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorFKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorGKey =
    GlobalKey<NavigatorState>();

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final RouteObserver<ModalRoute<void>> routeObserverB =
    RouteObserver<ModalRoute<void>>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: "/splash",
  observers: [TalkerRouteObserver(service<Talker>()), routeObserver],
  routes: [
    GoRoute(
      path: "/standing",
      name: AppRoute.standings.name,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: StandingPage(
            key: state.pageKey,
          ),
        );
      },
    ),
    GoRoute(
      path: "/onboarding",
      name: AppRoute.onboarding.name,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: Onboarding(
            key: state.pageKey,
          ),
        );
      },
    ),
    GoRoute(
      path: "/signUp",
      name: AppRoute.signUp.name,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: SignUpPage(
            key: state.pageKey,
          ),
        );
      },
    ),
    GoRoute(
      path: "/signIn",
      name: AppRoute.signIn.name,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: LoginPage(
            key: state.pageKey,
          ),
        );
      },
    ),
    GoRoute(
      path: "/otp",
      name: AppRoute.otp.name,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: OtpPage(
            key: state.pageKey,
          ),
        );
      },
    ),
    GoRoute(
      path: "/teammedia",
      name: AppRoute.teamMedia.name,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: TeamMediaPage(
            key: state.pageKey,
          ),
        );
      },
    ),
    GoRoute(
      path: "/splash",
      name: AppRoute.splash.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: '/game-recap',
      builder: (context, state) {
        final match = state.extra as MatchModel;
        return GameRecapPage(match: match);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BaseScreen(
          key: state.pageKey,
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
                path: "/home",
                name: AppRoute.home.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: HomePage(
                      key: state.pageKey,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: "details",
                    parentNavigatorKey: rootNavigatorKey,
                    name: AppRoute.matchDetails.name,
                    pageBuilder: (context, state) {
                      final match = state.extra as MatchType;

                      return MaterialPage(
                        key: state.pageKey,
                        child: BlocProvider(
                          create: (context) => PointsBloc(),
                          child: MatchDetailsPage(match: match),
                        ),
                      );
                    },
                  ),
                ])
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          observers: [routeObserverB],
          routes: [
            GoRoute(
              path: "/schedule",
              name: AppRoute.schedule.name,
              pageBuilder: (context, state) {
                return const MaterialPage(
                  child: SchedulePage(),
                );
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
                path: "/shop",
                name: AppRoute.shop.name,
                pageBuilder: (context, state) {
                  return const MaterialPage(child: ShopPage());
                },
                routes: [
                  GoRoute(
                      path: "shopdetails",
                      parentNavigatorKey: rootNavigatorKey,
                      name: AppRoute.shopDetails.name,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          child: ShopDetailsPage(
                            product: state.extra as Product,
                            key: state.pageKey,
                          ),
                        );
                      },
                      routes: []),
                  GoRoute(
                    path: "paymentWebView",
                    name: AppRoute.paymentWebView.name,
                    parentNavigatorKey: rootNavigatorKey,
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        child: PaymentWebView(
                          paymentUrl: state.extra as String,
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                ])
          ],
        ),
        StatefulShellBranch(navigatorKey: _shellNavigatorDKey, routes: [
          GoRoute(
              path: "/team",
              name: AppRoute.team.name,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: TeamPage(
                  showBackNavigation: state.extra == null ? false : true,
                ));
              },
              routes: [
                GoRoute(
                  path: "playerProfile",
                  parentNavigatorKey: rootNavigatorKey,
                  name: AppRoute.playerProfile.name,
                  builder: (context, state) {
                    return PlayerPage(
                      player: state.extra as RoasterData,
                    );
                  },
                ),
              ]),
        ]),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEKey,
          routes: [
            GoRoute(
                path: "/profile",
                name: AppRoute.profile.name,
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: ProfilePage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: "edit",
                    parentNavigatorKey: rootNavigatorKey,
                    name: AppRoute.editProfile.name,
                    builder: (context, state) {
                      return const EditProfileMain();
                    },
                  ),
                  GoRoute(
                    path: "pointsManagement",
                    parentNavigatorKey: rootNavigatorKey,
                    name: AppRoute.pointsManagement.name,
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        key: state.pageKey,
                        child: BlocProvider(
                          create: (context) => PointsBloc(),
                          child: PointsPage(),
                        ),
                      );
                    },
                  ),
                  GoRoute(
                      path: "help",
                      parentNavigatorKey: rootNavigatorKey,
                      name: AppRoute.help.name,
                      builder: (context, state) {
                        return const Help();
                      }),
                  GoRoute(
                      path: "aboutUs",
                      parentNavigatorKey: rootNavigatorKey,
                      name: AppRoute.aboutUs.name,
                      builder: (context, state) {
                        return const AboutUs();
                      }),
                  GoRoute(
                    path: "details",
                    parentNavigatorKey: rootNavigatorKey,
                    name: AppRoute.profileDetails.name,
                    builder: (context, state) {
                      return const PersonalDetails();
                    },
                  ),
                ])
          ],
        ),
        StatefulShellBranch(navigatorKey: _shellNavigatorFKey, routes: [
          GoRoute(
            path: "/notifications",
            name: AppRoute.notifications.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: NotificationPage(),
              );
            },
          ),
        ]),
        StatefulShellBranch(navigatorKey: _shellNavigatorGKey, routes: [
          GoRoute(
            path: "/media",
            name: AppRoute.media.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: MediaPage(),
              );
            },
          ),
        ]),
      ],
    ),
  ],
  refreshListenable:
      StreamToListenable([service<AppPreferencesManager>().stream]),
  redirect: (context, state) {
    final appPrefs = service<AppPreferencesManager>();
    final AuthenticationStatus authenticationStatus =
        appPrefs.currentAuthStateValue;
    final hasSkippedLogin = appPrefs.hasSkippedLogin;
    final location = state.matchedLocation;
    final isPublicRoute = location == "/home" ||
        location.startsWith("/home/") ||
        location == "/schedule" ||
        location.startsWith("/schedule/") ||
        location == "/shop" ||
        location.startsWith("/shop/") ||
        location == "/team" ||
        location.startsWith("/team/") ||
        location == "/media" ||
        location.startsWith("/media/") ||
        location == "/standing" ||
        location.startsWith("/standing/") ||
        location == "/game-recap";
    final isAuthRoute = location == "/signIn" || location == "/signUp";
    final isProtectedRoute = location == "/otp" ||
        location.startsWith("/profile") ||
        location.startsWith("/notifications");

    debugPrint(state.matchedLocation);
    if (authenticationStatus == AuthenticationStatus.firstTime) {
      if (location == "/splash" ||
          location == "/onboarding" ||
          isPublicRoute ||
          isAuthRoute) {
        return null;
      }
      if (isProtectedRoute) return "/signIn";
      return "/home";
    }
    if (authenticationStatus == AuthenticationStatus.notAuthenticated) {
      if (location == "/splash") return hasSkippedLogin ? "/home" : "/signIn";
      if (isProtectedRoute) return "/signIn";
      if (hasSkippedLogin && (isPublicRoute || isAuthRoute)) return null;
      if (!hasSkippedLogin && isAuthRoute) return null;
      return hasSkippedLogin ? "/home" : "/signIn";
    }
    if (authenticationStatus == AuthenticationStatus.notVerified) {
      return "/otp";
    }
    if (authenticationStatus == AuthenticationStatus.verified &&
        (location == "/signUp" ||
            location == "/signIn" ||
            location == "/otp" ||
            location == "/onboarding" ||
            location == "/splash")) {
      return "/home";
    }
    return null;
  },
  errorPageBuilder: (context, state) {
    return CupertinoPage(
        child: Center(
      child: Text(state.error.toString()),
    ));
  },
);

class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var e in streams) {
      var s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}
