part of "../home_page.dart";

void showTicketBottomSheet(
  BuildContext context,
  ({double TotalAmount, int quantity}) values, {
  required void Function(int usedPoints, String? promotionCode) buyMerch,
  required MatchType match,
  required PointsState pointsState,
  String? ticketLabel,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return _TicketBottomSheetContent(
        values: values,
        buyMerch: buyMerch,
        match: match,
        pointsState: pointsState,
        ticketLabel: ticketLabel,
      );
    },
  );
}

class _TicketBottomSheetContent extends StatefulWidget {
  final void Function(int usedPoints, String? promotionCode) buyMerch;
  final MatchType match;
  final ({double TotalAmount, int quantity}) values;
  final PointsState pointsState;
  final String? ticketLabel;

  const _TicketBottomSheetContent({
    super.key,
    required this.values,
    required this.buyMerch,
    required this.match,
    required this.pointsState,
    this.ticketLabel,
  });

  @override
  State<_TicketBottomSheetContent> createState() =>
      _TicketBottomSheetContentState();
}

class _TicketBottomSheetContentState extends State<_TicketBottomSheetContent> {
  bool usePoints = false;
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();
  int usedPoints = 0;
  bool _isValidatingPromotion = false;

  String? pointsError;
  String? promoError;
  FrontendPromotionValidationResult? _appliedPromotion;

  @override
  void dispose() {
    _pointsController.dispose();
    _promoCodeController.dispose();
    super.dispose();
  }

  double get _promotionDiscount {
    final discount = _appliedPromotion?.discountAmount ?? 0;
    return discount > widget.values.TotalAmount
        ? widget.values.TotalAmount
        : discount;
  }

  double get _grossAfterPromotion =>
      (widget.values.TotalAmount - _promotionDiscount)
          .clamp(0, double.infinity);

  double get _pointsDiscount {
    if (!usePoints) return 0;
    final requestedValue = usedPoints / 3;
    return requestedValue > _grossAfterPromotion
        ? _grossAfterPromotion
        : requestedValue;
  }

  double get _displayedTotal =>
      (_grossAfterPromotion - _pointsDiscount).clamp(0, double.infinity);

  Future<void> _applyPromotion() async {
    final code = _promoCodeController.text.trim();
    if (code.isEmpty) {
      setState(() {
        promoError = "Enter a promotion code.";
      });
      return;
    }

    setState(() {
      _isValidatingPromotion = true;
      promoError = null;
    });

    final response = await service<ProductService>().validatePromotionCode(
      code: code,
      amount: widget.values.TotalAmount,
    );

    if (!mounted) return;

    response.when(
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
          _promoCodeController.text = result.code;
        });
        SnackbarService.showSuccess("Promotion code applied successfully.");
      },
    );
  }

  void _clearPromotion({bool clearInput = false}) {
    setState(() {
      _appliedPromotion = null;
      promoError = null;
      if (clearInput) {
        _promoCodeController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final points = int.tryParse(widget.pointsState.balance) ?? 0;

    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.64,
        builder: (context, scrollController) {
          return SizedBox.expand(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Checkout',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                      child: AvatorInText(secondText: "Mail E-ticket")),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _promoCodeController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: "Promotion Code",
                            hintText: "Enter code",
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            errorText: promoError,
                          ),
                          onChanged: (value) {
                            final appliedCode = _appliedPromotion?.code;
                            if (appliedCode != null &&
                                value.trim() != appliedCode) {
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
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 96,
                          maxWidth: 120,
                        ),
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isValidatingPromotion
                                ? null
                                : (_appliedPromotion == null
                                    ? _applyPromotion
                                    : () => _clearPromotion(clearInput: true)),
                            child: Text(
                              _isValidatingPromotion
                                  ? "Applying..."
                                  : _appliedPromotion == null
                                      ? "Apply"
                                      : "Remove",
                            ),
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
                        '${_appliedPromotion?.name ?? "Promotion"} applied. You save Ksh ${_promotionDiscount.toStringAsFixed(2)}.',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  TicketOrderSummary(
                    quantity: widget.values.quantity,
                    match: widget.match,
                    ticketLabel: widget.ticketLabel,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ✅ Consent Toggle
                      Row(
                        children: [
                          Switch(
                            value: usePoints,
                            onChanged: points > 0
                                ? (val) {
                                    setState(() {
                                      usePoints = val;
                                      if (!val) {
                                        _pointsController.clear();
                                        usedPoints = 0;
                                        pointsError = null;
                                      }
                                    });
                                  }
                                : null,
                            activeColor: Theme.of(context).colorScheme.primary,
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: "Use Points "),
                                  TextSpan(
                                    text: "(Available: $points)",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// ✅ Points Input Section
                      if (usePoints) ...[
                        const SizedBox(height: 8),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: TextFormField(
                                  controller: _pointsController,
                                  keyboardType: TextInputType.number,

                                  // ✅ REDUCED HEIGHT SETTINGS
                                  style: const TextStyle(fontSize: 14),
                                  textAlignVertical: TextAlignVertical.center,

                                  decoration: InputDecoration(
                                    labelText: "Enter points to use",
                                    hintText: "e.g. 300",
                                    border: const OutlineInputBorder(),

                                    // ✅ THIS CONTROLS HEIGHT
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical:
                                          10, // 👈 reduce this further if needed
                                    ),

                                    errorText: pointsError,
                                  ),

                                  onChanged: (value) {
                                    final entered = int.tryParse(value) ?? 0;

                                    setState(() {
                                      if (entered <= 0) {
                                        usedPoints = 0;
                                        pointsError =
                                            "Enter points greater than 0";
                                      } else if (entered > points) {
                                        usedPoints = 0;
                                        pointsError =
                                            "You only have $points points available";
                                      } else {
                                        usedPoints = entered;
                                        pointsError = null;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            /// ✅ Auto-fill MAX button
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  usedPoints = points;
                                  _pointsController.text = points.toString();
                                  pointsError = null;
                                });
                              },
                              child: const Text("MAX"),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        /// ✅ Exact Conversion Hint
                        Text(
                          usedPoints > 0
                              ? "$usedPoints points = Ksh ${(usedPoints / 3).toStringAsFixed(2)}"
                              : "3 Points = Ksh 1",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Total Amount",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          children: [
                            const TextSpan(
                              text: "(Ksh) ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: _displayedTotal.toStringAsFixed(2),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (_promotionDiscount > 0) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          "Promotion Discount",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          "- Ksh ${_promotionDiscount.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                  if (_pointsDiscount > 0) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          "Points Discount",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          "- Ksh ${_pointsDiscount.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Divider(color: Color(0xffdfdfdf)),
                  // if (points < 9999)
                  const SizedBox(height: 10),
                  GradientFilledButton(
                    text: 'Checkout',
                    onPressed: () {
                      final currentPointsError = pointsError;
                      if (currentPointsError != null) {
                        SnackbarService.showError(currentPointsError);
                        return;
                      }
                      Navigator.of(context).pop();
                      widget.buyMerch(
                        usePoints ? usedPoints : 0,
                        _appliedPromotion?.code,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TicketOrderSummary extends StatelessWidget {
  final int quantity;
  final MatchType match;
  final String? ticketLabel;

  const TicketOrderSummary({
    super.key,
    required this.quantity,
    required this.match,
    this.ticketLabel,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedTicketLabel = ticketLabel?.trim();
    final hasTicketLabel =
        normalizedTicketLabel != null && normalizedTicketLabel.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 60,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              !hasTicketLabel
                  ? "$quantity tickets for ${match.matchName}"
                  : "$quantity x $normalizedTicketLabel for ${match.matchName}",
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 12, overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ],
    );
  }
}

class TicketTotalAmount extends StatelessWidget {
  final double totalAmount;
  const TicketTotalAmount({super.key, this.totalAmount = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Total Amount",
            style: TextStyle(fontWeight: FontWeight.w500)),
        const Spacer(),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: [
              const TextSpan(
                text: "(Ksh) ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: "${totalAmount.ceil()}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
