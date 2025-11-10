part of '../shop_page.dart';

class AvatorInText extends StatelessWidget {
  final String firstText;
  final double fontsize;
  final String secondText;
  final double radius;
  const AvatorInText(
      {this.fontsize = 12,
      this.radius = 3,
      this.firstText = "Delivery",
      this.secondText = "2-3 Business Days",
      super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontsize,
            color: Theme.of(context).colorScheme.onSurface),
        children: [
          TextSpan(text: "$firstText  "),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                radius: radius,
                backgroundColor: Color(0xff0baada),
              ),
            ),
          ),
          TextSpan(text: "  $secondText"),
        ],
      ),
    );
  }
}
