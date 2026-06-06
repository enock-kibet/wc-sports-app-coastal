part of 'service.dart';

class ProductService {
  HttpResult<List<Product>> getProducts() async {
    return Http.get(
      "https://backend.wencetechnologies.com/SportApp/api/Product?leagueid=9118399e-3371-4957-854d-fdb4c7fb31d5",
      //"https://wencesportswebapplication.vercel.app/api/shop/products",
      deserializer: (data) {
        List<Product> productList = [];
        for (var record in data["data"]) {
          try {
            Product product = Product.fromJson(record);
            productList.add(product);
          } catch (e) {
            service<Talker>().error("Error parsing product record: $e");
          }
        }
        return productList;
      },
    );
  }

  HttpResult<String> productPayment(Map<String, dynamic> data) async {
    return Http.post(
        'https://backend.wencetechnologies.com/SportApp/api/Order/makepayments',
        data,
        deserializer: (data) => data["authorizationUrl"]);
  }

  HttpResult<String> productsPayment(Map<String, dynamic> data) async {
    return Http.post(
        'https://backend.wencetechnologies.com/SportApp/api/Order/makebundledpayments',
        data,
        deserializer: (data) => data["authorizationUrl"]);
  }

  HttpResult<String> addToCart(Map<String, dynamic> data, String token) async {
    return Http.post(
      'https://backend.wencetechnologies.com/SportApp/api/Order/cart/add',
      data,
      headers: {
        'Authorization': 'Bearer $token',
      },
      deserializer: (responseData) {
        if (responseData["addedItems"].length > 0) {
          return "Product added to cart successfully";
        } else {
          service<Talker>().error(
              "Failed to add product to cart: ${responseData["message"]}");
          throw Exception(
              "Failed to add product to cart: ${responseData["message"]}");
        }
      },
    );
  }

  HttpResult<String> removeCart(Map<String, dynamic> data) async {
    return Http.post(
      'https://backend.wencetechnologies.com/SportApp/api/Order/cart/remove',
      data,
      deserializer: (responseData) {
        if (responseData["removedItems"].length > 0) {
          return "Product removed from cart successfully";
        } else {
          service<Talker>().error(
              "Failed to remove product from cart: ${responseData["message"]}");
          throw Exception(
              "Failed to remove product from cart: ${responseData["message"]}");
        }
      },
    );
  }

  HttpResult<String> clearCart(Map<String, dynamic> data) async {
    return Http.post(
      'https://backend.wencetechnologies.com/SportApp/api/Order/cart/clear',
      data,
      deserializer: (responseData) {
        if (responseData["addedItems"].length > 0) {
          return "Cart cleared successfully";
        } else {
          service<Talker>()
              .error("Failed to clear cart: ${responseData["message"]}");
          throw Exception("Failed to clear cart: ${responseData["message"]}");
        }
      },
    );
  }
}

class CartService {
  HttpResult<List<CartItem>> getCartItems() async {
    return Http.get(
      "https://backend.wencetechnologies.com/SportApp/api/Order/cart/view",
      deserializer: (data) {
        List<CartItem> cartList = [];
        for (var record in data["bundledItems"]) {
          try {
            CartItem cartItem = CartItem.fromJson(record);
            cartList.add(cartItem);
          } catch (e) {
            service<Talker>().error("Error parsing product record: $e");
          }
        }
        return cartList;
      },
    );
  }
}

class AddressService {
  HttpResult<List<Address>> getAddresses() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Order/cart/addresses",
      deserializer: (data) {
        List<Address> address = [];
        for (var record in data) {
          try {
            Address addressItem = Address.fromJson(record);
            address.add(addressItem);
          } catch (e) {
            service<Talker>().error("Error parsing address record: $e");
          }
        }
        return address;
      },
    );
  }

  HttpResult<String> addNewAddress(Map<String, dynamic> data) async {
    print('post response first');
    return Http.post(
      'https://backend.wencetechnologies.com/sportapp/api/Order/cart/addresses',
      data,
      options: Options(
        validateStatus: (status) => status != null && status < 300,
      ),
      deserializer: (responseData) {
        print(responseData);
        // if (responseData["addressId"]) {
        if (responseData != null) {
          return responseData;
        } else {
          print('post response doest show: $responseData');
          service<Talker>().error("Failed to add address: ${responseData}");
          throw Exception("Failed to add address: ${responseData}");
        }
      },
    );
  }
}

class PickupAddressService {
  Future<MultipleResult<List<PickupAddress>>> getPickupAddresses() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/pickup_points.json');
      final localJson = json.decode(jsonString);

      final List<PickupAddress> pickupAddress =
          (localJson as List).map((e) => PickupAddress.fromJson(e)).toList();

      List<PickupAddress> address = [];
      for (var record in pickupAddress) {
        try {
          PickupAddress addressItem = record;
          address.add(addressItem);
        } catch (e) {
          service<Talker>().error("Error parsing address record: $e");
        }
      }

      // 🔹 Wrap the result properly
      return MultipleResult.onSuccess(data: address);
    } catch (e, s) {
      service<Talker>().error("Error loading pickup addresses: $e\n$s");

      // ✅ Wrap error result (assuming Failure has a factory like Failure(message: ...))
      return MultipleResult.onError(
        error: Failure(error: "Error loading pickup addresses: $e\n$s"),
      );
    }
  }
}

class MatchService {
  HttpResult<List<MatchType>> getMatches() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Match?leagueid=9118399e-3371-4957-854d-fdb4c7fb31d5&playStatus=false&fromNow=true",
      deserializer: (data) {
        List<MatchType> matchList = [];

        for (final record in (data["data"] as List? ?? const [])) {
          try {
            final recap = _toMatchModel(record as Map<String, dynamic>);

            final match = MatchType(
              matchId: recap.id,
              teamOne: recap.clubOne.name,
              teamTwo: recap.clubTwo.name,
              matchName: recap.name,
              matchDescription: recap.description,
              matchDate: recap.matchDate.date,
              matchVenue: recap.venue.name,
              matchLocation: recap.venue.location,
              matchPrice: getRandomMultipleOf50()?.toDouble() ?? 50.0,
              teamOneScore: recap.clubOneScore,
              teamTwoScore: recap.clubTwoScore,
              recap: recap,
            );

            matchList.add(match);
          } catch (e) {
            print("Error parsing match record: $e");
          }
        }

        return matchList;
      },
    );
  }

  HttpResult<List<MatchType>> getMatchStats(String? clubId) async {
    final endpoint = (clubId == null || clubId.isEmpty)
        ? "https://backend.wencetechnologies.com/sportapp/api/Match?leagueid=9118399e-3371-4957-854d-fdb4c7fb31d5&playStatus=true&fromNow=false"
        : "https://backend.wencetechnologies.com/sportapp/api/Match/leagueMatches/$clubId/9118399e-3371-4957-854d-fdb4c7fb31d5";
    return Http.get(
      endpoint,
      deserializer: (data) {
        List<MatchType> matchList = [];

        for (var record in data["data"]) {
          try {
            final recap = _toMatchModel(record as Map<String, dynamic>);
            // Extracting the first match date if available
            String? matchDateString = (record["matchDate"] is Map &&
                    record["matchDate"]!.containsKey("date"))
                ? record["matchDate"]!["date"] as String
                : null;

            MatchType match = MatchType(
              matchId: record["id"] ?? "Unknown ID",
              teamOne: record["clubOne"]?["name"] ?? "Unknown Team",
              teamTwo: record["clubTwo"]?["name"] ?? "Unknown Team",
              matchName: record["name"] ?? "Unnamed Match",
              matchDescription: record["description"] ?? "No Description",
              matchDate: matchDateString != null
                  ? DateTime.tryParse(matchDateString) ?? DateTime.now()
                  : DateTime.now(),
              matchVenue: record["venue"]?["name"] ?? "Unknown Venue",
              matchLocation: record["venue"]?["location"] ?? "Unknown Location",
              matchPrice: getRandomMultipleOf50()?.toDouble() ?? 50.0,
              teamOneScore: record["clubOneScore"] ?? "0",
              teamTwoScore: record["clubTwoScore"] ?? "0",
              recap: recap,
            );

            matchList.add(match);
          } catch (e) {
            print("Error parsing match record: $e");
          }
        }

        return matchList;
      },
    );
  }

  /// ✅ Map JSON record -> MatchModel (with stats)
  MatchModel _toMatchModel(Map<String, dynamic> record) {
    final clubOneJson = (record["clubOne"] as Map<String, dynamic>? ?? {});
    final clubTwoJson = (record["clubTwo"] as Map<String, dynamic>? ?? {});
    final matchDateJson = (record["matchDate"] as Map<String, dynamic>? ?? {});
    final venueJson = (record["venue"] as Map<String, dynamic>? ?? {});
    final intervalScoresJson =
        (record["intervalscores"] as Map<String, dynamic>? ?? {});

    return MatchModel(
      id: (record["id"] ?? "").toString(),
      name: (record["name"] ?? "").toString(),
      description: (record["description"] ?? "").toString(),
      matchWinner: (record["matchWinner"] ?? "").toString(),
      clubOneScore: (record["clubOneScore"] ?? "0").toString(),
      clubTwoScore: (record["clubTwoScore"] ?? "0").toString(),
      matchStatus: (record["matchStatus"] ?? false) == true,
      clubOne: ClubModel(
        id: (clubOneJson["id"] ?? "").toString(),
        name: (clubOneJson["name"] ?? "").toString(),
        pic: (clubOneJson["pic"] ?? "").toString(),
        stats: _parseStats(clubOneJson["stats"]),
      ),
      clubTwo: ClubModel(
        id: (clubTwoJson["id"] ?? "").toString(),
        name: (clubTwoJson["name"] ?? "").toString(),
        pic: (clubTwoJson["pic"] ?? "").toString(),
        stats: _parseStats(clubTwoJson["stats"]),
      ),
      matchDate: MatchDateModel(
        id: (matchDateJson["id"] ?? "").toString(),
        date: DateTime.tryParse((matchDateJson["date"] ?? "").toString()) ??
            DateTime.now(),
      ),
      venue: VenueModel(
        id: (venueJson["id"] ?? "").toString(),
        name: (venueJson["name"] ?? "").toString(),
        location: (venueJson["location"] ?? "").toString(),
        latitude: _toDouble(venueJson["latitude"]),
        longitude: _toDouble(venueJson["longitude"]),
      ),
      intervalScores: _parseIntervalScores(intervalScoresJson["stats"]),
    );
  }

  List<StatModel> _parseStats(dynamic raw) {
    if (raw is! List) return const [];
    return raw.whereType<Map>().map((m) {
      final mm = Map<String, dynamic>.from(m);
      return StatModel(
        stat: (mm["stat"] ?? "").toString(),
        statValue: _toInt(mm["statValue"]),
      );
    }).toList();
  }

  List<IntervalScoreModel> _parseIntervalScores(dynamic raw) {
    if (raw is! List) return const [];
    return raw.whereType<Map>().map((m) {
      final mm = Map<String, dynamic>.from(m);
      return IntervalScoreModel(
        sequencePosition: _toInt(mm["sequencePosition"]),
        interval: (mm["interval"] ?? "").toString(),
        clubOne: (mm["clubOne"] ?? "").toString(),
        homeTeamScore: (mm["homeTeamScore"] ?? "0").toString(),
        clubTwo: (mm["clubTwo"] ?? "").toString(),
        awayTeamScore: (mm["awayTeamScore"] ?? "0").toString(),
      );
    }).toList();
  }

  double _toDouble(dynamic v) {
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  int _toInt(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }
}

class AuthService {
  User _deserializeUserResponse(dynamic responseData,
      {required String action}) {
    if (responseData is! Map) {
      service<Talker>().error(
        "Invalid $action response type: ${responseData.runtimeType}",
      );
      throw FormatException("Invalid $action response from server");
    }

    final dynamic userData = responseData["user"] ?? responseData["data"];
    if (userData is Map) {
      return User.fromJson(Map<String, Object?>.from(userData));
    }

    service<Talker>().error("Invalid $action payload: $responseData");
    final message = responseData["msg"] ??
        responseData["message"] ??
        "Invalid $action response from server";
    throw FormatException(message.toString());
  }

  HttpResult<dynamic> login(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/emaillogin?email=${data["email"]}&password=${data["password"]}",
      //"https://wencesportswebapplication.vercel.app/api/auth/emaillogin",
      data,
      deserializer: (data) => _deserializeUserResponse(data, action: "login"),
    );
  }

  HttpResult<dynamic> refreshToken(String token) async {
    return Http.post(
      "https://backend.wencetechnologies.com/sportapp/api/User/refresh?refreshToken=$token",
      //"https://wencesportswebapplication.vercel.app/api/auth/emaillogin",
      {
        "refreshToken": token,
      },
      deserializer: (data) => data["accessToken"],
    );
  }

  HttpResult<dynamic> signup(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/sign-up?name=${data["name"]}&email=${data["email"]}&password=${data["password"]}&confirmpassword=${data["password"]}",
      //"https://wencesportswebapplication.vercel.app/api/auth/emaillogin",
      data,
      deserializer: (data) => _deserializeUserResponse(data, action: "signup"),
    );
  }

  // HttpResult<dynamic> signup(Map<String, dynamic> data) async {
  //   return Http.post(
  //     "https://backend.wencetechnologies.com/SportApp/api/User/sign-up?name=${data["name"]}&email=${data["email"]}&password=${data["password"]}&confirmpassword=${data["password"]}",
  //     data,
  //     deserializer: (responseData) {
  //       print(responseData);
  //       if (responseData != null) {
  //         return responseData;
  //       } else {
  //         print('post response doest show: $responseData');
  //         service<Talker>().error("Failed to register user: ${responseData}");
  //         throw Exception("Failed to register user: ${responseData}");
  //       }
  //     },
  //   );
  // }

  HttpResult<dynamic> verifyOtp(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/verifyEmail?otp=${data["otp"]}&email=${data["email"]}",
      // "https://wencesportswebapplication.vercel.app/api/auth/verifyEmail",
      data,
      deserializer: (data) =>
          _deserializeUserResponse(data, action: "OTP verification"),
    );
  }

  HttpResult<dynamic> googleLogin(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/googlelogin",
      //"https://wencesportswebapplication.vercel.app/api/auth/googleSignIn",
      data,
      deserializer: (data) =>
          _deserializeUserResponse(data, action: "Google login"),
    );
  }

  HttpResult<dynamic> appleLogin(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/sportapp/api/User/applelogin",
      //"https://wencesportswebapplication.vercel.app/api/auth/googleSignIn",
      data,
      deserializer: (data) =>
          _deserializeUserResponse(data, action: "Apple login"),
    );
  }

  HttpResult<String> resendOtp(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/generate-otp?email=${data["email"]}",
      // "https://wencesportswebapplication.vercel.app/api/auth/resendOtp",
      data,
      deserializer: (data) => data["msg"],
    );
  }

  HttpResult<String> logout() async {
    return Http.post(
      "https://wencesportswebapplication.vercel.app/api/auth/sign-out",
      {},
      deserializer: (data) => data["msg"],
    );
  }

  HttpResult<String> deleteMe() async {
    return Http.post(
      "https://backend.wencetechnologies.com/sportapp/api/User/deleteme",
      {},
      deserializer: (data) {
        if (data is Map<String, dynamic>) {
          return (data["msg"] ?? data["message"] ?? "Profile deleted")
              .toString();
        }
        return "Profile deleted";
      },
    );
  }
}

class StripeService {
  HttpResult<dynamic> getStripe({
    required String email,
    required int price,
  }) async {
    return Http.post(
      "pay/stripe/create",
      {"email": email, "price": price},
      deserializer: (data) => data["data"],
    );
  }
}

class ProfileService {
  HttpResult<dynamic> getMe() async {
    return Http.get(
      "auth/me",
      deserializer: (data) => data["user"],
    );
  }

  HttpResult<User> updateProfilePicture(FormData data) async {
    return Http.post(
      "https://wencesportswebapplication.vercel.app/api/auth/uploadthing",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }

  HttpResult<User> updateProfile(Map<String, String> data) async {
    print('datas: $data');
    return Http.post(
      "https://backend.wencetechnologies.com/sportapp/api/User/updateProfile",
      data,
      deserializer: (responseData) {
        print('Response Data: $responseData');

        if (responseData == null || responseData["user"] == null) {
          service<Talker>().error("Failed to update profile: $responseData");
          throw Exception("Failed to update: $responseData");
        }

        return User.fromJson(responseData["user"]);
      },
    );
  }

  HttpResult<User> updateProfileLink(Map<String, String> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/updatePic",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }
}

class NotificationService {
  HttpResult<List<Notifications>> getNotifications() async {
    return Http.get(
      "https://backend.wencetechnologies.com/SportApp/api/Notification",
      deserializer: (data) {
        List<Notifications> notificationList = [];
        for (var record in data) {
          // ✅ remove ["data"]
          try {
            Notifications notification = Notifications.fromJson(record);
            notificationList.add(notification);
          } catch (e) {
            service<Talker>().error("Error parsing notification record: $e");
          }
        }
        return notificationList;
      },
    );
  }
}

class MediaService {
  Future<MultipleResult<List<MediaData>>> getMedia() async {
    try {
      // Load local JSON
      final jsonString =
          await rootBundle.loadString('assets/data/media_data.json');
      final localJson = json.decode(jsonString);

      // Parse local highlights
      final List<Highlight> localHighlights =
          (localJson['recentHighlights'] as List)
              .map((e) => Highlight.fromJson(e))
              .toList();

      // Parse local season highlights
      final List<SeasonHighlight> localSeasonHighlights =
          (localJson['seasonHighlights'] as List)
              .map((e) => SeasonHighlight.fromJson(e))
              .toList();

      // API call
      return await Http.get<List<MediaData>>(
        "https://backend.wencetechnologies.com/sportapp/api/MediaItem?leagueid=9118399e-3371-4957-854d-fdb4c7fb31d5",
        deserializer: (data) {
          try {
            // Parse API highlights
            final List<SeasonHighlight> apiHighlights =
                (data['highlightReels'] as List)
                    .map((e) => SeasonHighlight.fromJson(e))
                    .toList();

            // Merge both highlight lists
            final List<SeasonHighlight> mergedHighlights = [
              ...apiHighlights,
              ...localSeasonHighlights,
            ];

            return [
              MediaData(
                recentHighlights: localHighlights,
                seasonHighlights: mergedHighlights,
              )
            ];
          } catch (e, st) {
            service<Talker>().error("❌ Error parsing media record: $e");
            debugPrintStack(stackTrace: st);

            // fallback → only local data
            return [
              MediaData(
                recentHighlights: localHighlights,
                seasonHighlights: localSeasonHighlights,
              )
            ];
          }
        },
      );
    } catch (e, st) {
      service<Talker>().error("❌ Failed to get media: $e");
      debugPrintStack(stackTrace: st);

      FirebaseCrashlytics.instance.recordError(
        e,
        st,
        reason: 'Error parsing media record',
        fatal: false,
      );

      // Return a failed MultipleResult
      return MultipleResult.onError(
        error: Failure(error: "Failed to load media"),
      );
    }
  }

  Future<MultipleResult<List<HighlightReel>>> getHomeMedia() async {
    try {
      return await Http.get(
        "https://backend.wencetechnologies.com/sportapp/api/Bannnermedium?leagueid=9118399e-3371-4957-854d-fdb4c7fb31d5",
        deserializer: (data) {
          final Map<String, dynamic> json = data as Map<String, dynamic>;
          final response = HighlightReelsResponse.fromJson(json);
          return response.highlightReels;
        },
      );
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: "getHomeMedia failed",
        fatal: false,
      );

      // Return a failed HttpResult so the UI doesn't crash
      return HttpResult.error("Failed to load media: $e");
    }
  }
}

class RoasterService {
  HttpResult<List<RoasterData>> getRoasters(String? clubid) async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Player/teamplayers/$clubid",
      deserializer: (data) {
        // Extract the list from the API response
        final players = (data['data'] as List)
            .map((json) => RoasterData.fromJson(json))
            .toList();

        return players;
      },
    );
  }

  HttpResult<List<ClubRoasterData>> getLeagueRoasters() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Club?leagueId=9118399e-3371-4957-854d-fdb4c7fb31d5",
      deserializer: (data) {
        log(data.runtimeType.toString()); // 👈 debug once

        final teams = (data as List)
            .map((json) => ClubRoasterData.fromJson(json))
            .toList();

        return teams;
      },
    );
  }

  HttpResult<List<RoasterData>> getTeamRoasters() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Club?leagueId=9118399e-3371-4957-854d-fdb4c7fb31d5",
      deserializer: (data) {
        // Extract the list from the API response
        final players = (data['data'] as List)
            .map((json) => RoasterData.fromJson(json))
            .toList();

        return players;
      },
    );
  }
}

class StatService {
  HttpResult<Map<String, List<Stats>>> getStats(String? clubId) async {
    final clubQuery =
        (clubId == null || clubId.isEmpty) ? "" : "&clubid=$clubId";
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/PlayerStat/RankStats/155f166c-320c-47f0-9d26-10d89b6587c1?minGames=0$clubQuery",
      deserializer: (data) {
        final Map<String, List<Stats>> statsByCategory = {};
        final root = data as Map<String, dynamic>;
        final dynamic source =
            root['data'] is Map<String, dynamic> ? root['data'] : root;

        // Each category key maps to a list of player leaderboard entries.
        (source as Map<String, dynamic>).forEach((category, entries) {
          if (entries is! List) return;

          final parsedEntries = entries
              .whereType<Map<String, dynamic>>()
              .map((entry) => Stats.fromJson(entry))
              .toList()
            ..sort((a, b) => a.rank.compareTo(b.rank));

          if (parsedEntries.isNotEmpty) {
            statsByCategory[category] = parsedEntries;
          }
        });

        return statsByCategory;
      },
    );
  }

  HttpResult<Map<String, Map<String, List<MatchStatLeader>>>>
      getMatchStatLeaders(
    String matchId,
  ) async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/PlayerStat/PlayerStatRanksByMatch/$matchId",
      deserializer: (data) {
        final leadersByCategory =
            <String, Map<String, List<MatchStatLeader>>>{};

        (data as Map<String, dynamic>).forEach((category, clubs) {
          final leadersByClub = <String, List<MatchStatLeader>>{};

          (clubs as Map<String, dynamic>).forEach((clubName, entries) {
            final leaders = (entries as List<dynamic>)
                .map((entry) =>
                    MatchStatLeader.fromJson(entry as Map<String, dynamic>))
                .toList()
              ..sort((a, b) {
                final rankCompare = a.rank.compareTo(b.rank);
                if (rankCompare != 0) return rankCompare;
                return b.stat.compareTo(a.stat);
              });

            leadersByClub[clubName] = leaders;
          });

          leadersByCategory[category] = leadersByClub;
        });

        return leadersByCategory;
      },
    );
  }

  HttpResult<List<PlayerStatResponse>> getPlayerStats(String playerID) async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/PlayerStat/PlayerStatsbyMatch/$playerID/?seasonid=155f166c-320c-47f0-9d26-10d89b6587c1",
      deserializer: (data) {
        // The response is a list of matches
        final List<dynamic> rawList = data as List<dynamic>;

        final List<PlayerStatResponse> stats = rawList
            .map((entry) =>
                PlayerStatResponse.fromJson(entry as Map<String, dynamic>))
            .toList();

        return stats;
      },
    );
  }

  HttpResult<List<HighlightReel>> getPlayerMedia(String playerID) async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/MediaItem/GetMediaById?teamid=804f0bac-11f1-4981-b67f-51f33efe1d5d/$playerID/",
      deserializer: (data) {
        final Map<String, dynamic> json = data as Map<String, dynamic>;

        // ✅ Deserialize the wrapper first
        final response = HighlightReelsResponse.fromJson(json);

        // ✅ Extract and return just the list
        return response.highlightReels;
      },
    );
  }
}

class TeamStatsService {
  HttpResult<List<TeamStatsData>> getTeamStats() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/TeamStanding/6e068c30-e77e-48d3-bc45-a7879b558698/9118399e-3371-4957-854d-fdb4c7fb31d5",
      deserializer: (data) {
        final standingsPayload =
            data is Map<String, dynamic> ? data['data'] : data;
        if (standingsPayload is! List) return <TeamStatsData>[];

        return standingsPayload
            .whereType<Map<String, dynamic>>()
            .map(TeamStatsData.fromJson)
            .toList();
      },
    );
  }
}

class PointsService {
  HttpResult<dynamic> addPoints(Map<String, String> data, String token) async {
    // print('datas: $data');
    return Http.post(
      "https://backend.wencetechnologies.com/sportapp/api/Point/loyalty/earn",
      data,
      headers: {
        'Authorization': 'Bearer $token',
      },
      deserializer: (responseData) {
        if (responseData == null) {
          service<Talker>().error("Something went wrong");
          throw Exception("Something went wrong");
        }

        return responseData;
      },
    );
  }

  HttpResult<dynamic> transferPoints(
    Map<String, String> data,
    String token,
  ) async {
    final result = await Http.post(
      "https://backend.wencetechnologies.com/sportapp/api/Point/loyalty/transfer",
      data,
      headers: {
        'Authorization': 'Bearer $token',
      },
      deserializer: (responseData, {int? statusCode}) {
        if (statusCode != null) {
          print('Status code: $statusCode');
        }

        if (responseData == null) {
          service<Talker>().error("Something went wrong (status $statusCode)");
          throw Exception("Something went wrong");
        }

        return responseData;
      },
    );

    return result;
  }

  HttpResult<List<PointsData>> getPoints() async {
    try {
      // Load local JSON
      return Http.get(
        "https://backend.wencetechnologies.com/sportapp/api/Point/loyalty/transactions?page=1&pageSize=50",
        deserializer: (responseData) {
          // print('Response Data: $responseData');

          if (responseData == null) {
            service<Talker>().error("Failed to add points: $responseData");
            throw Exception("Failed to update: $responseData");
          }

          final points = (responseData as List)
              .map((json) => PointsData.fromJson(json))
              .toList();

          return points;
        },
      );
    } catch (e, st) {
      service<Talker>().error("❌ Failed to get points: $e");
      debugPrintStack(stackTrace: st);

      FirebaseCrashlytics.instance.recordError(
        e,
        st,
        reason: 'Error parsing points record',
        fatal: false,
      );

      // Return a failed MultipleResult
      return MultipleResult.onError(
        error: Failure(error: "Failed to load points"),
      );
    }
  }

  HttpResult<dynamic> getPointsBalance() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Point/loyalty/wallet",
      deserializer: (data) => data["balance"],
    );
  }
}
