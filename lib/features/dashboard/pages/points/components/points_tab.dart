part of '../points_page.dart';

class PointsTabBar extends StatelessWidget {

  final tabController;
  const PointsTabBar({super.key, this.tabController});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
          tabAlignment: TabAlignment.start,
          indicatorPadding: EdgeInsets.only(bottom: 0),
          isScrollable: true,
          labelPadding: EdgeInsets.only(right: 48,left: 0),
          dividerColor: AppColors.greyColor,
          unselectedLabelStyle: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w400,fontSize: 12,color: AppColors.greyColor,letterSpacing: 1),
          indicator: UnderlineTabIndicator(
              insets: EdgeInsets.symmetric(horizontal: -8),
              borderSide: BorderSide(width: 4,color: AppColors.blackColor),
              borderRadius: const BorderRadius.only(
                  topLeft:Radius.circular(3),
                  topRight: Radius.circular(3)
              )
          ),
          labelStyle: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w700,fontSize: 12,color: AppColors.darkColor,letterSpacing: 1),

          controller: tabController,
          tabs: [
            Tab(text: 'HISTORY',height: 36,),
            Tab(text: 'ABOUT POINTS',height: 36,),

          ]),
    );
  }
}
