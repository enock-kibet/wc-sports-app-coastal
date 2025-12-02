part of 'service.dart';

class ProductService {
  HttpResult<List<Product>> getProducts() async {
    return Http.get(
      "https://backend.wencetechnologies.com/SportApp/api/Product",
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
      "https://backend.wencetechnologies.com/sportapp/api/Match/a571e8a5-8096-4ac3-bdd3-3dd7b623cbe6/df6fb842-329d-4924-a7b3-6e56177a229c?playStatus=false&fromNow=true",
      deserializer: (data) {
        List<MatchType> matchList = [];

        for (var record in data["data"]) {
          try {
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

  HttpResult<List<MatchType>> getMatchStats() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Match/a571e8a5-8096-4ac3-bdd3-3dd7b623cbe6/df6fb842-329d-4924-a7b3-6e56177a229c?playStatus=true",
      deserializer: (data) {
        List<MatchType> matchList = [];

        for (var record in data["data"]) {
          try {
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
}

class AuthService {
  HttpResult<dynamic> login(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/emaillogin?email=${data["email"]}&password=${data["password"]}",
      //"https://wencesportswebapplication.vercel.app/api/auth/emaillogin",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
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
      // "https://wencesportswebapplication.vercel.app/api/auth/emailSignUp",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }

  HttpResult<dynamic> verifyOtp(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/verifyEmail?otp=${data["otp"]}&email=${data["email"]}",
      // "https://wencesportswebapplication.vercel.app/api/auth/verifyEmail",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }

  HttpResult<dynamic> googleLogin(Map<String, dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/googlelogin",
      //"https://wencesportswebapplication.vercel.app/api/auth/googleSignIn",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
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
        "https://backend.wencetechnologies.com/SportApp/api/MediaItem",
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

  HttpResult<List<HighlightReel>> getHomeMedia() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/MediaItem/GetMediaById?teamid=a571e8a5-8096-4ac3-bdd3-3dd7b623cbe6",
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

class StatService {
  HttpResult<Map<String, List<Stats>>> getStats() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/PlayerStat/RankStats/155f166c-320c-47f0-9d26-10d89b6587c1?clubid=a571e8a5-8096-4ac3-bdd3-3dd7b623cbe6&minGames=0",
      deserializer: (data) {
        final Map<String, List<Stats>> statsByCategory = {};

        // each key is like "Field Goal", "Free Throw", etc.
        (data as Map<String, dynamic>).forEach((category, entries) {
          statsByCategory[category] =
              (entries as List).map((entry) => Stats.fromJson(entry)).toList();
        });

        return statsByCategory;
      },
    );
  }

  HttpResult<List<PlayerStatResponse>> getPlayerStats(String playerID) async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/PlayerStat/PlayerStatsbyMatch/$playerID/",
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
      "https://backend.wencetechnologies.com/sportapp/api/MediaItem/GetMediaById?teamid=a571e8a5-8096-4ac3-bdd3-3dd7b623cbe6/$playerID/",
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

class RoasterService {
  HttpResult<List<RoasterData>> getRoasters() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/Player/teamplayers/a571e8a5-8096-4ac3-bdd3-3dd7b623cbe6?seasonid=df6fb842-329d-4924-a7b3-6e56177a229c",
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

class TeamStatsService {
  HttpResult<List<TeamStatsData>> getTeamStats() async {
    return Http.get(
      "https://backend.wencetechnologies.com/sportapp/api/TeamStanding/df6fb842-329d-4924-a7b3-6e56177a229c/96244279-5975-4530-a663-f24f5c33fd30",
      deserializer: (data) {
        // Extract the list from the API response
        final standings = (data['data'] as List)
            .map((json) => TeamStatsData.fromJson(json))
            .toList();

        return standings;
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
