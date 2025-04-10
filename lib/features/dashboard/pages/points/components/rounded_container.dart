part of '../points_page.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
  final double radius;
  final bool showBorder;
  final bool isCircle;
  final Color backgroundColor;
  const RoundedContainer({
    super.key,
    required this.child,
    this.margin= EdgeInsets.zero,
    this.width=double.infinity,
    this.height=double.infinity,
    this.radius=36,
    this.padding= const EdgeInsets.symmetric(horizontal: 12),
    this.showBorder=false,
    this.isCircle= false,
    this.backgroundColor= Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          shape: isCircle?BoxShape.circle:BoxShape.rectangle,
          color: backgroundColor,
          border: showBorder? Border.all(width:0.5,color: Color(0xffb5b5b5)):null,
          borderRadius: isCircle?null:BorderRadius.all(Radius.circular(radius))
      ),
      child:child,
    );
  }
}
