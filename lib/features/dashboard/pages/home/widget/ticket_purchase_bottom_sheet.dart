part of "../home_page.dart";

void showTicketBottomSheet(BuildContext context,({double TotalAmount,int quantity})values,{required VoidCallback buyMerch, required MatchType match}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full-screen height if needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return _TicketBottomSheetContent(values: values,buyMerch: buyMerch, match: match,);
    },
  );
}
class _TicketBottomSheetContent extends StatelessWidget {
  final VoidCallback buyMerch;
  final MatchType match;
  final ({double TotalAmount,int quantity,})values;
  _TicketBottomSheetContent({  required this.values, required this.buyMerch, required this.match});
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
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Drag Handle
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xffc4c4c4),
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
                      Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Center(child: AvatorInText(secondText: "Mail E-ticket",)),
                      SizedBox(height: 20,),
                      DottedContainer(iconData: LucideIcons.badgePercent, text: "Add Coupon"),
                      SizedBox(height: 20,),
                      TicketOrderSummary(quantity: values.quantity,match: match,),
                      SizedBox(height: 10,),
                      TicketTotalAmount(totalAmount: values.TotalAmount,),
                      SizedBox(height: 8,),
                      Divider(color: Color(0xffdfdfdf),),
                      SizedBox(height: 32,),


                      GradientFilledButton( text: 'Buy ticket', onPressed:(){
                        context.pop();
                        buyMerch();
                      },)
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

  const TicketOrderSummary({super.key, required this.quantity, required this.match, });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Order Summary",style: TextStyle(
            fontWeight: FontWeight.w500,color: Color(0xff292323),fontSize: 14
        ),),
        Container(
          constraints: BoxConstraints(maxHeight: 100),
          height: 60,
          width: double.infinity,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text( "$quantity tickets for ${match.matchName}",
              maxLines:1 ,
              style:TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis),))),
      ],
    );
  }
}

class TicketTotalAmount extends StatelessWidget {
  final double totalAmount;
  const TicketTotalAmount({super.key, this.totalAmount=0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Total Amount",style:TextStyle(fontWeight: FontWeight.w500),),
        Spacer(),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Color(0xff585c60)), // Default style
            children: [
              const TextSpan(
                text: "(Ksh) ",
                style: TextStyle(fontWeight: FontWeight.w500), // Medium weight
              ),
              TextSpan(
                text: "${totalAmount.ceil()}",
                style: const TextStyle(fontWeight: FontWeight.bold), // Bold weight
              ),
            ],
          ),
        )

      ],
    );
  }
}