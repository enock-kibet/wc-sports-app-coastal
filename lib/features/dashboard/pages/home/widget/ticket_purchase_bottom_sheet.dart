part of "../home_page.dart";

void showTicketBottomSheet(
  BuildContext context,
  ({double TotalAmount, int quantity}) values, {
  required void Function(bool usePoints) buyMerch,
  required MatchType match,
  required PointsState pointsState,
}) {
  final pointsState = context.read<PointsBloc>().state;

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
  final void Function(bool usePoints) buyMerch;
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

  @override
  Widget build(BuildContext context) {
    final points = int.tryParse(widget.pointsState.balance ?? '0') ?? 0;
    final kshValue = points / 3;

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
                      Row(
                        children: [
                          Checkbox(
                            value: usePoints,
                            onChanged: points > 0
                                ? (val) =>
                                    setState(() => usePoints = val ?? false)
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            activeColor: Theme.of(context).colorScheme.primary,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 14,
                                ),
                                children: [
                                  const TextSpan(text: "Use "),
                                  TextSpan(
                                    text: "$points ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(text: "Points "),
                                  TextSpan(
                                    text:
                                        "(Ksh ${kshValue.toStringAsFixed(0)})",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GradientFilledButton(
                        text: 'Checkout',
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.buyMerch(usePoints);
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
