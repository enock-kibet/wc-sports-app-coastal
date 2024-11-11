part of 'service.dart';

class ProductService {
  HttpResult<List<dynamic>> getProducts() async {
    return Http.get(
      "products",
      deserializer: (data) => data["data"],
    );
  }
}

class MatchService {
  HttpResult<List<dynamic>> getMatches() async {
    return Http.get(
      "matches",
      deserializer: (data) => data["data"],
    );
  }
}

class AuthService {
  HttpResult<String> login(Map<String,dynamic> data) async {
    return Http.post(
      "auth/login",
      data,
      deserializer: (data) => data["session"],
    );
  }

  HttpResult<String> signup(Map<String,dynamic> data) async {
    return Http.post(
      "auth/sign-up",
      data,
      deserializer: (data) => data["session"],
    );
  }

  HttpResult<String> logout() async {
    return Http.post(
      "auth/sign-out",
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