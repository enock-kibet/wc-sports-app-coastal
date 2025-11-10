part of "../shop_page.dart";

void showShopBottomSheet(
  BuildContext context,
  (double, Map<String, int>) values,
  Product product, {
  required VoidCallback buyMerch,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return _ShopBottomSheetContent(
        values: values,
        product: product,
        buyMerch: buyMerch,
      );
    },
  );
}

class _ShopBottomSheetContent extends StatelessWidget {
  final Product product;
  final VoidCallback buyMerch;
  final (double, Map<String, int>) values;
  _ShopBottomSheetContent(
      {required this.product, required this.values, required this.buyMerch});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6, // 40% height initially
        minChildSize: 0.4, // Minimum size
        maxChildSize: 0.64, // Almost full screen
        builder: (context, scrollController) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Drag Handle
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 20),
                // Sheet Content
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      //CheckOut text
                      const Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Center(child: AvatorInText()),
                      const SizedBox(
                        height: 20,
                      ),
                      const DottedContainer(
                          iconData: LucideIcons.badgePercent,
                          text: "Add Coupon"),
                      const SizedBox(
                        height: 20,
                      ),
                      OrderSummary(
                        values: values,
                        product: product,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TotalAmount(
                        totalAmount: values.$1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: Color(0xffdfdfdf),
                      ),
                      const SizedBox(
                        height: 32,
                      ),

                      GradientFilledButton(
                        text: 'Buy Merch',
                        onPressed: () {
                          context.pop();
                          buyMerch();
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

class DottedContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? containerBgColor;
  final IconData iconData;
  final String text;

  const DottedContainer({
    super.key,
    this.height,
    this.width,
    this.containerBgColor,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: [6, 6],
        padding: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.onSurface,
        strokeWidth: 1.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: height ?? 72,
            width: width ?? double.infinity,
            color: containerBgColor ?? Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData, size: 32, color: const Color(0xffc4c4c4)),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffb9b7b7)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final (double, Map<String, int>) values;
  final Product product;
  const OrderSummary({super.key, required this.values, required this.product});

  @override
  Widget build(BuildContext context) {
    List<String> items = itemsPurchased(values, product);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14),
        ),
        const Spacer(),
        Container(
          constraints: const BoxConstraints(maxHeight: 100),
          //height: 60,
          width: 200,
          child: ListView(
            shrinkWrap: true,
            children: items
                .map((item) => Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      item,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 12, overflow: TextOverflow.ellipsis),
                    )))
                .toList(),
          ),
        )
      ],
    );
  }
}

class TotalAmount extends StatelessWidget {
  final double totalAmount;
  const TotalAmount({super.key, this.totalAmount = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Total Amount",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: 16,
                color:
                    Theme.of(context).colorScheme.onSurface), // Default style
            children: [
              const TextSpan(
                text: "(Ksh) ",
                style: TextStyle(fontWeight: FontWeight.w500), // Medium weight
              ),
              TextSpan(
                text: "${totalAmount.ceil()}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold), // Bold weight
              ),
            ],
          ),
        )
      ],
    );
  }
}
// List<String> itemsPurchased((double,int,int,int)values,Product product){
//   return[
//     if(values.$2>0)"${values.$2} (Sm) ${product.name}",
//     if(values.$3>0)"${values.$3} (Md) ${product.name}",
//     if(values.$4>0)"${values.$4} (Lg) ${product.name}"
//
//   ];
// }

List<String> itemsPurchased(
    (double, Map<String, int>) values, Product product) {
  final (_, sizeCounts) = values;

  return sizeCounts.entries
      .where((entry) => entry.value > 0) // Only include purchased sizes
      .map((entry) => "${entry.value} (${entry.key}) ${product.name}")
      .toList();
}
