part of '../shop_page.dart';


class PriceCard extends StatelessWidget {
  final Product product;
  final Map<String, int> variantCounts;
  final void Function(String size, int newCount) updateCount;

  const PriceCard({
    super.key,
    required this.product,
    required this.variantCounts,
    required this.updateCount,
  });

  @override
  Widget build(BuildContext context) {
    // If no variants, show nothing
    if (product.variants!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: product.variants!.map((variant) {
        final count = variantCounts[variant.productTypeName] ?? 0;
        return SizeGuideRow(
          size: "`${variant.productTypeName}`",
          product: product,
          add: () => updateCount(
            "`${variant.productTypeName}`",
            count < 99 ? count + 1 : count,
          ),
          subtract: () => updateCount(
            "`${variant.productTypeName}`",
            count > 0 ? count - 1 : count,
          ),
          value: count.toString(),
        );
      }).toList(),
    );
  }
}




class SizeGuideRow extends StatelessWidget {
  final Product product;
  final String size;
  final String value;
  final VoidCallback add;
  final VoidCallback subtract;

  const SizeGuideRow({required this.size,required this.product,super.key, required this.add, required this.subtract, required this.value});

  @override
  Widget build(BuildContext context) {
    // Find variant matching this size
    final variant = product.variants?.firstWhere(
          (v) => v.productTypeName == size,
      orElse: () => Variant(
        variantId: '',
        productTypeName: size,
        productid: product.id,
        typePrice: 0.0,
        units: 0,
      ),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                size,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff292323),
                ),
              ),
              const Spacer(),
              const Text(
                '(Ksh) ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff292323),
                ),
              ),
              Text(
                "${variant?.typePrice}", // <-- now using variant price
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff292323),
                ),
              ),
              const SizedBox(width: 16),
              CustomIconButton(onButtonPress: subtract, icon: Icons.remove),
              const SizedBox(width: 12),
              SizedBox(
                width: 16,
                child: Center(
                  child: Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              CustomIconButton(
                icon: Icons.add,
                onButtonPress: add,
                backgroundColor: AppColors.defaultAppPurple,
                iconColor: AppColors.whiteColor,
                borderColor: AppColors.defaultAppPurple,
              ),
            ],
          ),
        ),
        Divider(color: AppColors.greyColor),
      ],
    );
  }
}






class CustomIconButton extends StatelessWidget {
  final VoidCallback onButtonPress;
  final Color borderColor;
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final bool isRoundedRectBorder;
  const CustomIconButton(
      {
        this.isRoundedRectBorder=false,
        this.borderColor=Colors.black26,
        this.iconColor=Colors.black54,
        this.size=32,
        this.backgroundColor=Colors.transparent,
        required this.onButtonPress ,
        super.key,
        required this.icon
      });

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(

      onPressed: onButtonPress,
      splashColor: Colors.white,
      icon: Icon(icon,color: iconColor,size: size/2,weight: 3,),
      style: ButtonStyle(

        fixedSize: WidgetStateProperty.all(Size(size * 2, size)), // Ensure it's not forced into a square
        minimumSize: WidgetStateProperty.all(Size(size, size)), // Ensure it does not shrink
        maximumSize: WidgetStateProperty.all(Size(size, size)),
        padding: WidgetStateProperty.all(EdgeInsets.zero), // Remove padding
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: WidgetStatePropertyAll(
          isRoundedRectBorder
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
              : const CircleBorder(),
        ),
        side: WidgetStateProperty.all(
          BorderSide(
            color: borderColor, // Outline color
            width: 1.5,         // Outline width
          ),
        ),
        overlayColor: WidgetStateProperty.resolveWith(
              (states) {
            if (states.contains(WidgetState.pressed)) {
              return iconColor.withOpacity(0.3); // Custom overlay color on press
            }
            return null;
          },
        ),
        splashFactory: InkSparkle.splashFactory,
      ),


    );
  }
}
class GradientFilledButton extends StatelessWidget {
  final String text;
  final double radius;
  final VoidCallback onPressed;

  const GradientFilledButton({
    super.key,
    this.radius=8,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          colors: [AppColors.defaultAppRed, AppColors.defaultAppPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(        borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.transparent, // Needed for gradient to be visible
          minimumSize: const Size(double.infinity, 60),
          overlayColor: Colors.white.withOpacity(1),
          splashFactory: InkSparkle.splashFactory,
          shadowColor: Colors.transparent, // Removes unwanted shadow
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final double radius;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    super.key,
    this.radius=8,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // gradient:  LinearGradient(
        //   colors: [AppColors.defaultAppRed, AppColors.defaultAppPurple],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(        borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: Colors.transparent, // Needed for gradient to be visible
          minimumSize: const Size(double.infinity, 60),
          overlayColor: AppColors.defaultAppPurple.withOpacity(1),
          splashFactory: InkSparkle.splashFactory,
          shadowColor: Colors.transparent, // Removes unwanted shadow
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16,color: Colors.black)),
      ),
    );
  }
}