part of "../home_page.dart";

void showTicketBottomSheet(
  BuildContext context,
  ({double TotalAmount, int quantity}) values, {
  required void Function(int usedPoints) buyMerch,
  required MatchType match,
  required PointsState pointsState,
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
      );
    },
  );
}

class _TicketBottomSheetContent extends StatefulWidget {
  final void Function(int usedPoints) buyMerch;
  final MatchType match;
  final ({double TotalAmount, int quantity}) values;
  final PointsState pointsState;

  const _TicketBottomSheetContent({
    super.key,
    required this.values,
    required this.buyMerch,
    required this.match,
    required this.pointsState,
  });

  @override
  State<_TicketBottomSheetContent> createState() =>
      _TicketBottomSheetContentState();
}

class _TicketBottomSheetContentState extends State<_TicketBottomSheetContent> {
  bool usePoints = false;
  final TextEditingController _pointsController = TextEditingController();
  int usedPoints = 0;

  String? pointsError;

  @override
  void dispose() {
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final points = int.tryParse(widget.pointsState.balance ?? '0') ?? 0;
    final kshValue = usedPoints / 3;

    final displayedTotal = usePoints
        ? (widget.values.TotalAmount - kshValue).clamp(0, double.infinity)
        : widget.values.TotalAmount;

    print("${widget.pointsState.balance}");

    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.64,
        builder: (context, scrollController) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
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
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
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
                      const SizedBox(height: 20),
                      DottedContainer(
                        containerBgColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.9),
                        iconData: LucideIcons.badgePercent,
                        text: "Add Coupon",
                      ),
                      const SizedBox(height: 20),
                      TicketOrderSummary(
                        quantity: widget.values.quantity,
                        match: widget.match,
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
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
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
                                      textAlignVertical:
                                          TextAlignVertical.center,

                                      decoration: InputDecoration(
                                        labelText: "Enter points to use",
                                        hintText: "e.g. 300",
                                        border: const OutlineInputBorder(),

                                        // ✅ THIS CONTROLS HEIGHT
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical:
                                              10, // 👈 reduce this further if needed
                                        ),

                                        errorText: pointsError,
                                      ),

                                      onChanged: (value) {
                                        final entered =
                                            int.tryParse(value) ?? 0;

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
                                      _pointsController.text =
                                          points.toString();
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
                                  text: "${displayedTotal.ceil()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Color(0xffdfdfdf)),
                      // if (points < 9999)
                      const SizedBox(height: 10),
                      GradientFilledButton(
                        text: 'Checkout',
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.buyMerch(usePoints ? usedPoints : 0);
                        },
                      )
                    ],
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

class TicketOrderSummary extends StatelessWidget {
  final int quantity;
  final MatchType match;

  const TicketOrderSummary({
    super.key,
    required this.quantity,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
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
              "$quantity tickets for ${match.matchName}",
              maxLines: 1,
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
