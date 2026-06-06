part of '../home_page.dart';

class TotalAndQuantity extends StatelessWidget {
  final double amount;
  final int quantity;
  final VoidCallback add;
  final VoidCallback subtract;

  const TotalAndQuantity(
      {super.key,
      this.quantity = 0,
      required this.add,
      required this.subtract,
      this.amount = 100});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Ksh $amount",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Spacer(),
            CustomIconButton(onButtonPress: subtract, icon: Icons.remove),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
                width: 16,
                child: Center(
                    child: Text(
                  '$quantity',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ))),
            const SizedBox(
              width: 12,
            ),
            CustomIconButton(
              icon: Icons.add,
              onButtonPress: add,
              backgroundColor: AppColors.defaultAppPurple,
              iconColor: AppColors.darkColor,
              borderColor: AppColors.defaultAppPurple,
            )
          ],
        ),
      ],
    );
    ;
  }
}
