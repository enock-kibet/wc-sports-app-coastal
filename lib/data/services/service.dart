import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/error/error_handler.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/addresses/address.dart';
import 'package:sports_app/data/models/addresses/pickupaddress.dart';
import 'package:sports_app/data/models/club/club.dart';
import 'package:sports_app/data/models/match/match-recarp.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/models/multiple_results/multiple_result.dart';
import 'package:sports_app/data/models/points/points.dart';
import 'package:sports_app/data/models/products/cart.dart';
import 'package:sports_app/data/models/products/product.dart';
import 'package:sports_app/data/models/roaster/roaster.dart';
import 'package:sports_app/data/models/stats/stat.dart';
import 'package:sports_app/data/models/teamstats/teamstats.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/repository/geolocation_repository.dart';
import 'package:sports_app/localization/app_prefs.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/utils/dotted.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../models/notifications/notification.dart';
import '../models/media/media.dart';
import '../repository/auth_repository.dart';
part 'local.dart';
part 'http_client.dart';
part 'client.dart';

GetIt service = GetIt.asNewInstance();

setUpService() {
  //Setup Talker logger
  service.registerLazySingleton<Talker>(() {
    final talker = TalkerFlutter.init(
      settings: TalkerSettings(),
    );
    talker.verbose('Talker initialization completed');
    return talker;
  });
  service.registerLazySingleton<AppPreferencesManager>(
      () => AppPreferencesManager());
  service.registerLazySingleton<ProductService>(() => ProductService());
  service.registerLazySingleton<MatchService>(() => MatchService());
  service.registerLazySingleton<StatService>(() => StatService());
  service.registerLazySingleton<RoasterService>(() => RoasterService());
  service.registerLazySingleton<TeamStatsService>(() => TeamStatsService());
  service.registerLazySingleton<ProfileService>(() => ProfileService());
  service.registerLazySingleton<AuthService>(() => AuthService());
  service.registerLazySingleton<StripeService>(() => StripeService());
  service
      .registerLazySingleton<NotificationService>(() => NotificationService());
  service.registerLazySingleton<MediaService>(() => MediaService());
  service.registerLazySingleton<CartService>(() => CartService());
  service.registerLazySingleton<AddressService>(() => AddressService());
  service.registerLazySingleton<PointsService>(() => PointsService());
  service.registerLazySingleton<PickupAddressService>(
      () => PickupAddressService());
  service.registerLazySingleton<GeolocationRepository>(
      () => GeolocationRepository());
  service.registerLazySingleton<AuthRepository>(() =>
      AuthRepository(service<AuthService>(), service<AppPreferencesManager>()));
}
