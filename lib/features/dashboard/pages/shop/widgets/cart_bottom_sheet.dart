part of "../shop_page.dart";

void showCartShopBottomSheet(BuildContext context) {
  context.read<CartBloc>().add(
    CartEvent.getCartItems(
      request: {
        "email": service<AppPreferencesManager>().currentUserValue!.email,
      },
    ),
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
            rootScaffoldMessengerKey.currentState!.showSnackBar(
              SnackBar(
                backgroundColor: AppColors.blackColor,
                content: Text(
                  "Securing Payment",
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
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

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return _ShopCartBottomSheetContent(
            isLoading: isLoading,
            cartItems: cartItems,
          );
        },
      );
    },
  );
}

class _ShopCartBottomSheetContent extends StatefulWidget {
  final bool isLoading;
  final List<CartItem> cartItems;
  final Map<String, double>? priceByProduct;

  const _ShopCartBottomSheetContent({
    super.key,
    required this.isLoading,
    required this.cartItems,
    this.priceByProduct,
  });

  @override
  State<_ShopCartBottomSheetContent> createState() =>
      _ShopCartBottomSheetContentState();
}

class _ShopCartBottomSheetContentState
    extends State<_ShopCartBottomSheetContent> {
  late List<CartItem> _items;
  int _selectedTab = 0; // 0 = Delivery, 1 = Pick-Up

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

      setState(() {
        _items[pIndex] = product.copyWith(variants: newVariants);
      });
    }

    // Persist change to backend if needed
    // context.read<CartBloc>().add(CartEvent.updateVariantQuantity(...));
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
        child:
        Icon(icon, size: 18, color: filled ? Colors.white : Colors.black54),
      ),
    );
  }

  Widget _productCard(CartItem product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
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
                        style: TextStyle(
                            color: Colors.grey[600], fontSize: 13)),
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
                  color: Colors.white,
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xffc4c4c4),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 12),

                // Delivery / Pickup switch
                Container(
                  height: 44,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
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
                                  ? Colors.white
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
                                  ? Colors.white
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
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
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
                                  const Text('Wazito Village',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 6),
                                  Text('Kathonzweni Area, Kitui',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600])),
                                ],
                              ),
                            ),
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
                      const Divider(),
                      _summaryRow(
                          'Subtotal', '$_currency ${_subtotal.toStringAsFixed(0)}'),
                      _summaryRow(
                          'Delivery',
                          _selectedTab == 0
                              ? '$_currency ${deliveryFee.toStringAsFixed(0)}'
                              : '$_currency 0'),
                      const Divider(),
                      _summaryRow(
                          'Total',
                          '$_currency ${(_subtotal + deliveryFee).toStringAsFixed(0)}',
                          bold: true),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Checkout
                SizedBox(
                  width: double.infinity,
                  child: GradientFilledButton(
                    text: 'Checkout',
                      onPressed: () {
                        context.pop();

                        // Build array from cart items
                        final requestData = _items.expand((product) {
                          return product.variants.map((variant) {
                            return {
                              "productTypeID": variant.variantID, // or product.typeID if that's what you store
                              "productID": product.id,
                              "amount": variant.variantPrice,
                              "quantity": variant.quantity,
                            };
                          });
                        }).toList();

                        final wrappedRequest = {
                          "bundledOrders": requestData,
                        };

                        context.read<ProductBloc>().add(
                          ProductEvent.buyBulkProducts(
                            request: wrappedRequest,
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
