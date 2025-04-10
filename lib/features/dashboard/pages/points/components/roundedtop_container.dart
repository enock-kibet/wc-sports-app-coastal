part of '../points_page.dart';

class RoundedtopContainer extends StatelessWidget {
  final Widget child;
  const RoundedtopContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSMedium),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
         )
      ),
      child:child,
    );
  }
}
