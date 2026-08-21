part of 'service.dart';

class ProductService {
  FrontendCheckoutResult? latestCheckoutResult;

  HttpResult<List<Product>> getProducts() async {
    return Http.get(
      _frontendShopProductsBase,
      queryParams: {'per_page': 50},
      deserializer: (data) {
        return _extractDataList(data).map(_mapFrontendShopProduct).toList();
      },
    );
  }

  Future<MultipleResult<List<Map<String, dynamic>>>> getAvailableTicketTypes(
    String matchId,
  ) async {
    final response = await Http.get<List<Map<String, dynamic>>>(
      _frontendShopTicketTypesBase,
      queryParams: {
        ..._frontendContextPayload(),
        'match_id': matchId,
        'status': 'active',
        'per_page': 20,
      },
      deserializer: (data) => _extractDataList(data),
    );

    if (response is Error<List<Map<String, dynamic>>>) {
      return MultipleResult.onError(error: response.error);
    }

    final ticketTypes = (response as Success<List<Map<String, dynamic>>>)
        .data
        .map((record) => Map<String, dynamic>.from(record))
        .where((record) {
      final remaining = record['remaining_quantity'];
      return remaining == null || _toIntValue(remaining) > 0;
    }).toList()
      ..sort(
        (a, b) =>
            _toDoubleValue(a['price']).compareTo(_toDoubleValue(b['price'])),
      );

    if (ticketTypes.isEmpty) {
      return MultipleResult.onError(
        error: Failure(error: "No tickets are available for this match yet."),
      );
    }

    return MultipleResult.onSuccess(data: ticketTypes);
  }

  Future<MultipleResult<Map<String, dynamic>>> getPreferredTicketType(
    String matchId,
  ) async {
    final response = await getAvailableTicketTypes(matchId);
    return response.when(
      onError: (error) => MultipleResult.onError(error: error),
      onSuccess: (ticketTypes) =>
          MultipleResult.onSuccess(data: ticketTypes.first),
    );
  }

  HttpResult<FrontendPromotionValidationResult> validatePromotionCode({
    required String code,
    required double amount,
    String? clubId,
  }) async {
    return Http.post(
      _frontendShopPromotionsValidateBase,
      {
        ..._frontendContextPayload(),
        'code': code.trim(),
        'amount': amount,
        if (_stringOrNull(clubId) != null) 'club_id': clubId,
      },
      deserializer: (responseData) {
        final payload = _extractDataMap(responseData);
        final data = _mapOrEmpty(payload['data']);
        final promotion = _mapOrEmpty(data['promotion']);
        final summary = _mapOrEmpty(data['summary']);

        return FrontendPromotionValidationResult(
          code: _pickText(
            promotion,
            ['code'],
            fallback: code.trim(),
          ),
          name: _pickText(
            promotion,
            ['name'],
            fallback: 'Promotion',
          ),
          description: _pickText(promotion, ['description']),
          type: _pickText(promotion, ['type']),
          value: _toDoubleValue(promotion['value']),
          status: _pickText(promotion, ['status']),
          amount: _toDoubleValue(summary['amount']),
          discountAmount: _toDoubleValue(summary['discount_amount']),
          finalAmount: _toDoubleValue(summary['final_amount']),
          currency: _pickText(summary, ['currency'], fallback: 'KES'),
        );
      },
    );
  }

  HttpResult<FrontendCheckoutResult> productPayment(
      Map<String, dynamic> data) async {
    latestCheckoutResult = null;
    final redeemablePoints = _toIntValue(data['redeemablePoints']);
    final currentUser = service<AppPreferencesManager>().currentUserValue;
    if (currentUser == null || currentUser.email.isEmpty) {
      return MultipleResult.onError(
        error: Failure(error: "Please sign in to continue checkout."),
      );
    }

    final referencesResponse = await _resolveBuyNowSelections(data);
    if (referencesResponse is Error<List<Map<String, dynamic>>>) {
      return MultipleResult.onError(error: referencesResponse.error);
    }
    final references =
        (referencesResponse as Success<List<Map<String, dynamic>>>).data;

    final cartResponse = await _loadFrontendCart();
    if (cartResponse is Error<Map<String, dynamic>>) {
      return MultipleResult.onError(error: cartResponse.error);
    }

    final existingItems = _listOrEmpty(
      (cartResponse as Success<Map<String, dynamic>>).data['items'],
    );
    if (existingItems.isNotEmpty) {
      return MultipleResult.onError(
        error: Failure(
          error:
              "Your cart already has items. Please checkout from cart or clear it first.",
        ),
      );
    }

    for (final reference in references) {
      final result = await Http.post(
        _frontendShopCartItemsBase,
        {
          ..._frontendContextPayload(),
          'reference_type': _pickText(
            reference,
            ['reference_type'],
            fallback: 'product_variant',
          ),
          'reference_uuid': _pickText(
            reference,
            ['reference_uuid', 'variantID', 'variantId', 'productTypeID'],
          ),
          'quantity': _toIntValue(reference['quantity']),
        },
        deserializer: (responseData) => responseData,
      );

      if (result is Error<dynamic>) {
        return MultipleResult.onError(error: result.error);
      }
    }

    return _initializeFrontendCheckout(
      email: currentUser.email,
      addressId: _stringOrNull(data['addressId'] ?? data['deliveryAddressId']),
      redeemPoints: redeemablePoints > 0 ? redeemablePoints : null,
      promotionCode: _stringOrNull(data['promotionCode']),
    );
  }

  HttpResult<FrontendCheckoutResult> productsPayment(
      Map<String, dynamic> data) async {
    latestCheckoutResult = null;
    final currentUser = service<AppPreferencesManager>().currentUserValue;
    if (currentUser == null || currentUser.email.isEmpty) {
      return MultipleResult.onError(
        error: Failure(error: "Please sign in to continue checkout."),
      );
    }

    final bundledOrders = _listOrEmpty(data['bundledOrders']);
    String? addressId;
    for (final order in bundledOrders.whereType<Map>()) {
      final candidate = _stringOrNull(order['deliveryAddressId']);
      if (candidate != null) {
        addressId = candidate;
        break;
      }
    }

    return _initializeFrontendCheckout(
      email: currentUser.email,
      addressId: addressId,
      redeemPoints: _toIntValue(data['redeemablePoints']) > 0
          ? _toIntValue(data['redeemablePoints'])
          : null,
      promotionCode: _stringOrNull(data['promotionCode']),
    );
  }

  HttpResult<FrontendCheckoutResult> _initializeFrontendCheckout({
    required String email,
    String? addressId,
    int? redeemPoints,
    String? promotionCode,
  }) async {
    return Http.post(
      _frontendShopCheckoutInitializeBase,
      {
        ..._frontendContextPayload(),
        'provider': 'paystack',
        'callback_url': _frontendCheckoutCallbackUrl,
        'email': email,
        if (_stringOrNull(addressId) != null) 'address_id': addressId,
        if (redeemPoints != null && redeemPoints > 0)
          'redeem_points': redeemPoints,
        if (_stringOrNull(promotionCode) != null)
          'promotion_code': promotionCode!.trim(),
        'channels': ['card', 'bank'],
      },
      deserializer: (responseData) {
        final payload = _extractDataMap(responseData);
        final order = _mapOrEmpty(payload['order']);
        final checkout = _mapOrEmpty(payload['checkout']);
        final payment = _mapOrEmpty(payload['payment']);
        final appliedPromotion = _mapOrEmpty(order['applied_promotion']);
        final pointsRedemption = _mapOrEmpty(order['points_redemption']);
        final rawAuthorizationUrl =
            _pickText(checkout, ['authorization_url', 'url']);
        final rawRequiresPayment = checkout['requires_payment'];
        final authorizationUrl =
            rawAuthorizationUrl.isEmpty ? null : rawAuthorizationUrl;
        final paymentStatus =
            _pickText(payment, ['status'], fallback: '').toLowerCase();
        final orderPaymentStatus =
            _pickText(order, ['payment_status'], fallback: '').toLowerCase();
        final orderStatus =
            _pickText(order, ['status'], fallback: '').toLowerCase();
        final checkoutStatus = _pickText(
          checkout,
          ['status'],
          fallback: _pickText(
            payment,
            ['status'],
            fallback: _pickText(order, ['status']),
          ),
        );
        final requiresPayment = rawRequiresPayment == true ||
            rawRequiresPayment.toString().toLowerCase() == 'true' ||
            rawRequiresPayment.toString() == '1' ||
            (authorizationUrl != null &&
                paymentStatus != 'paid' &&
                orderPaymentStatus != 'paid' &&
                orderStatus != 'paid' &&
                orderStatus != 'completed');

        final result = FrontendCheckoutResult(
          orderId: _pickText(order, ['id', 'uuid']),
          orderNumber: _pickText(order, ['order_number']),
          subtotalAmount: _toDoubleValue(order['subtotal_amount']),
          discountAmount: _toDoubleValue(order['discount_amount']),
          taxAmount: _toDoubleValue(order['tax_amount']),
          totalAmount: _toDoubleValue(order['total_amount']),
          authorizationUrl: authorizationUrl,
          accessCode: _stringOrNull(
            checkout['access_code'] ?? checkout['accessCode'],
          ),
          reference: _pickText(checkout, ['reference']),
          provider: _pickText(checkout, ['provider'], fallback: 'paystack'),
          status: checkoutStatus,
          requiresPayment: requiresPayment,
          appliedPromotion: appliedPromotion.isEmpty
              ? null
              : FrontendAppliedPromotion(
                  promotionId: _pickText(
                    appliedPromotion,
                    ['promotion_id', 'id'],
                  ),
                  promotionCode: _pickText(
                    appliedPromotion,
                    ['promotion_code', 'code'],
                  ),
                  promotionName: _pickText(
                    appliedPromotion,
                    ['promotion_name', 'name'],
                    fallback: 'Promotion',
                  ),
                  discountAmount:
                      _toDoubleValue(appliedPromotion['discount_amount']),
                  currency: _pickText(
                    appliedPromotion,
                    ['currency'],
                    fallback: 'KES',
                  ),
                  status: _pickText(appliedPromotion, ['status']),
                ),
          pointsRedemption: pointsRedemption.isEmpty
              ? null
              : FrontendPointsRedemption(
                  appliedPoints:
                      _toIntValue(pointsRedemption['applied_points']),
                  discountAmount:
                      _toDoubleValue(pointsRedemption['discount_amount']),
                  status: _pickText(pointsRedemption, ['status']),
                ),
        );

        if (result.orderId.isEmpty && result.authorizationUrl == null) {
          throw const FormatException("Unable to initialize checkout");
        }

        latestCheckoutResult = result;
        return result;
      },
    );
  }

  HttpResult<bool> verifyFrontendCheckout(
    String provider,
    String reference,
  ) async {
    return Http.get(
      "$_frontendShopCheckoutVerifyBase/$provider/$reference",
      deserializer: (responseData) {
        final payload = _extractDataMap(responseData);
        final payment = _mapOrEmpty(payload['payment']);
        final order = _mapOrEmpty(payload['order']);
        final paymentStatus =
            _pickText(payment, ['status'], fallback: '').toLowerCase();
        final orderPaymentStatus =
            _pickText(order, ['payment_status'], fallback: '').toLowerCase();
        final orderStatus =
            _pickText(order, ['status'], fallback: '').toLowerCase();

        if (paymentStatus == 'paid' ||
            orderPaymentStatus == 'paid' ||
            orderStatus == 'paid') {
          return true;
        }

        throw const FormatException("Payment has not been confirmed yet.");
      },
    );
  }

  Future<MultipleResult<List<Map<String, dynamic>>>> _resolveBuyNowSelections(
    Map<String, dynamic> data,
  ) async {
    final isTicketPurchase = _pickText(
          data,
          ['reference_type'],
          fallback: '',
        ) ==
        'ticket_type';

    if (isTicketPurchase ||
        _stringOrNull(data['ticketTypeId']) != null ||
        _stringOrNull(data['matchId']) != null) {
      Map<String, dynamic>? ticketType;
      var ticketTypeId = _stringOrNull(data['ticketTypeId']) ?? '';
      final matchId = _stringOrNull(data['matchId']);

      if (ticketTypeId.isEmpty) {
        if (matchId == null) {
          return MultipleResult.onError(
            error: Failure(error: "Ticket information is missing."),
          );
        }

        final ticketTypeResponse = await getPreferredTicketType(matchId);
        if (ticketTypeResponse is Error<Map<String, dynamic>>) {
          return MultipleResult.onError(error: ticketTypeResponse.error);
        }

        ticketType = (ticketTypeResponse as Success<Map<String, dynamic>>).data;
        ticketTypeId = _pickText(ticketType, ['id']);
      }

      if (ticketTypeId.isEmpty) {
        return MultipleResult.onError(
          error: Failure(error: "No valid ticket type was found."),
        );
      }

      final quantity =
          _toIntValue(data['quantity']) > 0 ? _toIntValue(data['quantity']) : 1;
      final maxPerOrder =
          ticketType == null ? 0 : _toIntValue(ticketType['max_per_order']);

      if (maxPerOrder > 0 && quantity > maxPerOrder) {
        return MultipleResult.onError(
          error: Failure(
            error: "You can only buy up to $maxPerOrder tickets per order.",
          ),
        );
      }

      return MultipleResult.onSuccess(
        data: [
          {
            'reference_type': 'ticket_type',
            'reference_uuid': ticketTypeId,
            'quantity': quantity,
          },
        ],
      );
    }

    final references = _legacyCartSelections(data);
    if (references.isEmpty) {
      return MultipleResult.onError(
        error: Failure(error: "No items were selected for checkout."),
      );
    }

    return MultipleResult.onSuccess(data: references);
  }

  HttpResult<String> addToCart(Map<String, dynamic> data, String token) async {
    final references = _legacyCartSelections(data);
    if (references.isEmpty) {
      return MultipleResult.onError(
        error: Failure(error: "No cart items were selected."),
      );
    }

    for (final reference in references) {
      final result = await Http.post(
        _frontendShopCartItemsBase,
        {
          ..._frontendContextPayload(),
          'reference_type': _pickText(
            reference,
            ['reference_type'],
            fallback: 'product_variant',
          ),
          'reference_uuid': _pickText(
            reference,
            ['reference_uuid', 'variantID', 'variantId', 'productTypeID'],
          ),
          'quantity': _toIntValue(reference['quantity']),
        },
        deserializer: (responseData) => responseData,
      );

      if (result is Error<dynamic>) {
        return MultipleResult.onError(error: result.error);
      }
    }

    return MultipleResult.onSuccess(
      data: "Product added to cart successfully",
    );
  }

  HttpResult<String> removeCart(Map<String, dynamic> data) async {
    final references = _legacyCartSelections(data);
    if (references.isEmpty) {
      return MultipleResult.onError(
        error: Failure(error: "No cart items were selected."),
      );
    }

    final cartResponse = await _loadFrontendCart();
    if (cartResponse is Error<Map<String, dynamic>>) {
      return MultipleResult.onError(error: cartResponse.error);
    }

    final cartItems = _listOrEmpty(
        (cartResponse as Success<Map<String, dynamic>>).data['items']);

    for (final reference in references) {
      final referenceUuid = _pickText(
        reference,
        ['reference_uuid', 'variantID', 'variantId', 'productTypeID'],
      );
      final quantityToRemove = _toIntValue(reference['quantity']);

      final matchingItem =
          cartItems.whereType<Map>().map(_mapOrEmpty).firstWhere(
                (item) => _pickText(item, ['reference_uuid']) == referenceUuid,
                orElse: () => const <String, dynamic>{},
              );

      if (matchingItem.isEmpty) {
        continue;
      }

      final itemId = _pickText(matchingItem, ['id']);
      final currentQuantity = _toIntValue(matchingItem['quantity']);
      if (itemId.isEmpty) {
        continue;
      }

      final result = quantityToRemove >= currentQuantity
          ? await Http.delete(
              "$_frontendShopCartItemsBase/$itemId",
              deserializer: (responseData) => responseData,
            )
          : await Http.patch(
              "$_frontendShopCartItemsBase/$itemId",
              {
                'quantity': currentQuantity - quantityToRemove,
              },
              deserializer: (responseData) => responseData,
            );

      if (result is Error<dynamic>) {
        return MultipleResult.onError(error: result.error);
      }
    }

    return MultipleResult.onSuccess(
      data: "Product removed from cart successfully",
    );
  }

  HttpResult<String> clearCart(Map<String, dynamic> data) async {
    return Http.delete(
      _frontendShopCartBase,
      deserializer: (_) => "Cart cleared successfully",
    );
  }
}

class CartService {
  HttpResult<List<CartItem>> getCartItems() async {
    return Http.get(
      _frontendShopCartBase,
      deserializer: (data) {
        final cart = _extractDataMap(data);
        return _listOrEmpty(cart['items'])
            .whereType<Map>()
            .map(
                (item) => _mapFrontendCartItem(Map<String, dynamic>.from(item)))
            .toList();
      },
    );
  }
}

class AddressService {
  HttpResult<List<Address>> getAddresses() async {
    return Http.get(
      _frontendShopAddressesBase,
      deserializer: (data) {
        return _extractDataList(data).map(_mapFrontendAddress).toList();
      },
    );
  }

  HttpResult<String> addNewAddress(Map<String, dynamic> data) async {
    return Http.post(
      _frontendShopAddressesBase,
      _buildFrontendAddressPayload(data),
      deserializer: (responseData) {
        final payload = _extractDataMap(responseData);
        final addressId = _pickText(payload, ['id']);

        if (addressId.isNotEmpty) {
          return addressId;
        }

        throw const FormatException("Failed to add address");
      },
    );
  }
}

class PickupAddressService {
  Future<MultipleResult<List<PickupAddress>>> getPickupAddresses() async {
    final response = await Http.get<List<Map<String, dynamic>>>(
      _frontendShopPickupStationsBase,
      queryParams: {
        ..._frontendContextPayload(),
        'status': 'active',
      },
      deserializer: (data) => _extractDataList(data),
    );

    if (response is Error<List<Map<String, dynamic>>>) {
      return MultipleResult.onError(error: response.error);
    }

    final pickupAddresses = (response as Success<List<Map<String, dynamic>>>)
        .data
        .map(_mapFrontendPickupAddress)
        .toList();

    return MultipleResult.onSuccess(data: pickupAddresses);
  }
}

class MatchService {
  HttpResult<List<MatchType>> getMatches({String? clubId}) async {
    final currentContext = service<AppPreferencesManager>().currentContextValue;
    final endpoint = _mobileScheduleEndpoint(clubId);

    return Http.get(
      endpoint,
      queryParams: {
        'status': 'scheduled',
        'per_page': 50,
      },
      deserializer: (data) {
        final records = _extractDataList(data);
        final matches = records.map(_mapMobileMatchRecordToMatchType).toList();

        if (kDebugMode) {
          service<Talker>().info(
            'Scheduled matches request => '
            'endpoint=$endpoint, '
            'clubId=$clubId, '
            'leagueId=${currentContext?.activeLeagueId ?? AppConfig.defaultLeagueId}, '
            'seasonId=${currentContext?.activeSeasonId ?? AppConfig.defaultSeasonId}, '
            'rawCount=${records.length}, '
            'rawIds=${records.map((record) => _pickText(record, ['id'])).toList()}',
          );

          for (var i = 0; i < records.length && i < matches.length; i++) {
            final record = records[i];
            final match = matches[i];
            final ticketing = _mapOrEmpty(record['ticketing']);

            service<Talker>().info(
              'Scheduled match ticketing => '
              'id=${match.matchId}, '
              'name=${match.matchName}, '
              'matchPrice=${match.matchPrice}, '
              'hasTicket=${match.hasTicket}, '
              'ticketing.has_tickets=${ticketing['has_tickets']}, '
              'ticketing.starting_price=${ticketing['starting_price']}, '
              'ticketing=${jsonEncode(ticketing)}',
            );
          }
        }

        return matches;
      },
    );
  }

  HttpResult<List<MatchType>> getMatchStats(String? clubId) async {
    final listResponse = await Http.get<List<Map<String, dynamic>>>(
      _mobileScheduleEndpoint(clubId),
      queryParams: {
        'status': 'completed',
        'per_page': 50,
      },
      deserializer: (data) {
        return _extractDataList(data);
      },
    );

    if (listResponse is Success<List<Map<String, dynamic>>>) {
      final matches = listResponse.data
          .map(_mapMobileMatchRecordToMatchType)
          .toList(growable: false);
      return MultipleResult.onSuccess(data: matches);
    }

    if (listResponse is Error<List<Map<String, dynamic>>>) {
      return MultipleResult.onError(error: listResponse.error);
    }

    return MultipleResult.onError(
      error: Failure(error: "Unable to load matches"),
    );
  }

  HttpResult<MatchModel> getMatchRecap(String matchId) async {
    return Http.get(
      "$_mobileMatchesBase/$matchId",
      queryParams: _frontendContextPayload(),
      deserializer: (data) {
        final payload = _extractDataMap(data);
        return _mapMobileMatchRecordToRecap(payload);
      },
    );
  }
}

const _frontendAuthBase =
    "https://coastal-kings.wencetechnologies.com/api/v1/frontend-auth";
const _frontendShopBase =
    "https://coastal-kings.wencetechnologies.com/api/v1/frontend/shop";
const _frontendShopProductsBase = "$_frontendShopBase/products";
const _frontendShopTicketTypesBase = "$_frontendShopBase/ticket-types";
const _frontendShopOrdersBase = "$_frontendShopBase/orders";
const _frontendShopTicketsBase = "$_frontendShopBase/tickets";
const _frontendShopTicketSummaryBase = "$_frontendShopTicketsBase/summary";
const _frontendShopAddressesBase = "$_frontendShopBase/addresses";
const _frontendShopCartBase = "$_frontendShopBase/cart";
const _frontendShopCartItemsBase = "$_frontendShopCartBase/items";
const _frontendShopPromotionsValidateBase =
    "$_frontendShopBase/promotions/validate";
const _frontendShopCheckoutInitializeBase =
    "$_frontendShopCartBase/checkout/initialize";
const _frontendShopCheckoutVerifyBase =
    "$_frontendShopCartBase/checkout/verify";
const _frontendShopPickupStationsBase = "$_frontendShopBase/pickup-stations";
const _frontendPointsBase =
    "https://coastal-kings.wencetechnologies.com/api/v1/points";
const _frontendPointsWalletBase = "$_frontendPointsBase/wallet";
const _frontendPointsEarnBase = "$_frontendPointsBase/actions/earn";
const _frontendPointsHistoryBase = "$_frontendPointsBase/history";
const _frontendPointsTransferBase = "$_frontendPointsBase/transfer";
const _frontendNotificationsBase =
    "https://coastal-kings.wencetechnologies.com/api/v1/frontend/notifications";
const _frontendCheckoutCallbackUrl = String.fromEnvironment(
  'SPORTS_APP_CHECKOUT_CALLBACK_URL',
  defaultValue:
      'https://wencesportswebapplication.vercel.app/checkout/complete',
);
const _domainContextBase =
    "https://coastal-kings.wencetechnologies.com/api/v1/domains/context";
const _mobileBase = "https://coastal-kings.wencetechnologies.com/api/v1/mobile";
const _mobileContextBase = "$_mobileBase/context";
const _mobileClubsBase = "$_mobileBase/clubs";
const _mobileTeamsBase = "$_mobileBase/teams";
const _mobilePlayersBase = "$_mobileBase/players";
const _mobileMatchesBase = "$_mobileBase/matches";
const _mobileStandingsBase = "$_mobileBase/standings";
const _mobileStatisticsBase = "$_mobileBase/statistics";
const _mobileMediaBase = "$_mobileBase/media";
const _mobileHomeBase = "$_mobileBase/home";

String? _stringOrNull(dynamic value) {
  final text = value?.toString().trim();
  if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
    return null;
  }
  return text;
}

String _mobileScheduleEndpoint(String? clubId) {
  final resolvedClubId = _stringOrNull(clubId);
  if (resolvedClubId == null) {
    return _mobileMatchesBase;
  }

  return "$_mobileTeamsBase/$resolvedClubId/schedule";
}

Map<String, dynamic> _frontendContextPayload() {
  final currentContext = service<AppPreferencesManager>().currentContextValue;
  final leagueId = _stringOrNull(currentContext?.activeLeagueId) ??
      AppConfig.defaultLeagueId;
  final seasonId = _stringOrNull(currentContext?.activeSeasonId) ??
      AppConfig.defaultSeasonId;

  return {
    if (leagueId != null) 'league_id': leagueId,
    if (seasonId != null) 'season_id': seasonId,
  };
}

String? _assetUrl(dynamic asset) {
  if (asset is String) {
    return _stringOrNull(asset);
  }

  if (asset is Map<String, dynamic>) {
    return _stringOrNull(asset['url']) ??
        _stringOrNull(asset['thumbnail_url']) ??
        _stringOrNull(asset['path']);
  }

  return null;
}

Map<String, dynamic> _mapOrEmpty(dynamic value) {
  if (value is Map<String, dynamic>) {
    return value;
  }

  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }

  return const <String, dynamic>{};
}

List<dynamic> _listOrEmpty(dynamic value) {
  if (value is List) {
    return value;
  }

  return const <dynamic>[];
}

List<Map<String, dynamic>> _extractDataList(dynamic responseData) {
  final responseMap = _mapOrEmpty(responseData);
  final source =
      responseMap.containsKey('data') ? responseMap['data'] : responseData;

  return _listOrEmpty(source)
      .whereType<Map>()
      .map((item) => Map<String, dynamic>.from(item))
      .toList();
}

Map<String, dynamic> _extractDataMap(dynamic responseData) {
  final responseMap = _mapOrEmpty(responseData);
  if (responseMap.isEmpty) {
    return const <String, dynamic>{};
  }

  final data = responseMap['data'];
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }

  return responseMap;
}

int _toIntValue(dynamic value) {
  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _toDoubleValue(dynamic value) {
  if (value is double) {
    return value;
  }

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value?.toString() ?? '') ?? 0;
}

bool _toBoolValue(dynamic value) {
  if (value is bool) {
    return value;
  }

  final normalized = value?.toString().trim().toLowerCase();
  return normalized == 'true' || normalized == '1' || normalized == 'yes';
}

DateTime _parseDateTime(dynamic value) {
  final raw = _stringOrNull(value);
  if (raw == null) {
    return DateTime.now();
  }

  return DateTime.tryParse(raw) ?? DateTime.now();
}

String _formatHeight(dynamic feet, dynamic inches) {
  final parsedFeet = _stringOrNull(feet);
  final parsedInches = _stringOrNull(inches);

  if (parsedFeet == null && parsedInches == null) {
    return "-";
  }

  if (parsedFeet != null && parsedInches != null) {
    return "$parsedFeet'$parsedInches\"";
  }

  if (parsedFeet != null) {
    return "$parsedFeet ft";
  }

  return "$parsedInches in";
}

String _formatWeight(dynamic weight) {
  final parsed = _stringOrNull(weight);
  if (parsed == null) {
    return "-";
  }

  return parsed.toLowerCase().contains('kg') ? parsed : "$parsed kg";
}

String _humanizeLabel(String value) {
  const specialCases = <String, String>{
    'points': 'Points',
    'assists': 'Assists',
    'rebounds': 'Rebounds',
    'steals': 'Steals',
    'blocks': 'Blocks',
    'turnovers': 'Turnovers',
    'field_goal': 'Field Goal',
    'field_goals': 'Field Goal',
    'free_throw': 'Free Throw',
    'free_throws': 'Free Throw',
    'three_pointer': 'Three Pointer',
    'three_pointers': 'Three Pointer',
    'minutes_played': 'Minutes Played',
    'offensive_rebounds': 'Offensive Rebounds',
    'defensive_rebounds': 'Defensive Rebounds',
    'personal_fouls': 'Personal Fouls',
    'technical_fouls': 'Technical Fouls',
  };

  final normalized = value.trim().toLowerCase();
  if (normalized.isEmpty) {
    return value;
  }

  if (specialCases.containsKey(normalized)) {
    return specialCases[normalized]!;
  }

  return normalized
      .split(RegExp(r'[_\s-]+'))
      .where((part) => part.isNotEmpty)
      .map((part) => "${part[0].toUpperCase()}${part.substring(1)}")
      .join(' ');
}

String _pickText(
  Map<String, dynamic> source,
  List<String> keys, {
  String fallback = '',
}) {
  for (final key in keys) {
    final value = _stringOrNull(source[key]);
    if (value != null) {
      return value;
    }
  }

  return fallback;
}

String _pickFirstTextValue(
  Iterable<dynamic> values, {
  String fallback = '',
}) {
  for (final value in values) {
    final text = _stringOrNull(value);
    if (text != null) {
      return text;
    }
  }

  return fallback;
}

String _extractMatchScoreValue(
  Map<String, dynamic> match, {
  required String side,
  String fallback = '0',
}) {
  final statistics = _mapOrEmpty(match['statistics']);
  final isAway = side.toLowerCase() == 'away';
  final teamScore = _extractTeamScoreValue(
    statistics['team_scores'] ?? match['team_scores'],
    side: side,
  );

  return _pickFirstTextValue(
    [
      teamScore,
      statistics[isAway ? 'final_score_away' : 'final_score_home'],
      match[isAway ? 'final_score_away' : 'final_score_home'],
      match[isAway ? 'clubTwoScore' : 'clubOneScore'],
      match[isAway ? 'away_score' : 'home_score'],
    ],
    fallback: fallback,
  );
}

String _extractTeamScoreValue(dynamic raw, {required String side}) {
  if (raw is! List) {
    return '';
  }

  for (final item in raw.whereType<Map>()) {
    final record = Map<String, dynamic>.from(item);
    final teamSide =
        _pickText(record, ['team_side'], fallback: '').toLowerCase();
    if (teamSide != side.toLowerCase()) {
      continue;
    }

    return _pickText(
      record,
      ['total_points', 'points', 'score', 'total'],
      fallback: '',
    );
  }

  return '';
}

int _pickIntValue(
  Map<String, dynamic> source,
  List<String> keys, {
  int fallback = 0,
}) {
  for (final key in keys) {
    if (source.containsKey(key)) {
      return _toIntValue(source[key]);
    }
  }

  return fallback;
}

String _matchScoreLine(Map<String, dynamic> match) {
  final homeScore = _extractMatchScoreValue(match, side: 'home', fallback: '');
  final awayScore = _extractMatchScoreValue(match, side: 'away', fallback: '');

  if (homeScore.isNotEmpty && awayScore.isNotEmpty) {
    return "$homeScore - $awayScore";
  }

  final status = _stringOrNull(match['status']);
  if (status != null && status.isNotEmpty) {
    return _humanizeLabel(status);
  }

  return _pickText(match, ['scheduled_at', 'kickoff_at'], fallback: '-');
}

bool _isCompletedMatchStatus(String? status) {
  final normalized = status?.toLowerCase();
  return normalized == 'completed' ||
      normalized == 'finished' ||
      normalized == 'played' ||
      normalized == 'final';
}

String _resolveMatchWinner(
  String homeClubName,
  String awayClubName,
  String homeScore,
  String awayScore,
) {
  final home = int.tryParse(homeScore) ?? 0;
  final away = int.tryParse(awayScore) ?? 0;

  if (home == away) {
    return '';
  }

  return home > away ? homeClubName : awayClubName;
}

Map<String, dynamic> _flattenRecapStatMap(Map<String, dynamic> raw) {
  const metadataKeys = <String>{
    'id',
    'team_side',
    'match_id',
    'club_id',
    'created_at',
    'updated_at',
    'deleted_at',
    'extra_statistics',
    'stat_values',
  };

  final flattened = <String, dynamic>{};

  void addScalarEntries(Map<String, dynamic> source) {
    source.forEach((key, value) {
      if (metadataKeys.contains(key) || value == null) {
        return;
      }

      if (value is Map || value is List) {
        return;
      }

      flattened[key] = value;
    });
  }

  addScalarEntries(raw);
  addScalarEntries(_mapOrEmpty(raw['extra_statistics']));

  for (final item in _listOrEmpty(raw['stat_values']).whereType<Map>()) {
    final record = Map<String, dynamic>.from(item);
    final code = _pickText(record, ['code', 'name', 'stat']);
    if (code.isEmpty) {
      continue;
    }

    final value = record['value'] ??
        record['statValue'] ??
        record['count'] ??
        record['total'];
    if (value == null) {
      continue;
    }

    flattened[code] = value;
  }

  return flattened;
}

List<IntervalScoreModel> _parseIntervalScores(
  dynamic raw, {
  required String homeClubName,
  required String awayClubName,
}) {
  if (raw is! List) {
    return const <IntervalScoreModel>[];
  }

  final records = raw
      .whereType<Map>()
      .map((item) => Map<String, dynamic>.from(item))
      .toList();

  final usesPeriodScores = records.any(
    (record) =>
        record.containsKey('team_side') ||
        record.containsKey('match_interval') ||
        record.containsKey('points'),
  );

  if (usesPeriodScores) {
    final grouped = <String, Map<String, dynamic>>{};

    for (final record in records) {
      final matchInterval = _mapOrEmpty(record['match_interval']);
      final sequencePosition = _toIntValue(
        matchInterval['sequence'] ??
            record['sequencePosition'] ??
            record['sequence'] ??
            record['order'],
      );
      final intervalLabel = _pickText(
        matchInterval,
        ['name', 'code'],
        fallback: _pickText(record, ['period', 'label', 'name'],
            fallback: 'Interval'),
      );
      final groupKey = _pickText(
        matchInterval,
        ['id', 'code', 'name'],
        fallback: '${sequencePosition}_$intervalLabel',
      );

      final entry = grouped.putIfAbsent(
        groupKey,
        () => <String, dynamic>{
          'sequencePosition': sequencePosition,
          'interval': intervalLabel,
          'clubOne': homeClubName,
          'homeTeamScore': '0',
          'clubTwo': awayClubName,
          'awayTeamScore': '0',
        },
      );

      final normalizedSide =
          _pickText(record, ['team_side'], fallback: '').toLowerCase();
      final points = _pickText(record, ['points', 'value'], fallback: '0');

      if (normalizedSide == 'away') {
        entry['awayTeamScore'] = points;
      } else {
        entry['homeTeamScore'] = points;
      }
    }

    return grouped.values.map((entry) {
      return IntervalScoreModel(
        sequencePosition: _toIntValue(entry['sequencePosition']),
        interval: _stringOrNull(entry['interval']) ?? 'Interval',
        clubOne: _stringOrNull(entry['clubOne']) ?? homeClubName,
        homeTeamScore: _stringOrNull(entry['homeTeamScore']) ?? '0',
        clubTwo: _stringOrNull(entry['clubTwo']) ?? awayClubName,
        awayTeamScore: _stringOrNull(entry['awayTeamScore']) ?? '0',
      );
    }).toList();
  }

  return records.map((record) {
    return IntervalScoreModel(
      sequencePosition: _toIntValue(
        record['sequencePosition'] ?? record['sequence'] ?? record['order'],
      ),
      interval: _pickText(
        record,
        ['interval', 'label', 'name', 'period'],
        fallback: 'Interval',
      ),
      clubOne: _pickText(
        record,
        ['clubOne', 'home_team', 'home_club'],
        fallback: homeClubName,
      ),
      homeTeamScore: _pickText(
        record,
        ['homeTeamScore', 'home_score', 'home'],
        fallback: '0',
      ),
      clubTwo: _pickText(
        record,
        ['clubTwo', 'away_team', 'away_club'],
        fallback: awayClubName,
      ),
      awayTeamScore: _pickText(
        record,
        ['awayTeamScore', 'away_score', 'away'],
        fallback: '0',
      ),
    );
  }).toList();
}

List<PlayerBoxScoreModel> _parsePlayerStatistics(
  dynamic raw, {
  required String homeClubName,
  required String awayClubName,
  required String homeClubId,
  required String awayClubId,
}) {
  if (raw is! List) {
    return const <PlayerBoxScoreModel>[];
  }

  return raw.whereType<Map>().map((item) {
    final record = Map<String, dynamic>.from(item);
    final player = _mapOrEmpty(record['player']);
    final flattened = _flattenRecapStatMap(record);

    var teamSide = _pickText(record, ['team_side'], fallback: '').toLowerCase();
    final clubId = _pickText(
      player,
      ['club_id'],
      fallback: teamSide == 'away' ? awayClubId : homeClubId,
    );

    if (teamSide.isEmpty) {
      teamSide = clubId == awayClubId ? 'away' : 'home';
    }

    final offensiveRebounds = _pickIntValue(
      flattened,
      ['offensive_rebounds'],
    );
    final defensiveRebounds = _pickIntValue(
      flattened,
      ['defensive_rebounds'],
    );
    final totalRebounds = _pickIntValue(
      flattened,
      ['total_rebounds', 'rebounds'],
      fallback: offensiveRebounds + defensiveRebounds,
    );

    return PlayerBoxScoreModel(
      playerId: _pickText(
        record,
        ['player_id'],
        fallback: _pickText(player, ['id']),
      ),
      playerName: _pickText(
        player,
        ['name', 'full_name'],
        fallback: 'Unknown Player',
      ),
      clubId: clubId,
      clubName: _pickText(
        player,
        ['club_name'],
        fallback: teamSide == 'away' ? awayClubName : homeClubName,
      ),
      teamSide: teamSide == 'away' ? 'away' : 'home',
      isStarter: _toBoolValue(record['is_starter']),
      points: _pickIntValue(flattened, ['points']),
      assists: _pickIntValue(flattened, ['assists']),
      offensiveRebounds: offensiveRebounds,
      defensiveRebounds: defensiveRebounds,
      totalRebounds: totalRebounds,
      steals: _pickIntValue(flattened, ['steals']),
      blocks: _pickIntValue(flattened, ['blocks']),
      turnovers: _pickIntValue(flattened, ['turnovers']),
      personalFouls: _pickIntValue(flattened, ['personal_fouls']),
      technicalFouls: _pickIntValue(flattened, ['technical_fouls']),
      fieldGoalsMade: _pickIntValue(
        flattened,
        ['field_goals_made', 'field_goal_made', 'fg_made', 'fgm'],
      ),
      fieldGoalsAttempted: _pickIntValue(
        flattened,
        [
          'field_goals_attempted',
          'field_goal_attempts',
          'field_goals_attempts',
          'fg_attempts',
          'fga',
        ],
      ),
      freeThrowsMade: _pickIntValue(
        flattened,
        ['free_throws_made', 'free_throw_made', 'ft_made', 'ftm'],
      ),
      freeThrowsAttempted: _pickIntValue(
        flattened,
        [
          'free_throws_attempted',
          'free_throw_attempts',
          'free_throws_attempts',
          'ft_attempts',
          'fta',
        ],
      ),
      threePointersMade: _pickIntValue(
        flattened,
        [
          'three_pointers_made',
          'three_points_made',
          'three_point_made',
          '3pt_made',
          '3pm',
        ],
      ),
      threePointersAttempted: _pickIntValue(
        flattened,
        [
          'three_pointers_attempted',
          'three_points_attempted',
          'three_point_attempts',
          'three_points_attempts',
          '3pt_attempts',
          '3pa',
        ],
      ),
    );
  }).toList();
}

Map<String, num> _aggregatePlayerStatsBySide(
  List<PlayerBoxScoreModel> players,
  String side,
) {
  final totals = <String, num>{};

  void addValue(String label, num value) {
    totals[label] = (totals[label] ?? 0) + value;
  }

  for (final player in players) {
    if (player.teamSide.toLowerCase() != side.toLowerCase()) {
      continue;
    }

    addValue('Points', player.points);
    addValue('Assists', player.assists);
    addValue('Rebounds', player.totalRebounds);
    addValue('Offensive Rebounds', player.offensiveRebounds);
    addValue('Defensive Rebounds', player.defensiveRebounds);
    addValue('Steals', player.steals);
    addValue('Blocks', player.blocks);
    addValue('Turnovers', player.turnovers);
    addValue('Personal Fouls', player.personalFouls);
    addValue('Technical Fouls', player.technicalFouls);
    addValue('Field Goal', player.fieldGoalsMade);
    addValue('Field Goal Attempts', player.fieldGoalsAttempted);
    addValue('Free Throw (FT)', player.freeThrowsMade);
    addValue('Free Throw Attempts', player.freeThrowsAttempted);
    addValue('Three Pointer (3 PT)', player.threePointersMade);
    addValue('3 Point Attempts', player.threePointersAttempted);
  }

  return totals;
}

List<StatModel> _statModelsFromAggregates(Map<String, num> totals) {
  return totals.entries
      .map(
        (entry) => StatModel(
          stat: entry.key,
          statValue: entry.value.toInt(),
        ),
      )
      .toList();
}

String _clubImageUrl(Map<String, dynamic> club) {
  return _assetUrl(
        club['logo'] ??
            club['profile_picture'] ??
            club['avatar'] ??
            club['pic'] ??
            club['cover_asset'],
      ) ??
      '';
}

MatchModel _mapMobileMatchRecordToRecap(Map<String, dynamic> record) {
  final homeClub = _mapOrEmpty(record['home_club'] ?? record['clubOne']);
  final awayClub = _mapOrEmpty(record['away_club'] ?? record['clubTwo']);
  final venue = _mapOrEmpty(record['venue']);
  final statistics = _mapOrEmpty(record['statistics']);
  final intervalScoresSource = statistics['period_scores'] ??
      statistics['interval_scores'] ??
      statistics['intervalScores'] ??
      _mapOrEmpty(record['intervalscores'])['stats'] ??
      record['interval_scores'];

  final homeClubName = _pickText(homeClub, ['name'], fallback: 'Home Club');
  final awayClubName = _pickText(awayClub, ['name'], fallback: 'Away Club');
  final homeClubId = _pickText(homeClub, ['id']);
  final awayClubId = _pickText(awayClub, ['id']);
  final homeScore = _extractMatchScoreValue(record, side: 'home');
  final awayScore = _extractMatchScoreValue(record, side: 'away');
  final playerStatistics = _parsePlayerStatistics(
    statistics['player_statistics'] ?? record['player_statistics'],
    homeClubName: homeClubName,
    awayClubName: awayClubName,
    homeClubId: homeClubId,
    awayClubId: awayClubId,
  );
  final homeTeamTotals = _aggregatePlayerStatsBySide(playerStatistics, 'home');
  final awayTeamTotals = _aggregatePlayerStatsBySide(playerStatistics, 'away');

  return MatchModel(
    id: _pickText(record, ['id']),
    name: _pickText(
      record,
      ['name'],
      fallback: "$homeClubName vs $awayClubName",
    ),
    clubOne: ClubModel(
      id: homeClubId,
      name: homeClubName,
      pic: _clubImageUrl(homeClub),
      stats: _statModelsFromAggregates(homeTeamTotals),
    ),
    clubTwo: ClubModel(
      id: awayClubId,
      name: awayClubName,
      pic: _clubImageUrl(awayClub),
      stats: _statModelsFromAggregates(awayTeamTotals),
    ),
    matchDate: MatchDateModel(
      id: _pickText(_mapOrEmpty(record['matchDate']), ['id'],
          fallback: _pickText(record, ['id'])),
      date: _parseDateTime(
        record['scheduled_at'] ??
            record['kickoff_at'] ??
            _mapOrEmpty(record['matchDate'])['date'],
      ),
    ),
    venue: VenueModel(
      id: _pickText(venue, ['id']),
      name: _pickText(venue, ['name'], fallback: 'Venue'),
      location: _pickText(
        venue,
        ['location', 'physical_address', 'address', 'city'],
        fallback: _pickText(venue, ['name'], fallback: 'Venue'),
      ),
      latitude: _toDoubleValue(venue['latitude']),
      longitude: _toDoubleValue(venue['longitude']),
    ),
    description: _pickText(
      record,
      ['description', 'game_type', 'assigned_officials'],
    ),
    matchWinner: _pickText(
      record,
      ['matchWinner', 'winner_name'],
      fallback: _resolveMatchWinner(
        homeClubName,
        awayClubName,
        homeScore,
        awayScore,
      ),
    ),
    clubOneScore: homeScore,
    clubTwoScore: awayScore,
    matchStatus: _isCompletedMatchStatus(_stringOrNull(record['status'])) ||
        (_toIntValue(homeScore) + _toIntValue(awayScore)) > 0,
    intervalScores: _parseIntervalScores(
      intervalScoresSource,
      homeClubName: homeClubName,
      awayClubName: awayClubName,
    ),
    playerStatistics: playerStatistics,
  );
}

MatchType _mapMobileMatchRecordToMatchType(
  Map<String, dynamic> record, {
  MatchModel? recap,
}) {
  final resolvedRecap = recap ?? _mapMobileMatchRecordToRecap(record);

  return MatchType(
    matchId: resolvedRecap.id,
    teamOne: resolvedRecap.clubOne.name,
    teamTwo: resolvedRecap.clubTwo.name,
    matchName: resolvedRecap.name,
    matchDescription: resolvedRecap.description,
    matchDate: resolvedRecap.matchDate.date,
    matchVenue: resolvedRecap.venue.name,
    matchLocation: resolvedRecap.venue.location,
    matchPrice: _resolveMobileMatchPrice(record),
    teamOneScore: resolvedRecap.clubOneScore,
    teamTwoScore: resolvedRecap.clubTwoScore,
    recap: resolvedRecap,
  );
}

double _resolveMobileMatchPrice(Map<String, dynamic> record) {
  final ticketing = _mapOrEmpty(record['ticketing']);
  if (ticketing.isNotEmpty) {
    final hasTickets = ticketing['has_tickets'] == true;
    if (!hasTickets) {
      return 0;
    }

    final startingPrice = _toDoubleValue(ticketing['starting_price']);
    if (startingPrice > 0) {
      return startingPrice;
    }
  }

  const matchPriceKeys = [
    'match_price',
    'ticket_price',
    'price',
    'matchPrice',
    'ticketPrice',
  ];

  for (final key in matchPriceKeys) {
    final price = _toDoubleValue(record[key]);
    if (price > 0) {
      return price;
    }
  }

  final ticketType = _mapOrEmpty(record['ticket_type']);
  final ticketTypePrice = _toDoubleValue(ticketType['price']);
  if (ticketTypePrice > 0) {
    return ticketTypePrice;
  }

  return 0;
}

Stats _mapStatisticLeader(
  Map<String, dynamic> record, {
  required String category,
}) {
  final player = _mapOrEmpty(record['player']);
  final club = _mapOrEmpty(record['club']);

  return Stats(
    rank: _toIntValue(record['rank']),
    playerId:
        _pickText(record, ['player_id'], fallback: _pickText(player, ['id'])),
    playerName: _pickText(player, ['name'], fallback: 'Unknown Player'),
    clubId: _pickText(club, ['id']),
    clubname: _pickText(club, ['name'], fallback: 'Unknown Club'),
    seasonId: _pickText(
      record,
      ['season_id'],
      fallback: service<AppPreferencesManager>()
              .currentContextValue
              ?.activeSeasonId ??
          '',
    ),
    avg: _toDoubleValue(
      record['average'] ??
          record['avg'] ??
          record['per_game'] ??
          record['total'],
    ),
    games: _toIntValue(record['games_played'] ?? record['games']),
    imageUrl: _assetUrl(
      player['profile_picture'] ?? player['image'] ?? player['avatar'],
    ),
  );
}

Product _mapFrontendShopProduct(Map<String, dynamic> record) {
  final club = _mapOrEmpty(record['club']);
  final priceRange = _mapOrEmpty(record['price_range']);
  final variants =
      _listOrEmpty(record['variants']).whereType<Map>().map((variant) {
    final item = Map<String, dynamic>.from(variant);
    return Variant(
      variantId: _pickText(item, ['id']),
      productTypeName: _pickText(item, ['name'], fallback: 'Variant'),
      productid: _pickText(record, ['id']),
      typePrice: _toDoubleValue(item['price']),
      units: _toIntValue(item['available_stock']),
    );
  }).toList();

  return Product(
    id: _pickText(record, ['id']),
    name: _pickText(record, ['name'], fallback: 'Product'),
    description: _pickText(
      record,
      ['short_description', 'description'],
      fallback: 'No description available',
    ),
    price: _toDoubleValue(priceRange['min']).toStringAsFixed(0),
    category: _pickText(club, ['name'], fallback: 'Merchandise'),
    imageUrl: _pickText(
      record,
      ['thumbnail'],
      fallback: _assetUrl(record['image']) ?? '',
    ),
    variants: variants,
  );
}

CartItem _mapFrontendCartItem(Map<String, dynamic> record) {
  return CartItem(
    id: _pickText(record, ['id']),
    productName: _pickText(record, ['item_name'], fallback: 'Cart Item'),
    productImage: '',
    category: _humanizeLabel(
      _pickText(record, ['item_type'], fallback: 'item'),
    ),
    variants: [
      CartVariant(
        variantID: _pickText(record, ['reference_uuid']),
        quantity: _toIntValue(record['quantity']),
        variantName: _pickText(record, ['item_name'], fallback: 'Item'),
        variantPrice: _toDoubleValue(record['unit_price']),
      ),
    ],
  );
}

Address _mapFrontendAddress(Map<String, dynamic> record) {
  return Address(
    id: _pickText(record, ['id']),
    name: _pickText(record, ['recipient_name', 'label'], fallback: ''),
    locality: _pickText(record, ['physical_address'], fallback: ''),
    city: _pickText(record, ['city'], fallback: ''),
    country: _pickText(record, ['country'], fallback: ''),
    phone: _pickText(record, ['phone'], fallback: ''),
    latitude: _stringOrNull(record['latitude']) == null
        ? null
        : _toDoubleValue(record['latitude']),
    longitude: _stringOrNull(record['longitude']) == null
        ? null
        : _toDoubleValue(record['longitude']),
    isDefault: record['is_default'] as bool?,
  );
}

PickupAddress _mapFrontendPickupAddress(Map<String, dynamic> record) {
  return PickupAddress(
    id: _pickText(record, ['id']),
    name: _pickText(record, ['name'], fallback: ''),
    locality: _pickText(
      record,
      ['physical_address'],
      fallback: _pickText(record, ['name'], fallback: ''),
    ),
    city: _pickText(record, ['city'], fallback: ''),
    country: _pickText(record, ['country'], fallback: ''),
    phone: _pickText(record, ['contact_phone'], fallback: ''),
    latitude: _stringOrNull(record['latitude']) == null
        ? null
        : _toDoubleValue(record['latitude']),
    longitude: _stringOrNull(record['longitude']) == null
        ? null
        : _toDoubleValue(record['longitude']),
    isDefault: record['is_active'] as bool?,
  );
}

Map<String, dynamic> _buildFrontendAddressPayload(Map<String, dynamic> data) {
  return {
    'label': _stringOrNull(data['label']) ?? 'Home',
    'recipient_name': _stringOrNull(data['recipient_name'] ?? data['fullName']),
    'phone': _stringOrNull(data['phone']),
    'country': _stringOrNull(data['country']),
    'city': _stringOrNull(data['city']),
    'physical_address': _stringOrNull(
        data['physical_address'] ?? data['line1'] ?? data['address']),
    'postal_code':
        _stringOrNull(data['postal_code'] ?? data['postalCode']) ?? '',
    'latitude': data['latitude'],
    'longitude': data['longitude'],
    'is_default': data['is_default'] ?? data['isDefault'] ?? false,
  }..removeWhere((key, value) => value == null);
}

List<Map<String, dynamic>> _legacyCartSelections(Map<String, dynamic> data) {
  final explicitReferenceType =
      _stringOrNull(data['reference_type']) ?? 'product_variant';
  final explicitReferenceUuid = _stringOrNull(
      data['reference_uuid'] ?? data['variantID'] ?? data['variantId']);
  final explicitQuantity = _toIntValue(data['quantity']);

  if (explicitReferenceUuid != null && explicitQuantity > 0) {
    return [
      {
        'reference_type': explicitReferenceType,
        'reference_uuid': explicitReferenceUuid,
        'quantity': explicitQuantity,
      },
    ];
  }

  final bundledItems =
      _listOrEmpty(data['bundledItems'] ?? data['bundleditems']);
  return bundledItems
      .whereType<Map>()
      .map((item) => Map<String, dynamic>.from(item))
      .map((item) => {
            'reference_type': _pickText(item, ['reference_type'],
                fallback: explicitReferenceType),
            'reference_uuid': _pickText(
              item,
              ['reference_uuid', 'variantID', 'variantId', 'productTypeID'],
            ),
            'quantity': _toIntValue(item['quantity']),
          })
      .where(
        (item) =>
            _stringOrNull(item['reference_uuid']) != null &&
            _toIntValue(item['quantity']) > 0,
      )
      .toList();
}

HttpResult<Map<String, dynamic>> _loadFrontendCart() async {
  return Http.get(
    _frontendShopCartBase,
    deserializer: (data) => _extractDataMap(data),
  );
}

String _mapPointsAction(Map<String, dynamic> record) {
  final type = _stringOrNull(record['type'])?.toLowerCase();
  final actionKey = _stringOrNull(record['action_key'])?.toLowerCase();

  if (type == 'spend') {
    return 'redeem';
  }

  if (actionKey == 'frontend.user.registered') {
    return 'followed';
  }

  if (actionKey != null && actionKey.contains('shared_ticket')) {
    return 'SHARED_TICKET';
  }

  if (actionKey != null && actionKey.contains('shared_ig_account')) {
    return 'SHARED_IG_ACCOUNT';
  }

  final description = _stringOrNull(record['description']);
  if (description != null && description.isNotEmpty) {
    return description;
  }

  if (actionKey != null && actionKey.isNotEmpty) {
    final lastToken = actionKey.split('.').last.replaceAll('_', ' ');
    return _humanizeLabel(lastToken);
  }

  return _humanizeLabel(_stringOrNull(record['type']) ?? 'points');
}

PointsData _mapFrontendPointsHistory(Map<String, dynamic> record) {
  return PointsData(
    pointid: _pickText(record, ['id']),
    txType: _humanizeLabel(_pickText(record, ['type'], fallback: 'points')),
    actualpoint: _toIntValue(record['points']).toString(),
    action: _mapPointsAction(record),
    externalRef: _pickText(
      record,
      ['reference_id', 'reference_type'],
      fallback: _pickText(record, ['id']),
    ),
    pointtimestamp: _pickText(
      record,
      ['awarded_at', 'created_at'],
      fallback: '',
    ),
  );
}

Notifications _mapFrontendNotification(Map<String, dynamic> record) {
  final dataPayload = _mapOrEmpty(record['data']);
  final notificationId = _pickText(record, ['id']);
  final title = _pickText(record, ['title']);
  final type = _pickText(record, ['type'], fallback: 'notification');

  return Notifications(
    id: notificationId.hashCode,
    userId: _pickText(record, ['frontend_user_uuid', 'user_id']),
    cartId: _stringOrNull(dataPayload['cart_id'] ?? dataPayload['match_id']),
    notificationType: title.isNotEmpty ? title : _humanizeLabel(type),
    channel: _pickText(record, ['channel'], fallback: 'push'),
    campaignId: _stringOrNull(dataPayload['campaign_id']),
    attributionWindow: null,
    notificationKey: notificationId.isNotEmpty ? notificationId : type,
    createdUtc: _pickText(record, ['created_at', 'sent_at'], fallback: ''),
    updatedUtc: _pickText(
      record,
      ['read_at', 'sent_at', 'created_at'],
      fallback: '',
    ),
    notificationText: _pickText(record, ['body'], fallback: ''),
  );
}

String _composeName(Map<String, dynamic> userData) {
  final fullName = _stringOrNull(userData['full_name']) ??
      _stringOrNull(userData['name']) ??
      _stringOrNull(userData['username']);
  if (fullName != null) {
    return fullName;
  }

  final firstName = _stringOrNull(userData['first_name']);
  final lastName = _stringOrNull(userData['last_name']);
  return [firstName, lastName].whereType<String>().join(' ').trim();
}

bool _resolveEmailVerified(
  Map<String, dynamic> userData, {
  required String action,
}) {
  final directFlag = userData['emailVerified'];
  if (directFlag is bool) {
    return directFlag;
  }

  if (userData['email_verified_at'] != null) {
    return true;
  }

  if (action == 'OTP verification') {
    return true;
  }

  if (action == 'signup') {
    return false;
  }

  return true;
}

FrontendContextData? _extractFrontendContext(dynamic responseData) {
  if (responseData is! Map) {
    return null;
  }

  final data = responseData['data'];
  Map<String, dynamic>? context;

  if (data is Map<String, dynamic>) {
    final nestedContext = data['context'];
    if (nestedContext is Map<String, dynamic>) {
      context = nestedContext;
    } else if (data.containsKey('active_league') ||
        data.containsKey('active_season')) {
      context = data;
    }
  }

  if (context == null) {
    return null;
  }

  final activeLeague = context['active_league'] as Map<String, dynamic>?;
  final activeSeason = context['active_season'] as Map<String, dynamic>?;
  final dataMap =
      data is Map<String, dynamic> ? data : const <String, dynamic>{};
  final domain = dataMap['domain'] as Map<String, dynamic>?;
  final branding = _extractBrandingMap(dataMap, context, domain);
  final activeClub = dataMap['active_club'] as Map<String, dynamic>?;
  final activeClubLogo = activeClub?['logo'] as Map<String, dynamic>?;
  final brandingLogo = branding?['logo'] as Map<String, dynamic>?;

  return FrontendContextData(
    activeLeagueId: _stringOrNull(activeLeague?['id'] ?? activeLeague?['uuid']),
    activeLeagueName: _stringOrNull(activeLeague?['name']),
    activeLeagueSport: _stringOrNull(activeLeague?['sport']),
    activeLeagueCountry: _stringOrNull(activeLeague?['country']),
    activeSeasonId: _stringOrNull(activeSeason?['id'] ?? activeSeason?['uuid']),
    activeSeasonName: _stringOrNull(activeSeason?['name']),
    activeClubId: _stringOrNull(activeClub?['id'] ?? activeClub?['uuid']),
    activeClubName: _stringOrNull(activeClub?['name']),
    activeClubLocation: _stringOrNull(activeClub?['location']),
    activeClubWebsite: _stringOrNull(activeClub?['website']),
    activeClubDescription: _stringOrNull(activeClub?['description']),
    activeClubContactNumber: _stringOrNull(activeClub?['contact_number']),
    activeClubEmail: _stringOrNull(activeClub?['email']),
    activeClubHeadCoachName: _stringOrNull(activeClub?['head_coach_name']),
    activeClubLogoUrl: _assetUrl(activeClubLogo),
    brandingName: _stringOrNull(
      branding?['name'] ?? activeClub?['name'] ?? activeLeague?['name'],
    ),
    brandingPrimaryColor: _stringOrNull(branding?['primary_color']),
    brandingSecondaryColor: _stringOrNull(branding?['secondary_color']),
    brandingAccentColor: _stringOrNull(branding?['accent_color']),
    brandingLogoUrl: _assetUrl(brandingLogo) ?? _assetUrl(activeClubLogo),
  );
}

Map<String, dynamic>? _extractBrandingMap(
  Map<String, dynamic> data,
  Map<String, dynamic> context,
  Map<String, dynamic>? domain,
) {
  final candidates = <Map<String, dynamic>>[
    if (data['branding'] is Map<String, dynamic>)
      data['branding'] as Map<String, dynamic>,
    if (context['branding'] is Map<String, dynamic>)
      context['branding'] as Map<String, dynamic>,
    if (domain?['branding'] is Map<String, dynamic>)
      domain!['branding'] as Map<String, dynamic>,
    if (domain?['branding_overrides'] is Map<String, dynamic>)
      domain!['branding_overrides'] as Map<String, dynamic>,
    if (context['branding_overrides'] is Map<String, dynamic>)
      context['branding_overrides'] as Map<String, dynamic>,
  ];

  for (final candidate in candidates) {
    if (candidate.isNotEmpty) {
      return candidate;
    }
  }

  return null;
}

User _mapFrontendUserFromResponse(
  Map<String, dynamic> responseData, {
  required String action,
}) {
  final dynamic rawUserData = responseData['userData'] ??
      (responseData['data'] is Map<String, dynamic>
          ? (responseData['data'] as Map<String, dynamic>)['user']
          : null) ??
      responseData['user'] ??
      responseData['data'];

  if (rawUserData is! Map) {
    final message = responseData['msg'] ??
        responseData['message'] ??
        "Invalid $action response from server";
    throw FormatException(message.toString());
  }

  final userData = Map<String, dynamic>.from(rawUserData);
  final nestedToken = responseData['data'] is Map<String, dynamic>
      ? responseData['data']['token']
      : null;
  final tokenMap = nestedToken is Map<String, dynamic>
      ? Map<String, dynamic>.from(nestedToken)
      : const <String, dynamic>{};

  final name = _composeName(userData);
  if (name.isEmpty) {
    throw const FormatException("Invalid user response from server");
  }

  return User(
    name: name,
    email: _stringOrNull(userData['email']) ?? '',
    emailVerified: _resolveEmailVerified(userData, action: action),
    picture: _assetUrl(
      userData['profile_picture'] ??
          userData['picture'] ??
          userData['avatar'] ??
          userData['photo'],
    ),
    token: _stringOrNull(responseData['accessToken']) ??
        _stringOrNull(tokenMap['access_token']),
    refreshToken: _stringOrNull(responseData['refreshToken']) ??
        _stringOrNull(tokenMap['refresh_token']),
    userID: _stringOrNull(userData['id']),
    phoneNumber: _stringOrNull(userData['phone'] ?? userData['phoneNumber']),
    dateOfBirth: _stringOrNull(userData['date_of_birth'] ?? userData['dob']),
  );
}

Map<String, dynamic> _buildFrontendRegisterPayload(Map<String, dynamic> data) {
  final firstName = _stringOrNull(data['first_name']) ??
      _stringOrNull(data['firstName']) ??
      _stringOrNull(data['name'])?.split(' ').first;
  final fullName = _stringOrNull(data['name']);
  final trailingNames = fullName?.split(' ').skip(1).join(' ').trim();
  final lastName = _stringOrNull(data['last_name']) ??
      _stringOrNull(data['lastName']) ??
      trailingNames;
  final context = service<AppPreferencesManager>().currentContextValue;

  final payload = <String, dynamic>{
    'first_name': firstName,
    'last_name': lastName,
    'email': _stringOrNull(data['email']),
    'phone': _stringOrNull(data['phone'] ?? data['phoneNo']),
    'password': _stringOrNull(data['password']),
    'password_confirmation': _stringOrNull(
      data['password_confirmation'] ??
          data['confirmpassword'] ??
          data['password'],
    ),
    'preferred_league_id':
        _stringOrNull(data['preferred_league_id']) ?? context?.activeLeagueId,
    'preferred_season_id':
        _stringOrNull(data['preferred_season_id']) ?? context?.activeSeasonId,
  };

  payload.removeWhere((key, value) => value == null || value == '');
  return payload;
}

Map<String, dynamic> _buildFrontendProfilePayload(Map<String, String> data) {
  final payload = <String, dynamic>{
    'first_name': _stringOrNull(data['first_name'] ?? data['firstName']),
    'last_name': _stringOrNull(data['last_name'] ?? data['secondName']),
    'email': _stringOrNull(data['email']),
    'phone': _stringOrNull(data['phone'] ?? data['phoneNo']),
    'preferred_league_id': _stringOrNull(data['preferred_league_id']),
    'preferred_season_id': _stringOrNull(data['preferred_season_id']),
  };

  payload.removeWhere((key, value) => value == null || value == '');
  return payload;
}

Map<String, String>? _buildContextHeaders({
  String? leagueId,
  String? seasonId,
}) {
  final headers = <String, String>{
    if (_stringOrNull(leagueId) != null)
      AppConfig.leagueHeaderName: leagueId!.trim(),
    if (_stringOrNull(seasonId) != null)
      AppConfig.seasonHeaderName: seasonId!.trim(),
  };

  return headers.isEmpty ? null : headers;
}

class ContextService {
  HttpResult<FrontendContextData> getContext({
    String? leagueId,
    String? seasonId,
  }) async {
    return Http.get(
      _domainContextBase,
      useAuthToken: false,
      headers: _buildContextHeaders(
        leagueId: leagueId,
        seasonId: seasonId,
      ),
      deserializer: (data) {
        final context = _extractFrontendContext(data);
        if (context == null) {
          throw const FormatException("Unable to load domain context");
        }
        return context;
      },
    );
  }

  HttpResult<FrontendContextData> switchLeague(String leagueId) async {
    return Http.post(
      "$_mobileContextBase/league",
      {'league_id': leagueId},
      deserializer: (data) {
        final context = _extractFrontendContext(data);
        if (context == null) {
          throw const FormatException("Unable to switch league");
        }
        return context;
      },
    );
  }

  HttpResult<FrontendContextData> switchSeason(String seasonId) async {
    return Http.post(
      "$_mobileContextBase/season",
      {'season_id': seasonId},
      deserializer: (data) {
        final context = _extractFrontendContext(data);
        if (context == null) {
          throw const FormatException("Unable to switch season");
        }
        return context;
      },
    );
  }
}

class AuthService {
  AuthenticatedUserPayload _deserializeUserResponse(
    dynamic responseData, {
    required String action,
  }) {
    if (responseData is! Map) {
      service<Talker>().error(
        "Invalid $action response type: ${responseData.runtimeType}",
      );
      throw FormatException("Invalid $action response from server");
    }

    final payload = Map<String, dynamic>.from(responseData);
    final user = _mapFrontendUserFromResponse(payload, action: action);
    return AuthenticatedUserPayload(
      user: user,
      context: _extractFrontendContext(payload),
    );
  }

  HttpResult<dynamic> login(Map<String, dynamic> data) async {
    return Http.post(
      "$_frontendAuthBase/login",
      {
        'email': _stringOrNull(data['email']),
        'password': _stringOrNull(data['password']),
      },
      useAuthToken: false,
      deserializer: (data) => _deserializeUserResponse(data, action: "login"),
    );
  }

  HttpResult<dynamic> refreshToken(String token) async {
    return Http.post(
      "$_frontendAuthBase/refresh",
      {
        "refresh_token": token,
      },
      useAuthToken: false,
      deserializer: (data) {
        if (data is! Map) {
          throw const FormatException("Invalid refresh response from server");
        }

        final payload = Map<String, dynamic>.from(data);
        final tokenData = payload['data'] is Map<String, dynamic>
            ? payload['data']['token']
            : null;
        final tokenMap = tokenData is Map<String, dynamic>
            ? Map<String, dynamic>.from(tokenData)
            : const <String, dynamic>{};

        final accessToken = _stringOrNull(payload['accessToken']) ??
            _stringOrNull(tokenMap['access_token']);
        if (accessToken == null) {
          throw const FormatException("Invalid refresh response from server");
        }

        final expiresInRaw = tokenMap['expires_in'];
        final expiresIn = expiresInRaw is int
            ? expiresInRaw
            : int.tryParse(expiresInRaw?.toString() ?? '');

        return RefreshTokenPayload(
          accessToken: accessToken,
          refreshToken: _stringOrNull(payload['refreshToken']) ??
              _stringOrNull(tokenMap['refresh_token']),
          expiresIn: expiresIn,
        );
      },
    );
  }

  HttpResult<dynamic> signup(Map<String, dynamic> data) async {
    return Http.post(
      "$_frontendAuthBase/register",
      _buildFrontendRegisterPayload(data),
      useAuthToken: false,
      deserializer: (data) => _deserializeUserResponse(data, action: "signup"),
    );
  }

  HttpResult<dynamic> verifyOtp(Map<String, dynamic> data) async {
    return Http.post(
      "$_frontendAuthBase/verify-otp",
      {
        'email': _stringOrNull(data['email']),
        'purpose': _stringOrNull(data['purpose']) ?? 'email_verification',
        'otp': _stringOrNull(data['otp']),
      },
      useAuthToken: false,
      deserializer: (_) {
        final currentUser = service<AppPreferencesManager>().currentUserValue;
        if (currentUser == null) {
          throw const FormatException("No active user found to verify");
        }

        return AuthenticatedUserPayload(
          user: currentUser.copyWith(emailVerified: true),
          context: service<AppPreferencesManager>().currentContextValue,
        );
      },
    );
  }

  HttpResult<dynamic> googleLogin(Map<String, dynamic> data) async {
    return Http.post(
      "$_frontendAuthBase/social/google",
      {
        'access_token': _stringOrNull(data['access_token']),
      },
      useAuthToken: false,
      deserializer: (data) =>
          _deserializeUserResponse(data, action: "Google login"),
    );
  }

  HttpResult<dynamic> appleLogin(Map<String, dynamic> data) async {
    return Http.post(
      "$_frontendAuthBase/social/apple",
      {
        'identity_token':
            _stringOrNull(data['identity_token'] ?? data['identityToken']),
        'authorization_code': _stringOrNull(
            data['authorization_code'] ?? data['authorizationCode']),
        'email': _stringOrNull(data['email']),
        'first_name': _stringOrNull(data['first_name'] ?? data['firstName']),
        'last_name': _stringOrNull(data['last_name'] ?? data['lastName']),
        'name': _stringOrNull(data['name']),
      }..removeWhere((key, value) => value == null || value == ''),
      useAuthToken: false,
      deserializer: (data) =>
          _deserializeUserResponse(data, action: "Apple login"),
    );
  }

  HttpResult<String> resendOtp(Map<String, dynamic> data) async {
    return Http.post(
      "$_frontendAuthBase/request-otp",
      {
        'email': _stringOrNull(data['email']),
        'purpose': _stringOrNull(data['purpose']) ?? 'email_verification',
      },
      useAuthToken: false,
      deserializer: (data) => data["message"] ?? data["msg"],
    );
  }

  HttpResult<String> logout() async {
    return Http.post(
      "$_frontendAuthBase/logout",
      {},
      deserializer: (data) => data["message"] ?? data["msg"],
    );
  }

  HttpResult<String> deleteMe() async {
    return Http.delete(
      "$_frontendAuthBase/account",
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
      "$_frontendAuthBase/me",
      deserializer: (data) {
        if (data is! Map) {
          throw const FormatException("Invalid profile response from server");
        }

        final payload = Map<String, dynamic>.from(data);
        return _mapFrontendUserFromResponse(payload, action: "profile");
      },
    );
  }

  HttpResult<User> updateProfilePicture(FormData data) async {
    return Http.post(
      "$_frontendAuthBase/profile/image",
      data,
      deserializer: (responseData) {
        final payload = _extractDataMap(responseData);
        final userRecord = _mapOrEmpty(payload['user']);
        final currentUser = service<AppPreferencesManager>().currentUserValue;

        if (currentUser == null) {
          throw const FormatException(
              "Please sign in to update profile image.");
        }

        final picture = _assetUrl(
          userRecord['avatar'] ??
              userRecord['profile_picture'] ??
              userRecord['picture'],
        );

        if (picture == null || picture.isEmpty) {
          throw const FormatException(
            "Profile image upload did not return an image.",
          );
        }

        final resolvedName = _composeName(userRecord);

        return currentUser.copyWith(
          name: resolvedName.isEmpty ? currentUser.name : resolvedName,
          picture: picture,
        );
      },
    );
  }

  HttpResult<User> updateProfile(Map<String, String> data) async {
    return Http.patch(
      "$_frontendAuthBase/profile",
      _buildFrontendProfilePayload(data),
      deserializer: (responseData) {
        if (responseData is! Map) {
          service<Talker>().error("Failed to update profile: $responseData");
          throw Exception("Failed to update: $responseData");
        }

        return _mapFrontendUserFromResponse(
          Map<String, dynamic>.from(responseData),
          action: "profile update",
        );
      },
    );
  }
}

class NotificationService {
  HttpResult<List<Notifications>> getNotifications() async {
    return Http.get(
      _frontendNotificationsBase,
      queryParams: {
        ..._frontendContextPayload(),
        'per_page': 50,
      },
      deserializer: (data) {
        List<Notifications> notificationList = [];
        for (final record in _extractDataList(data)) {
          try {
            final notification = _mapFrontendNotification(record);
            notificationList.add(notification);
          } catch (e) {
            service<Talker>().error("Error parsing notification record: $e");
          }
        }
        return notificationList;
      },
    );
  }

  HttpResult<String> markNotificationRead(String notificationId) async {
    return Http.patch(
      "$_frontendNotificationsBase/$notificationId/read",
      const <String, dynamic>{},
      deserializer: (data) {
        final payload = _mapOrEmpty(data);
        return _pickText(
          payload,
          ['message'],
          fallback: 'Notification marked as read.',
        );
      },
    );
  }

  HttpResult<String> markAllNotificationsRead() async {
    return Http.patch(
      "$_frontendNotificationsBase/read-all",
      const <String, dynamic>{},
      deserializer: (data) {
        final payload = _mapOrEmpty(data);
        return _pickText(
          payload,
          ['message'],
          fallback: 'All notifications marked as read.',
        );
      },
    );
  }
}

class TicketSummaryData {
  final int total;
  final int issued;
  final int used;
  final int upcoming;

  const TicketSummaryData({
    required this.total,
    required this.issued,
    required this.used,
    required this.upcoming,
  });
}

class OrderService {
  HttpResult<List<Map<String, dynamic>>> getOrders({
    int perPage = 20,
  }) async {
    return Http.get(
      _frontendShopOrdersBase,
      queryParams: {
        ..._frontendContextPayload(),
        'per_page': perPage,
      },
      deserializer: (data) {
        return _extractDataList(data)
            .map((record) => Map<String, dynamic>.from(record))
            .toList();
      },
    );
  }

  HttpResult<Map<String, dynamic>> getOrder(String orderId) async {
    return Http.get(
      "$_frontendShopOrdersBase/$orderId",
      queryParams: {
        ..._frontendContextPayload(),
      },
      deserializer: (data) => _extractDataMap(data),
    );
  }
}

class TicketService {
  HttpResult<TicketSummaryData> getTicketSummary() async {
    return Http.get(
      _frontendShopTicketSummaryBase,
      queryParams: {
        ..._frontendContextPayload(),
      },
      deserializer: (data) {
        final payload = _extractDataMap(data);
        return TicketSummaryData(
          total: _toIntValue(payload['total']),
          issued: _toIntValue(payload['issued']),
          used: _toIntValue(payload['used']),
          upcoming: _toIntValue(payload['upcoming']),
        );
      },
    );
  }

  HttpResult<List<Map<String, dynamic>>> getTickets({
    String? search,
    String? status,
    String? matchId,
    String? ticketTypeId,
    String? clubId,
    bool? upcomingOnly,
    int perPage = 20,
  }) async {
    return Http.get(
      _frontendShopTicketsBase,
      queryParams: {
        ..._frontendContextPayload(),
        if (_stringOrNull(search) != null) 'search': search,
        if (_stringOrNull(status) != null) 'status': status,
        if (_stringOrNull(matchId) != null) 'match_id': matchId,
        if (_stringOrNull(ticketTypeId) != null) 'ticket_type_id': ticketTypeId,
        if (_stringOrNull(clubId) != null) 'club_id': clubId,
        if (upcomingOnly != null) 'upcoming_only': upcomingOnly,
        'per_page': perPage,
      },
      deserializer: (data) {
        return _extractDataList(data)
            .map((record) => Map<String, dynamic>.from(record))
            .toList();
      },
    );
  }

  HttpResult<Map<String, dynamic>> getTicket(String ticketId) async {
    return Http.get(
      "$_frontendShopTicketsBase/$ticketId",
      queryParams: {
        ..._frontendContextPayload(),
      },
      deserializer: (data) => _extractDataMap(data),
    );
  }
}

class MediaService {
  Future<MultipleResult<List<MediaData>>> getMedia() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/media_data.json');
      final localJson = json.decode(jsonString);
      final List<Highlight> localHighlights =
          (localJson['recentHighlights'] as List)
              .map((e) => Highlight.fromJson(e))
              .toList();
      final List<SeasonHighlight> localSeasonHighlights =
          (localJson['seasonHighlights'] as List)
              .map((e) => SeasonHighlight.fromJson(e))
              .toList();
      final remoteResponse = await Http.get<List<SeasonHighlight>>(
        "$_mobileMediaBase/highlights",
        queryParams: {'per_page': 20},
        deserializer: (data) {
          return _extractDataList(data).map((record) {
            final imageUrl = _assetUrl(
                  record['image'] ??
                      record['cover_asset'] ??
                      record['thumbnail'] ??
                      record['asset'],
                ) ??
                '';
            final timestamp = _pickText(
              record,
              ['published_at', 'created_at', 'scheduled_at', 'starts_at'],
            );

            return SeasonHighlight(
              title:
                  _pickText(record, ['title', 'name'], fallback: 'Highlight'),
              image: imageUrl,
              time: timestamp,
              date: timestamp,
              url: _pickText(
                record,
                ['url', 'video_url', 'youtube_url'],
                fallback: imageUrl,
              ),
              type: _stringOrNull(record['type']) ??
                  (imageUrl.endsWith('.mp4') ? 'video' : 'image'),
            );
          }).toList();
        },
      );

      if (remoteResponse is Success<List<SeasonHighlight>>) {
        return MultipleResult.onSuccess(
          data: [
            MediaData(
              recentHighlights: localHighlights,
              seasonHighlights: [
                ...remoteResponse.data,
                ...localSeasonHighlights,
              ],
            ),
          ],
        );
      }

      return MultipleResult.onSuccess(
        data: [
          MediaData(
            recentHighlights: localHighlights,
            seasonHighlights: localSeasonHighlights,
          ),
        ],
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
        _mobileHomeBase,
        deserializer: (data) {
          final payload = _extractDataMap(data);
          final banners = _listOrEmpty(payload['banners']);
          final highlights = _listOrEmpty(payload['highlights']);
          final source = banners.isNotEmpty ? banners : highlights;

          return source.whereType<Map>().map((item) {
            final record = Map<String, dynamic>.from(item);
            final cta = _mapOrEmpty(record['cta']);
            final imageUrl = _assetUrl(record['image']) ?? '';
            final rawTargetUrl = _pickText(
              cta,
              ['target'],
              fallback:
                  _pickText(record, ['cta_url', 'url'], fallback: imageUrl),
            );
            final mediaType = _pickText(
              cta,
              ['type'],
              fallback: _stringOrNull(record['type']) ?? 'image',
            );
            final resolvedUrl = mediaType.toLowerCase().contains('video') ||
                    mediaType.toLowerCase().contains('youtube') ||
                    rawTargetUrl.toLowerCase().endsWith('.mp4')
                ? rawTargetUrl
                : imageUrl;

            return HighlightReel(
              title: _pickText(
                record,
                ['title', 'name', 'subtitle'],
                fallback: 'Media',
              ),
              type: mediaType,
              url: resolvedUrl.isEmpty ? imageUrl : resolvedUrl,
              image: imageUrl,
            );
          }).toList();
        },
      );
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: "getHomeMedia failed",
        fatal: false,
      );

      return MultipleResult.onError(
        error: Failure(error: "Failed to load media: $e"),
      );
    }
  }
}

class RoasterService {
  HttpResult<List<RoasterData>> getRoasters(String? clubid) async {
    if (_stringOrNull(clubid) == null) {
      return MultipleResult.onSuccess(data: const <RoasterData>[]);
    }

    return Http.get(
      "$_mobileClubsBase/$clubid/players",
      queryParams: {'per_page': 50},
      deserializer: (data) {
        return _extractDataList(data).map((record) {
          final club = _mapOrEmpty(record['club']);
          return RoasterData(
            playerId: _pickText(record, ['id']),
            playerName: _pickText(record, ['name'], fallback: 'Unknown Player'),
            position: _pickText(record, ['position'], fallback: '-'),
            imageUrl: _assetUrl(record['profile_picture']) ?? '',
            playerHeight: _formatHeight(
              record['height_feet'],
              record['height_inches'],
            ),
            playerWeight: _formatWeight(record['weight']),
            playerNumber: _pickText(
              record,
              ['jersey_number'],
              fallback: '-',
            ),
            stats: <String, dynamic>{
              if (_pickText(club, ['name']).isNotEmpty)
                'Club': _pickText(club, ['name']),
              if (_pickText(record, ['sport']).isNotEmpty)
                'Sport': _pickText(record, ['sport']),
            },
          );
        }).toList();
      },
    );
  }

  HttpResult<List<ClubRoasterData>> getLeagueRoasters() async {
    return Http.get(
      _mobileClubsBase,
      queryParams: {'per_page': 50},
      deserializer: (data) {
        return _extractDataList(data)
            .map((record) => ClubRoasterData(
                  id: _pickText(record, ['id']),
                  name: _pickText(record, ['name'], fallback: 'Club'),
                  leagueId: _pickText(record, ['league_id']),
                  imageUrl: _assetUrl(record['logo']) ?? '',
                ))
            .toList();
      },
    );
  }

  HttpResult<List<RoasterData>> getTeamRoasters() async {
    return Http.get(
      _mobilePlayersBase,
      queryParams: {'per_page': 50},
      deserializer: (data) {
        return _extractDataList(data).map((record) {
          return RoasterData(
            playerId: _pickText(record, ['id']),
            playerName: _pickText(record, ['name'], fallback: 'Unknown Player'),
            position: _pickText(record, ['position'], fallback: '-'),
            imageUrl: _assetUrl(record['profile_picture']) ?? '',
            playerHeight: _formatHeight(
              record['height_feet'],
              record['height_inches'],
            ),
            playerWeight: _formatWeight(record['weight']),
            playerNumber: _pickText(record, ['jersey_number'], fallback: '-'),
            stats: const <String, dynamic>{},
          );
        }).toList();
      },
    );
  }
}

class StatService {
  HttpResult<Map<String, List<Stats>>> getStats(String? clubId) async {
    final categoriesResponse = await Http.get<List<Map<String, dynamic>>>(
      "$_mobileStatisticsBase/categories",
      deserializer: (data) {
        return _extractDataList(data);
      },
    );

    if (categoriesResponse is Error<List<Map<String, dynamic>>>) {
      return MultipleResult.onError(error: categoriesResponse.error);
    }

    final categories =
        (categoriesResponse as Success<List<Map<String, dynamic>>>)
            .data
            .where((record) =>
                _pickText(record, ['scope'], fallback: 'player') == 'player')
            .take(6)
            .toList();

    final leadersByCategory = await Future.wait(
      categories.map((category) async {
        final categoryCode = _pickText(category, ['code']);
        final categoryLabel = _pickText(
          category,
          ['label'],
          fallback: _humanizeLabel(categoryCode),
        );

        final leadersResponse = await Http.get<Map<String, dynamic>>(
          "$_mobileStatisticsBase/leaders",
          queryParams: {
            'category': categoryCode,
            'limit': 10,
            if (_stringOrNull(clubId) != null) 'club_id': clubId,
          },
          deserializer: (data) => _extractDataMap(data),
        );

        if (leadersResponse is Success<Map<String, dynamic>>) {
          final leaders = _listOrEmpty(leadersResponse.data['leaders'])
              .whereType<Map>()
              .map(
                (entry) => _mapStatisticLeader(
                  Map<String, dynamic>.from(entry),
                  category: categoryCode,
                ),
              )
              .toList();

          return MapEntry(categoryLabel, leaders);
        }

        return MapEntry(categoryLabel, const <Stats>[]);
      }),
    );

    final statsByCategory = <String, List<Stats>>{
      for (final entry in leadersByCategory)
        if (entry.value.isNotEmpty) entry.key: entry.value,
    };

    return MultipleResult.onSuccess(data: statsByCategory);
  }

  HttpResult<Map<String, Map<String, List<MatchStatLeader>>>>
      getMatchStatLeaders(
    String matchId,
  ) async {
    return Http.get(
      "$_mobileMatchesBase/$matchId",
      queryParams: _frontendContextPayload(),
      deserializer: (data) {
        final payload = _extractDataMap(data);
        final statistics = _mapOrEmpty(payload['statistics']);
        final leadersPayload = _mapOrEmpty(statistics['leaders']);
        final homeClub = _mapOrEmpty(payload['home_club']);
        final awayClub = _mapOrEmpty(payload['away_club']);
        final homeClubName = _pickText(homeClub, ['name']);
        final awayClubName = _pickText(awayClub, ['name']);
        final homeClubId = _pickText(homeClub, ['id']);
        final awayClubId = _pickText(awayClub, ['id']);
        final leadersByCategory =
            <String, Map<String, List<MatchStatLeader>>>{};

        leadersPayload.forEach((rawCategory, rawEntries) {
          final category = _humanizeLabel(rawCategory);
          final leadersByClub = <String, List<MatchStatLeader>>{};
          final entries = _listOrEmpty(rawEntries).whereType<Map>().toList();

          for (var index = 0; index < entries.length; index++) {
            final entry = Map<String, dynamic>.from(entries[index]);
            final player = _mapOrEmpty(entry['player']);
            final teamSide =
                _pickText(entry, ['team_side'], fallback: '').toLowerCase();
            final clubName = _pickText(
              player,
              ['club_name'],
              fallback: teamSide == 'away' ? awayClubName : homeClubName,
            );
            final clubId = _pickText(
              player,
              ['club_id'],
              fallback: teamSide == 'away' ? awayClubId : homeClubId,
            );

            if (clubName.isEmpty) {
              continue;
            }

            leadersByClub.putIfAbsent(clubName, () => <MatchStatLeader>[]);
            leadersByClub[clubName]!.add(
              MatchStatLeader(
                playerId: _pickText(player, ['id'], fallback: ''),
                playerName: _pickText(
                  player,
                  ['name', 'full_name'],
                  fallback: 'Unknown Player',
                ),
                clubId: clubId,
                clubName: clubName,
                stat: _toIntValue(entry['value']),
                rank: index + 1,
              ),
            );
          }

          for (final leaders in leadersByClub.values) {
            leaders.sort((a, b) {
              final rankCompare = a.rank.compareTo(b.rank);
              if (rankCompare != 0) return rankCompare;
              return b.stat.compareTo(a.stat);
            });
          }

          if (leadersByClub.isNotEmpty) {
            leadersByCategory[category] = leadersByClub;
          }
        });

        return leadersByCategory;
      },
    );
  }

  HttpResult<List<PlayerStatResponse>> getPlayerStats(String playerID) async {
    return Http.get(
      "$_mobilePlayersBase/$playerID/stats",
      deserializer: (data) {
        final payload = _extractDataMap(data);
        final recentMatches = _listOrEmpty(payload['recent_matches']);

        return recentMatches.whereType<Map>().map((item) {
          final record = Map<String, dynamic>.from(item);
          final match = _mapOrEmpty(record['match']);
          final statsMap = _mapOrEmpty(record['stats']);

          return PlayerStatResponse(
            matchId: _pickText(match, ['id']),
            scoreboard: _matchScoreLine(match),
            matchTitle: _pickText(
              match,
              ['name', 'title'],
              fallback: _pickText(
                match,
                ['scheduled_at', 'kickoff_at'],
                fallback: 'Match',
              ),
            ),
            statsByType: statsMap.entries
                .map(
                  (entry) => StatsByType(
                    statType: StatType(
                      stattype: _humanizeLabel(entry.key),
                    ),
                    count: _toIntValue(entry.value),
                  ),
                )
                .toList(),
          );
        }).toList();
      },
    );
  }

  HttpResult<List<HighlightReel>> getPlayerMedia(String playerID) async {
    return Http.get(
      "$_mobileMediaBase/players/$playerID",
      queryParams: {'per_page': 20},
      deserializer: (data) {
        final albums = _extractDataList(data);
        return albums.map((record) {
          final imageUrl = _assetUrl(
                record['cover_asset'] ?? record['image'] ?? record['thumbnail'],
              ) ??
              '';
          return HighlightReel(
            title: _pickText(record, ['name', 'title'], fallback: 'Media'),
            type: _pickText(record, ['album_type'], fallback: 'image'),
            url: imageUrl,
            image: imageUrl,
          );
        }).toList();
      },
    );
  }
}

class TeamStatsService {
  HttpResult<List<TeamStatsData>> getTeamStats() async {
    return Http.get(
      _mobileStandingsBase,
      deserializer: (data) {
        return _extractDataList(data).map((record) {
          final club = _mapOrEmpty(record['club']);
          final played = _toIntValue(record['played']);
          final wins = _toIntValue(record['wins']);
          return TeamStatsData(
            teamId: _pickText(record, ['club_id'],
                fallback: _pickText(club, ['id'])),
            teamName: _pickText(club, ['name'], fallback: 'Club'),
            rank: _toIntValue(record['rank']),
            gamesPlayed: played,
            wins: wins,
            draws: _toIntValue(record['draws']),
            forfeits: 0,
            losses: _toIntValue(record['losses']),
            pointsScored: _toIntValue(record['points_for']),
            pointsAgainst: _toIntValue(record['points_against']),
            pointsDifference: _toIntValue(record['point_difference']),
            points: _toIntValue(record['standing_points']),
            winPercentage: played == 0 ? 0 : wins / played,
            season: service<AppPreferencesManager>()
                    .currentContextValue
                    ?.activeSeasonName ??
                '',
          );
        }).toList();
      },
    );
  }
}

class PointsService {
  HttpResult<String> addPoints(Map<String, dynamic> data) async {
    final actionKey = _resolvePointsActionKey(
      _stringOrNull(data['action_key'] ?? data['actionCode']),
    );
    if (actionKey == null) {
      return MultipleResult.onError(
        error: Failure(error: "Points action is missing."),
      );
    }

    final referenceType = _stringOrNull(data['reference_type']) ?? 'match';
    final referenceId = _stringOrNull(
      data['reference_id'] ?? data['referenceId'] ?? data['externalRef'],
    );
    final metadata = <String, dynamic>{
      ..._mapOrEmpty(data['metadata']),
      'channel': _stringOrNull(
            data['channel'] ?? data['shareChannel'] ?? data['source'],
          ) ??
          'app_share',
    }..removeWhere((key, value) => value == null || value == '');

    return Http.post(
      _frontendPointsEarnBase,
      {
        ..._frontendContextPayload(),
        'action_key': actionKey,
        if (referenceId != null) 'reference_type': referenceType,
        if (referenceId != null) 'reference_id': referenceId,
        'description': _stringOrNull(data['description']) ??
            'Awarded after sharing match.',
        if (metadata.isNotEmpty) 'metadata': metadata,
      },
      deserializer: (responseData) {
        final responseMap = _mapOrEmpty(responseData);
        return _pickText(
          responseMap,
          ['message', 'msg'],
          fallback: 'Points awarded successfully.',
        );
      },
    );
  }

  HttpResult<String> transferPoints(Map<String, dynamic> data) async {
    final recipientUuid = _stringOrNull(
      data['recipient_frontend_user_uuid'] ??
          data['recipientUserId'] ??
          data['recipient_user_id'],
    );
    if (recipientUuid == null) {
      return MultipleResult.onError(
        error: Failure(
          error:
              'Points transfer now requires the recipient user ID. The current screen only captures email, so backend user lookup is still needed.',
        ),
      );
    }

    final points = _toIntValue(data['points']);
    if (points <= 0) {
      return MultipleResult.onError(
        error: Failure(error: "Please enter a valid points amount."),
      );
    }

    return Http.post(
      _frontendPointsTransferBase,
      {
        ..._frontendContextPayload(),
        'recipient_frontend_user_uuid': recipientUuid,
        'points': points,
        if (_stringOrNull(data['description']) != null)
          'description': _stringOrNull(data['description']),
      },
      deserializer: (responseData, {int? statusCode}) {
        final responseMap = _mapOrEmpty(responseData);
        return _pickText(
          responseMap,
          ['message', 'msg'],
          fallback: 'Points transferred successfully.',
        );
      },
    );
  }

  HttpResult<List<PointsData>> getPoints() async {
    try {
      return Http.get(
        _frontendPointsHistoryBase,
        queryParams: {
          ..._frontendContextPayload(),
          'per_page': 50,
        },
        deserializer: (responseData) {
          if (responseData == null) {
            service<Talker>().error("Failed to add points: $responseData");
            throw Exception("Failed to update: $responseData");
          }

          return _extractDataList(responseData)
              .map(_mapFrontendPointsHistory)
              .toList();
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
      _frontendPointsWalletBase,
      queryParams: {
        ..._frontendContextPayload(),
      },
      deserializer: (data) => _extractDataMap(data)['balance'],
    );
  }
}

String? _resolvePointsActionKey(String? rawAction) {
  if (rawAction == null || rawAction.isEmpty) {
    return null;
  }

  final normalized = rawAction.trim().toLowerCase();
  switch (normalized) {
    case 'shared_ticket':
    case 'frontend.ticket.shared':
      return 'frontend.ticket.shared';
    case 'shared_ig_account':
    case 'frontend.instagram.shared':
      return 'frontend.instagram.shared';
    default:
      return rawAction.contains('.') ? rawAction : 'frontend.$normalized';
  }
}
