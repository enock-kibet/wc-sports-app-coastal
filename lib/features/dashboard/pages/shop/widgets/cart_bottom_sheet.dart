part of "../shop_page.dart";

void showCartShopBottomSheet(BuildContext context,
    {required PointsState pointsState}) {
  final pointsState = context.read<PointsBloc>().state;
  context.read<CartBloc>().add(
        CartEvent.getCartItems(
          request: {
            "email": service<AppPreferencesManager>().currentUserValue!.email,
          },
        ),
      );

  // Fetch addresses from AddressBloc
  context.read<AddressBloc>().add(
        AddressEvent.getAddresses(request: {
          "email": service<AppPreferencesManager>().currentUserValue!.email,
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
    builder: (context) {
      return BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.status == ProductStatus.processingPayment) {
            SnackbarService.show(
              'Securing Payment',
              backgroundColor: AppColors.blackColor,
            );
            //AnimatedOverlaySnackbar.show(context, "Loading",color:const Color(0xff1976D2));
          } else if (state.status == ProductStatus.successfulPayment) {
            context.goNamed(
              AppRoute.paymentWebView.name,
              extra: state.authorizationUrl,
            );
            //AnimatedOverlaySnackbar.show(context, "Success: ${state.authorizationUrl??"didn't get"}",color:const Color(0xff2E7D32));
          } else if (state.status == ProductStatus.failure) {
            AnimatedOverlaySnackbar.show(
                context, "failed: ${state.failure?.error ?? "failed"}",
                color: AppColors.defaultAppRed);
          } else if (state.status == ProductStatus.success) {
            AnimatedOverlaySnackbar.show(context, "Added to cart successfully",
                color: AppColors.blackColor);
          }
        },
        builder: (context, state) {
          final cartItems = state.cartItems ?? [];
          final isLoading = state.status == CartStatus.loading;

          // get addresses from state

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<AddressBloc, AddressState>(
            builder: (context, addressState) {
              final addresses = addressState.data ?? [];
              return _ShopCartBottomSheetContent(
                isLoading: isLoading,
                cartItems: cartItems,
                addresses: addresses,
                pointsState: pointsState,
              );
            },
          );
        },
      );
    },
  );
}

const kGoogleApiKey =
    "AIzaSyCvhSnZ3edg_8TARHCU4cY4JjyrzcG5Eho#"; // Replace with your actual Google API key

class _ShopCartBottomSheetContent extends StatefulWidget {
  final bool isLoading;
  final List<CartItem> cartItems;
  final List<Address> addresses;
  final Map<String, double>? priceByProduct;
  final PointsState pointsState;

  const _ShopCartBottomSheetContent({
    super.key,
    required this.isLoading,
    required this.cartItems,
    required this.addresses,
    required this.pointsState,
    this.priceByProduct,
  });

  @override
  State<_ShopCartBottomSheetContent> createState() =>
      _ShopCartBottomSheetContentState();
}

class _ShopCartBottomSheetContentState
    extends State<_ShopCartBottomSheetContent> {
  late List<CartItem> _items;
  late List<Address> _addresses;
  late ValueNotifier<bool> usePointsController;
  late TextEditingController pointsController;
  String? pointsError;

  int _selectedTab = 0; // 0 = Delivery, 1 = Pick-Up

  Address? _selectedAddressDropdown;

  PickupAddress? _selectedPickupAddressDropdown;

  String? _selected;

  LatLng? _selectedAddressLatLng;

  String? _selectedAddress;
  String? _previewImageUrl;

  // Constants
  static const double _defaultPrice = 720.0;
  static const double _maxQty = 999;
  static const double _initialSheetSize = 0.82;
  static const double _minSheetSize = 0.45;
  static const double _maxSheetSize = 0.95;
  static const String _currency = "Ksh";

  @override
  void initState() {
    super.initState();
    _items = List<CartItem>.from(widget.cartItems);
    _addresses = List<Address>.from(widget.addresses);
    pointsController = TextEditingController();
  }

  @override
  void dispose() {
    pointsController.dispose();
    super.dispose();
  }

  double _priceForItem(CartItem item) {
    return widget.priceByProduct?[item.id] ?? _defaultPrice;
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
    // final result = await showModalBottomSheet<Map<String, dynamic>>(
    //   context: context,
    //   isScrollControlled: true,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    //   ),
    //   builder: (context) => MapLocationPickerBottomSheet(
    //     apiKey: kGoogleApiKey,
    //   ),
    // );
    // if (result != null && result["latLng"] != null) {
    //   final LatLng latLng = result["latLng"];
    //   final String? address = result["address"];
    //   setState(() {
    //     _selectedAddress = address ?? "${latLng.lat},${latLng.lng}";
    //     _selectedAddressLatLng = latLng;
    //     _previewImageUrl =
    //     "https://maps.googleapis.com/maps/api/staticmap"
    //         "?center=${latLng.lat},${latLng.lng}"
    //         "&zoom=16"
    //         "&size=150x150"
    //         "&markers=color:purple%7C${latLng.lat},${latLng.lng}"
    //         "&key=$kGoogleApiKey";
    //   });
    // }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddressFormBottomSheet(
        apiKey: kGoogleApiKey,
        onAddressSelected: (result) {
          setState(() {
            _selectedAddress = result["address"];
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
            print("Selected20 Address: $_selectedAddress");
            // You can also store name/phone if needed
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
      // Remove variant if qty hits 0
      final newVariants = List<CartVariant>.from(product.variants)
        ..removeAt(vIndex);

      setState(() {
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
        print(difference);
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
                child: product.productImage.isNotEmpty
                    ? Image.network(
                        product.productImage,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          width: 64,
                          height: 64,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      )
                    : Container(
                        width: 64,
                        height: 64,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
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
    final double deliveryFee = _selectedTab == 0 ? 0 : 0;
    final points = int.tryParse(widget.pointsState.balance) ?? 0;
    final kshValue = points / 3;

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
                          child: Container(
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
                                BlocBuilder<AddressBloc, AddressState>(
                                  builder: (context, state) {
                                    final addresses = state.data ?? [];
                                    return Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 35,
                                            child: DropdownSearch<Address>(
                                              items: (filter,
                                                      infiniteScrollProps) =>
                                                  addresses,
                                              itemAsString: (address) =>
                                                  address.locality,
                                              selectedItem:
                                                  _selectedAddressDropdown ??
                                                      null,
                                              compareFn: (a, b) =>
                                                  a?.id == b?.id,
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
                                                      color: Colors.purple),
                                                  suffixIcon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 28,
                                                      color: Colors.purple),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                ),
                                              ),
                                              popupProps: const PopupProps.menu(
                                                showSearchBox: false,
                                                menuProps: MenuProps(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                  ),
                                                ),
                                              ),
                                              onChanged: (selectedAddress) {
                                                debugPrint(
                                                    "Selected Address ID: ${selectedAddress?.id}");
                                                debugPrint(
                                                    "Selected Address Name: ${selectedAddress?.name}");
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
                                                  Icon(Icons.add,
                                                      color: Colors.purple,
                                                      size: 15),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'New delivery address',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),

                      if (_selectedTab == 1)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
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
                                BlocBuilder<AddressBloc, AddressState>(
                                  builder: (context, state) {
                                    final pickupAddresses =
                                        state.pickupAddresses ?? [];
                                    return Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 35,
                                            child:
                                                DropdownSearch<PickupAddress>(
                                              items: (filter,
                                                      infiniteScrollProps) =>
                                                  pickupAddresses,
                                              itemAsString: (address) =>
                                                  address.locality,
                                              selectedItem:
                                                  _selectedPickupAddressDropdown,
                                              compareFn: (a, b) => a.id == b.id,
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
                                                      color: Colors.purple),
                                                  suffixIcon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 28,
                                                      color: Colors.purple),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                ),
                                              ),
                                              popupProps: const PopupProps.menu(
                                                showSearchBox: false,
                                                menuProps: MenuProps(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                  ),
                                                ),
                                              ),
                                              onChanged: (selectedAddress) {
                                                debugPrint(
                                                    "Selected Address ID: ${_selectedPickupAddressDropdown?.id}");
                                                debugPrint(
                                                    "Selected Address Name: ${selectedAddress?.name}");
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
                                    );
                                  },
                                )
                              ],
                            ),
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
                                    horizontal: 12, vertical: 8),
                              ),
                              onChanged: (val) {
                                final int entered = int.tryParse(val) ?? 0;
                                final int balance = int.tryParse(
                                        widget.pointsState.balance ?? '0') ??
                                    0;
                                setState(() {
                                  pointsError = entered > balance
                                      ? 'Insufficient points'
                                      : null;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              final int balance = int.tryParse(
                                      widget.pointsState.balance ?? '0') ??
                                  0;
                              pointsController.text = balance.toString();
                              setState(() {
                                pointsError = null;
                              });
                            },
                            child: const Text('Max'),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '≈ Ksh ${((int.tryParse(pointsController.text) ?? 0) / 3).toStringAsFixed(2)}',
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
                              ? '$_currency ${deliveryFee.toStringAsFixed(2)}'
                              : '$_currency 0'),
                      const Divider(),
                      ValueListenableBuilder(
                        valueListenable: pointsController,
                        builder: (context, usePoints, _) {
                          int pointsUsed =
                              int.tryParse(pointsController.text) ?? 0;
                          final totalWithPoints =
                              _subtotal + deliveryFee - pointsUsed / 3;

                          return _summaryRow('Total',
                              '$_currency ${totalWithPoints.toStringAsFixed(2)}',
                              bold: true);
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Checkout
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: GradientFilledButton(
                      text: 'Checkout',
                      onPressed: () {
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

                        context.pop();

                        final int usedPoints =
                            int.tryParse(pointsController.text) ?? 0;

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
