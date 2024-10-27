import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/error/error_handler.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/multiple_results/multiple_result.dart';
import 'package:sports_app/data/repository/authentication.dart';
import 'package:sports_app/data/repository/geolocation_repository.dart';
import 'package:sports_app/localization/app_prefs.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
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
  service.registerLazySingleton<AppPreferences>(() => AppPreferences());
  service.registerLazySingleton<ProductService>(() => ProductService());
  service.registerLazySingleton<MatchService>(() => MatchService());
  service.registerLazySingleton<StripeService>(() => StripeService());
  service.registerLazySingleton<GeolocationRepository>(
      () => GeolocationRepository());
}
