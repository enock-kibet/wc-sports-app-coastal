import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/models/products/product.dart';

import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/auth/onboarding.dart';
import 'package:sports_app/features/auth/otp_page.dart';
import 'package:sports_app/features/auth/sign_up_page.dart';
import 'package:sports_app/features/dashboard/pages/about/about_us.dart';
import 'package:sports_app/features/dashboard/pages/home/match_details_page.dart';
import 'package:sports_app/features/dashboard/pages/media/team_media_page.dart';
import 'package:sports_app/features/dashboard/pages/notifications/notification_page.dart';
import 'package:sports_app/features/dashboard/pages/points/points_page.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/edit_profile.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/personal_details.dart';
import 'package:sports_app/features/dashboard/pages/profile/profile_page.dart';
import 'package:sports_app/features/dashboard/pages/schedule/schedule_page.dart';
import 'package:sports_app/features/dashboard/pages/shop/shop_item_details_page.dart';
import 'package:sports_app/features/dashboard/pages/standings/standinds_page.dart';
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
  profileDetails,
  editProfile,
  onboarding,
  signUp,
  signIn,
  otp,
  help,
  aboutUs,
  pointsManagement,
  paymentWebView
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

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: "/home",
  observers: [TalkerRouteObserver(service<Talker>())],
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
      path: "/notifications",
      name: AppRoute.notifications.name,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: NotificationPage(
            key: state.pageKey,
          ),
        );
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
                      return MaterialPage(
                        child: MatchDetailsPage(
                          match: state.extra as MatchType,
                          key: state.pageKey,
                        ),
                      );
                    },
                  )
                ])
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
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
                      return  MaterialPage(
                        child: ShopDetailsPage(
                          product: state.extra as Product,
                          key: state.pageKey,
                        ),
                      );
                    },
                    routes: []
                  ),
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
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
            
            routes: [
              GoRoute(
                path: "/team",
                name: AppRoute.team.name,
                pageBuilder: (context,state){
                  return  MaterialPage(
                      child: TeamPage(
                        showBackNavigation: state.extra==null?false:true ,
                      )
                  );
                }
              ),
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
                    path: "pointsmanagement",
                    parentNavigatorKey: rootNavigatorKey,
                    name: AppRoute.pointsManagement.name,
                    builder: (context,state){
                      return const PointsPage();
                    }
                ),
                GoRoute(
                  path: "help",
                  parentNavigatorKey: rootNavigatorKey,
                  name: AppRoute.help.name,
                  builder: (context,state){
                    return const Help();
                  }
                ),
                GoRoute(
                  path: "aboutUs",
                  parentNavigatorKey:rootNavigatorKey,
                  name:AppRoute.aboutUs.name,
                  builder:(context,state){
                    return const AboutUs();
                  }
                ),
                GoRoute(
                  path: "details",
                  parentNavigatorKey: rootNavigatorKey,
                  name: AppRoute.profileDetails.name,
                  builder: (context, state) {
                    return const PersonalDetails();
                  },
                ),
              ]
            )
          ],
        ),
      ],
    ),
  ],
  refreshListenable: StreamToListenable([service<AppPreferencesManager>().stream]),
  redirect: (context,state){
    AuthenticationStatus authenticationStatus = service<AppPreferencesManager>().currentAuthStateValue;
    debugPrint(state.matchedLocation);
    if(authenticationStatus==AuthenticationStatus.firstTime){
      return "/onboarding";
    }
    if(authenticationStatus==AuthenticationStatus.notAuthenticated&&state.matchedLocation!="/signUp"){
      return "/signIn";
    }
    if(authenticationStatus==AuthenticationStatus.notAuthenticated&&state.matchedLocation=="/signUp"){
      return "/signUp";
    }
    if(authenticationStatus==AuthenticationStatus.notVerified){
      return "/otp";
    }
    if(authenticationStatus==AuthenticationStatus.verified && (state.matchedLocation=="/signUp"||state.matchedLocation=="/signIn" || state.matchedLocation=="/otp")){
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