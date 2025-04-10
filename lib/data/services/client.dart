part of 'service.dart';

class ProductService {
  HttpResult<List<Product>> getProducts() async {
    return Http.get(
      "https://backend.wencetechnologies.com/SportApp/api/Product",
      //"https://wencesportswebapplication.vercel.app/api/shop/products",
      deserializer: (data) {
        List<Product> productList = [];
        for (var record in data["data"]) {
          try{
            Product product = Product.fromJson(record);
            productList.add(product);
          }catch(e){
            service<Talker>().error("Error parsing product record: $e");
          }
        }
        return productList;
      },
    );
  }
  HttpResult<String> productPayment(Map<String,dynamic> data)async {
    return Http.post(
        'https://backend.wencetechnologies.com/SportApp/api/Order/makepayments',
        data,
      deserializer: (data)=>data["authorizationUrl"]
    );
  }
}



class MatchService {
  HttpResult<List<MatchType>> getMatches() async {
    return Http.get(
      "https://backend.wencetechnologies.com/SportApp/api/Match",
      deserializer: (data){
        List<MatchType> matchList = [];

        for (var record in data["data"]) {
          try {
            // Extracting the first match date if available
            String? matchDateString = (record["matchDates"] as List).isNotEmpty
                ? record["matchDates"][0]["date"]
                : null;

            MatchType match = MatchType(
              matchId: record["id"] ?? "Unknown ID",
              teamOne: record["clubOne"]?["name"] ?? "Unknown Team",
              teamTwo: record["clubTwo"]?["name"] ?? "Unknown Team",
              matchName: record["name"] ?? "Unnamed Match",
              matchDescription: record["description"]?? "No Description",
              matchDate: matchDateString != null
                  ? DateTime.tryParse(matchDateString) ?? DateTime.now()
                  : DateTime.now(),
              matchVenue: record["venue"]?["name"] ?? "Unknown Venue",
              matchLocation: record["venue"]?["location"] ?? "Unknown Location",
              matchPrice: getRandomMultipleOf50()?.toDouble() ?? 50.0,
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
  HttpResult<dynamic> login(Map<String,dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/emaillogin?email=${data["email"]}&password=${data["password"]}",
      //"https://wencesportswebapplication.vercel.app/api/auth/emaillogin",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }

  HttpResult<dynamic> signup(Map<String,dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/sign-up?name=${data["name"]}&email=${data["email"]}&password=${data["password"]}&confirmpassword=${data["password"]}",
      // "https://wencesportswebapplication.vercel.app/api/auth/emailSignUp",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }
  HttpResult<dynamic> verifyOtp(Map<String,dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/verifyEmail?otp=${data["otp"]}&email=${data["email"]}",
      // "https://wencesportswebapplication.vercel.app/api/auth/verifyEmail",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }
  HttpResult<dynamic> googleLogin(Map<String,dynamic> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/googlelogin",
      //"https://wencesportswebapplication.vercel.app/api/auth/googleSignIn",
      data,
      deserializer: (data) => User.fromJson(data["user"]),
    );
  }
  HttpResult<String> resendOtp(Map<String,dynamic> data) async {
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
      {
        "email":email,
        "price":price

      },
      deserializer: (data) => data["data"],
    );
  }
}

class ProfileService {
  HttpResult<dynamic> getMe( ) async {
    return Http.get(
      "auth/me",
      deserializer: (data) => data["user"],
    );
  }
  HttpResult<User> updateProfilePicture(FormData data) async {
    return Http.post(
      "https://wencesportswebapplication.vercel.app/api/auth/uploadthing",
      data,
      deserializer: (data)=>User.fromJson(data["user"]),
    );
  }
  HttpResult<User> updateProfileLink(Map<String,String> data) async {
    return Http.post(
      "https://backend.wencetechnologies.com/SportApp/api/User/updatePic",
      data,
      deserializer: (data)=>User.fromJson(data["user"]),
    );
  }
}