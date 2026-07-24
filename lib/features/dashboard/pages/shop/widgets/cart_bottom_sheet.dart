part of "../shop_page.dart";

Future<void> showCartShopBottomSheet(BuildContext context,
    {required PointsState pointsState}) async {
  final parentContext = context;
  final cartBloc = context.read<CartBloc>();
  final currentUser = service<AppPreferencesManager>().currentUserValue;
  final userEmail = currentUser?.email.trim();

  if (userEmail == null || userEmail.isEmpty) {
    SnackbarService.show(
      'Please sign in to view your cart.',
      backgroundColor: AppColors.blackColor,
    );
    context.go('/signIn');
    return;
  }

  cartBloc.add(
    CartEvent.getCartItems(
      request: {
        "email": userEmail,
      },
    ),
  );

  final cartState = await cartBloc.stream
      .firstWhere(
        (state) =>
            state.status == CartStatus.success ||
            state.status == CartStatus.failure,
      )
      .timeout(
        const Duration(seconds: 10),
        onTimeout: () => cartBloc.state,
      );

  if (!context.mounted) return;

  if (cartState.status == CartStatus.failure) {
    SnackbarService.showError(
      cartState.failure?.error ?? 'Unable to load your cart right now.',
    );
    return;
  }

  if (cartState.cartItems.isEmpty) {
    SnackbarService.show(
      'Your cart is empty.',
      backgroundColor: AppColors.blackColor,
    );
    return;
  }

  // Fetch addresses from AddressBloc
  context.read<AddressBloc>().add(
        AddressEvent.getAddresses(request: {
          "email": userEmail,
        }),
      );

  context.read<AddressBloc>().add(
        const AddressEvent.getPickupAddresses(),
      );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) {
      return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.status == ProductStatus.processingPayment) {
            SnackbarService.show(
              'Securing Payment',
              backgroundColor: AppColors.blackColor,
            );
            return;
          }

          if (state.status == ProductStatus.failure) {
            AnimatedOverlaySnackbar.show(
              context,
              state.failure?.error ?? 'Unable to continue checkout.',
              color: AppColors.defaultAppRed,
            );
            return;
          }

          if (state.status != ProductStatus.successfulPayment) {
            return;
          }

          final checkout = service<ProductService>().latestCheckoutResult;
          if (checkout == null) {
            AnimatedOverlaySnackbar.show(
              context,
              'Unable to continue checkout right now.',
              color: AppColors.defaultAppRed,
            );
            return;
          }

          Navigator.of(sheetContext).pop();
          handleFrontendCheckoutSuccess(parentContext, checkout);
        },
        builder: (context, productState) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cartItems = state.cartItems;
              final isLoading = state.status == CartStatus.loading;

              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return BlocBuilder<AddressBloc, AddressState>(
                builder: (context, addressState) {
                  final addresses = addressState.data;
                  final pickupAddresses = addressState.pickupAddresses;
                  return _ShopCartBottomSheetContent(
                    isLoading: isLoading,
                    cartItems: cartItems,
                    addresses: addresses,
                    pickupAddresses: pickupAddresses,
                    pointsState: pointsState,
                    isProcessingCheckout:
                        productState.status == ProductStatus.processingPayment,
                  );
                },
              );
            },
          );
        },
      );
    },
  );
}

const kGoogleApiKey = "AIzaSyCvhu2jSnZg_8TARHCU4cY4JjyrzcG5Eho";

class _ShopCartBottomSheetContent extends StatefulWidget {
  final bool isLoading;
  final List<CartItem> cartItems;
  final List<Address> addresses;
  final List<PickupAddress> pickupAddresses;
  final PointsState pointsState;
  final bool isProcessingCheckout;

  const _ShopCartBottomSheetContent({
    required this.isLoading,
    required this.cartItems,
    required this.addresses,
    required this.pickupAddresses,
    required this.pointsState,
    required this.isProcessingCheckout,
  });

  @override
  State<_ShopCartBottomSheetContent> createState() =>
      _ShopCartBottomSheetContentState();
}

class _ShopCartBottomSheetContentState
    extends State<_ShopCartBottomSheetContent> {
  late List<CartItem> _items;
  late TextEditingController pointsController;
  late TextEditingController promoCodeController;
  String? pointsError;
  String? promoError;
  bool _isValidatingPromotion = false;
  FrontendPromotionValidationResult? _appliedPromotion;

  int _selectedTab = 0; // 0 = Delivery, 1 = Pick-Up

  Address? _selectedAddressDropdown;

  PickupAddress? _selectedPickupAddressDropdown;

  // Constants
  static const double _maxQty = 999;
  static const double _initialSheetSize = 0.82;
  static const double _minSheetSize = 0.45;
  static const double _maxSheetSize = 0.95;
  static const String _currency = "Ksh";

  @override
  void initState() {
    super.initState();
    _items = List<CartItem>.from(widget.cartItems);
    pointsController = TextEditingController();
    promoCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pointsController.dispose();
    promoCodeController.dispose();
    super.dispose();
  }

  double get _subtotal {
    double sum = 0;
    for (final product in _items) {
      for (final v in product.variants) {
        sum += v.variantPrice * v.quantity;
      }
    }
    return sum;
  }

  int get _pointsUsed => int.tryParse(pointsController.text.trim()) ?? 0;

  double get _deliveryFee => _selectedTab == 0 ? 0 : 0;

  double get _promotionDiscount => _appliedPromotion?.discountAmount ?? 0;

  num get _pointsDiscount {
    final grossAfterPromotion = (_subtotal + _deliveryFee - _promotionDiscount)
        .clamp(0, double.infinity);
    final requestedPointsValue = _pointsUsed / 3;
    if (requestedPointsValue <= 0) {
      return 0;
    }
    return requestedPointsValue > grossAfterPromotion
        ? grossAfterPromotion
        : requestedPointsValue;
  }

  double get _previewTotal {
    return (_subtotal + _deliveryFee - _promotionDiscount - _pointsDiscount)
        .clamp(0, double.infinity);
  }

  void _clearPromotion({bool clearInput = false}) {
    setState(() {
      _appliedPromotion = null;
      promoError = null;
      if (clearInput) {
        promoCodeController.clear();
      }
    });
  }

  Future<void> _applyPromotion() async {
    final code = promoCodeController.text.trim();
    if (code.isEmpty) {
      setState(() {
        promoError = 'Enter a promotion code.';
      });
      return;
    }

    setState(() {
      _isValidatingPromotion = true;
      promoError = null;
    });

    final validation = await service<ProductService>().validatePromotionCode(
      code: code,
      amount: _subtotal + _deliveryFee,
    );

    if (!mounted) {
      return;
    }

    validation.when(
      onError: (error) {
        setState(() {
          _isValidatingPromotion = false;
          _appliedPromotion = null;
          promoError = error.error;
        });
      },
      onSuccess: (result) {
        setState(() {
          _isValidatingPromotion = false;
          _appliedPromotion = result;
          promoError = null;
          promoCodeController.text = result.code;
        });
        SnackbarService.showSuccess('Promotion code applied successfully.');
      },
    );
  }

  Widget _emptySelectorState({
    required String message,
    Widget? action,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
        ),
        if (action != null) ...[
          const SizedBox(height: 8),
          action,
        ],
      ],
    );
  }

  Future<gmf.LatLng?> getCurrentLatLng() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    // Check for permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    // Get current position
    final pos = await Geolocator.getCurrentPosition();
    return gmf.LatLng(pos.latitude, pos.longitude);
  }

  Future<void> _handlePressButton() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddressFormBottomSheet(
        apiKey: kGoogleApiKey,
        onAddressSelected: (result) {
          setState(() {
            _selectedAddressDropdown = Address(
              id: result["id"] ?? "",
              name: result["name"] ?? "",
              locality: result["address"] ?? "",
              city: result["city"] ?? "",
              country: result["country"] ?? "",
              phone: result["phone"] ?? "",
              latitude: null,
              longitude: null,
              isDefault: false,
            );
          });
        },
      ),
    );
  }

  void _updateQty({
    required String productId,
    required String variantId,
    required int delta,
  }) {
    final pIndex = _items.indexWhere((p) => p.id == productId);
    if (pIndex < 0) return;

    final product = _items[pIndex];
    final vIndex = product.variants.indexWhere((v) => v.variantID == variantId);
    if (vIndex < 0) return;

    final oldVariant = product.variants[vIndex];
    final newQty = (oldVariant.quantity + delta).clamp(0, _maxQty.toInt());

    if (newQty == 0) {
      context.read<ProductBloc>().add(
            ProductEvent.removeCart(
              request: {
                "productID": product.id,
                "bundledItems": [
                  {
                    "variantID": variantId,
                    "quantity": oldVariant.quantity,
                  }
                ],
              },
            ),
          );

      final newVariants = List<CartVariant>.from(product.variants)
        ..removeAt(vIndex);

      setState(() {
        _appliedPromotion = null;
        promoError = null;
        if (newVariants.isEmpty) {
          _items.removeAt(pIndex); // remove product entirely
        } else {
          _items[pIndex] = product.copyWith(variants: newVariants);
        }
      });
    } else {
      final updatedVariant = oldVariant.copyWith(quantity: newQty);
      final newVariants = List<CartVariant>.from(product.variants);
      newVariants[vIndex] = updatedVariant;

      // check differents with original qty and send to removeCart if removed
      if (newQty != oldVariant.quantity) {
        // get difference in quantity
        final difference = oldVariant.quantity - newQty;
        // convert to absolute value
        final differenceInt = difference.abs();
        // check if difference is greater than 0
        if (difference > 0) {
          context.read<ProductBloc>().add(
                ProductEvent.removeCart(
                  request: {
                    "productID": product.id,
                    "bundledItems": [
                      {
                        "variantID": variantId,
                        "quantity": differenceInt,
                      }
                    ],
                  },
                ),
              );
        } else if (difference < 0) {
          // add to cart if difference is less than 0
          context.read<ProductBloc>().add(
                ProductEvent.addToCart(
                  request: {
                    "productID": product.id,
                    "bundledItems": [
                      {
                        "variantID": variantId,
                        "quantity": differenceInt,
                      }
                    ],
                  },
                ),
              );
        }
      }

      setState(() {
        _appliedPromotion = null;
        promoError = null;
        _items[pIndex] = product.copyWith(variants: newVariants);
      });
    }
  }

  Widget _qtyCircle(IconData icon,
      {required VoidCallback onTap, bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF7B3DD6) : Colors.transparent,
          border: Border.all(
              color: filled ? Colors.transparent : Colors.grey.shade400),
          shape: BoxShape.circle,
        ),
        child: Icon(icon,
            size: 18,
            color: filled
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  Widget _productCard(CartItem product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface)),
      child: Column(
        children: [
          // Product header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ShopProductImage(
                  imageUrl: product.productImage,
                  width: 64,
                  height: 64,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.productName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(product.category,
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Variant list (works for both single & multi variants)
          Column(
            children: product.variants.map((variant) {
              return Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${variant.variantName}: $_currency ${variant.variantPrice.toStringAsFixed(0)}',
                    ),
                    Row(
                      children: [
                        _qtyCircle(Icons.remove, onTap: () {
                          _updateQty(
                            productId: product.id,
                            variantId: variant.variantID,
                            delta: -1,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text('${variant.quantity}'),
                        const SizedBox(width: 8),
                        _qtyCircle(Icons.add, onTap: () {
                          _updateQty(
                            productId: product.id,
                            variantId: variant.variantID,
                            delta: 1,
                          );
                        }, filled: true),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final addresses = widget.addresses;
    final pickupAddresses = widget.pickupAddresses;
    Address? selectedAddress;
    for (final address in addresses) {
      if (address.id == _selectedAddressDropdown?.id) {
        selectedAddress = address;
        break;
      }
    }
    selectedAddress ??= _selectedAddressDropdown;
    final selectedPickupAddress = pickupAddresses.any(
      (address) => address.id == _selectedPickupAddressDropdown?.id,
    )
        ? _selectedPickupAddressDropdown
        : null;

    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: _initialSheetSize,
        minChildSize: _minSheetSize,
        maxChildSize: _maxSheetSize,
        builder: (context, scrollController) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 12),

                // Delivery / Pickup switch
                Container(
                  height: 44,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 0),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _selectedTab == 0
                                  ? Colors.grey[300]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Delivery',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _selectedTab == 0
                                    ? Colors.black
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 1),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _selectedTab == 1
                                  ? Colors.grey[300]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Pick-Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _selectedTab == 1
                                    ? Colors.black
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Content
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    children: [
                      Text(
                        _selectedTab == 0 ? 'Delivering to' : 'Pick-Up from',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // Map / address card
                      if (_selectedTab == 0)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[300],
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://placehold.co/150x150?font=roboto&text=Map+Preview'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (addresses.isEmpty)
                                      _emptySelectorState(
                                        message: 'No delivery addresses yet.',
                                        action: GestureDetector(
                                          onTap: _handlePressButton,
                                          child: const SizedBox(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.purple,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'New delivery address',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 56,
                                            child: DropdownSearch<Address>(
                                              items: (filter,
                                                      infiniteScrollProps) =>
                                                  addresses,
                                              itemAsString: (address) =>
                                                  address.locality,
                                              selectedItem: selectedAddress,
                                              compareFn: (a, b) => a.id == b.id,
                                              decoratorProps:
                                                  DropDownDecoratorProps(
                                                decoration: InputDecoration(
                                                  fillColor: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  labelText: "Select Address",
                                                  prefixIcon: const Icon(
                                                    Icons.location_on,
                                                    size: 18,
                                                    color: Colors.purple,
                                                  ),
                                                  suffixIcon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 28,
                                                    color: Colors.purple,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                                ),
                                              ),
                                              popupProps:
                                                  const PopupProps.menu(
                                                showSearchBox: false,
                                                menuProps: MenuProps(
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onChanged: (selectedAddress) {
                                                debugPrint(
                                                  "Selected Address ID: ${selectedAddress?.id}",
                                                );
                                                debugPrint(
                                                  "Selected Address Name: ${selectedAddress?.name}",
                                                );
                                                setState(() {
                                                  _selectedAddressDropdown =
                                                      selectedAddress;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: _handlePressButton,
                                            child: const SizedBox(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.purple,
                                                    size: 15,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'New delivery address',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                      if (_selectedTab == 1)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[300],
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://placehold.co/150x150?font=roboto&text=Map+Preview'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (pickupAddresses.isEmpty)
                                      _emptySelectorState(
                                        message:
                                            'No pickup locations available right now.',
                                      )
                                    else
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 56,
                                            child:
                                                DropdownSearch<PickupAddress>(
                                              items: (filter,
                                                      infiniteScrollProps) =>
                                                  pickupAddresses,
                                              itemAsString: (address) =>
                                                  address.locality,
                                              selectedItem:
                                                  selectedPickupAddress,
                                              compareFn: (a, b) =>
                                                  a.id == b.id,
                                              decoratorProps:
                                                  DropDownDecoratorProps(
                                                decoration: InputDecoration(
                                                  fillColor: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  labelText:
                                                      "Select Pickup Location",
                                                  prefixIcon: const Icon(
                                                    Icons.location_on,
                                                    size: 18,
                                                    color: Colors.purple,
                                                  ),
                                                  suffixIcon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 28,
                                                    color: Colors.purple,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                                ),
                                              ),
                                              popupProps:
                                                  const PopupProps.menu(
                                                showSearchBox: false,
                                                menuProps: MenuProps(
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onChanged: (selectedAddress) {
                                                debugPrint(
                                                  "Selected Address ID: ${_selectedPickupAddressDropdown?.id}",
                                                );
                                                debugPrint(
                                                  "Selected Address Name: ${selectedAddress?.name}",
                                                );
                                                setState(() {
                                                  _selectedPickupAddressDropdown =
                                                      selectedAddress;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                      const SizedBox(height: 18),

                      const Text('Description',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),

                      if (widget.isLoading) ...[
                        const Center(child: CircularProgressIndicator()),
                      ] else if (_items.isEmpty) ...[
                        const Center(child: Text('No items in cart')),
                      ] else ...[
                        for (final product in _items) _productCard(product),
                      ],

                      const SizedBox(height: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Promotion Code',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: promoCodeController,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    labelText: 'Enter code',
                                    errorText: promoError,
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (_appliedPromotion != null &&
                                        value.trim() !=
                                            _appliedPromotion!.code) {
                                      setState(() {
                                        _appliedPromotion = null;
                                      });
                                    }
                                    if (promoError != null) {
                                      setState(() {
                                        promoError = null;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(0, 52),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                  ),
                                  onPressed: _isValidatingPromotion
                                      ? null
                                      : (_appliedPromotion == null
                                          ? _applyPromotion
                                          : () => _clearPromotion(
                                                clearInput: true,
                                              )),
                                  child: Text(
                                    _isValidatingPromotion
                                        ? 'Applying...'
                                        : _appliedPromotion == null
                                            ? 'Apply'
                                            : 'Remove',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_appliedPromotion != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest
                                    .withValues(alpha: 0.35),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_appliedPromotion!.name} applied. You save $_currency ${_appliedPromotion!.discountAmount.toStringAsFixed(2)}.',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: pointsController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Redeem Points',
                                    errorText: pointsError,
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    final int entered = int.tryParse(val) ?? 0;
                                    final int balance = int.tryParse(
                                            widget.pointsState.balance) ??
                                        0;
                                    setState(() {
                                      if (entered < 0) {
                                        pointsError =
                                            'Points cannot be negative';
                                      } else if (entered > balance) {
                                        pointsError = 'Insufficient points';
                                      } else {
                                        pointsError = null;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(0, 52),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    final int balance = int.tryParse(
                                            widget.pointsState.balance) ??
                                        0;
                                    pointsController.text = balance.toString();
                                    setState(() {
                                      pointsError = null;
                                    });
                                  },
                                  child: const Text('Max'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '≈ Ksh ${(_pointsUsed / 3).toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      const Divider(),
                      _summaryRow('Subtotal',
                          '$_currency ${_subtotal.toStringAsFixed(2)}'),
                      _summaryRow(
                          'Delivery',
                          _selectedTab == 0
                              ? '$_currency ${_deliveryFee.toStringAsFixed(2)}'
                              : '$_currency 0'),
                      if (_promotionDiscount > 0)
                        _summaryRow(
                          'Promotion Discount',
                          '- $_currency ${_promotionDiscount.toStringAsFixed(2)}',
                        ),
                      if (_pointsDiscount > 0)
                        _summaryRow(
                          'Points Discount',
                          '- $_currency ${_pointsDiscount.toStringAsFixed(2)}',
                        ),
                      const Divider(),
                      _summaryRow(
                        'Total',
                        '$_currency ${_previewTotal.toStringAsFixed(2)}',
                        bold: true,
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Checkout
                if (_items.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: GradientFilledButton(
                        text: widget.isProcessingCheckout
                            ? 'Processing...'
                            : 'Checkout',
                        onPressed: () {
                          if (widget.isProcessingCheckout) {
                            return;
                          }
                          if (_selectedTab == 0 &&
                              _selectedAddressDropdown == null) {
                            SnackbarService.show(
                              'Please select a delivery address.',
                              backgroundColor: AppColors.dangerColor,
                            );
                            return;
                          }

                          if (_selectedTab == 1 &&
                              _selectedPickupAddressDropdown == null) {
                            SnackbarService.show(
                              'Please select a pickup location.',
                              backgroundColor: AppColors.dangerColor,
                            );
                            return;
                          }

                          if (pointsError != null) {
                            SnackbarService.show(
                              pointsError!,
                              backgroundColor: AppColors.dangerColor,
                            );
                            return;
                          }

                          final int usedPoints = _pointsUsed;

                          context.read<ProductBloc>().add(
                                ProductEvent.buyBulkProducts(
                                  request: {
                                    "bundledOrders": _items.expand((product) {
                                      return product.variants.map((variant) {
                                        return {
                                          "deliveryAddressId":
                                              _selectedAddressDropdown?.id,
                                          "productTypeID": variant.variantID,
                                          "productID": product.id,
                                          "amount": variant.variantPrice,
                                          "quantity": variant.quantity,
                                        };
                                      });
                                    }).toList(),
                                    "redeemablePoints": usedPoints,
                                    if (_appliedPromotion != null)
                                      "promotionCode": _appliedPromotion!.code,
                                  },
                                ),
                              );
                        }),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
