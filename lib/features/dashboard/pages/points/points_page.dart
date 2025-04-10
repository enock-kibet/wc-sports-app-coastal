import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/points_history_card_data/point_history_card_data.dart';
import 'package:sports_app/features/dashboard/pages/pages.dart';
import 'package:sports_app/theme/app_colors.dart';

part 'components/roundedtop_container.dart';
part 'components/totalpoints_card.dart';
part 'components/rounded_container.dart';
part 'components/points_tab.dart';
part 'components/points_tab_view.dart';
part 'components/top_navigation.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> with TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        childWidget: Stack(
          children: [
            SafeArea(
              child: RoundedtopContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 24,),
                    //Top navigation
                    TopNavigation(back: (){context.pop();},title: "Points",),

                    const SizedBox(height: 24,),
                    //Total points card
                    const TotalpointsCard(totalpoints:3450),

                    const SizedBox(height: 16,),
                    //Tab
                    PointsTabBar(tabController: tabController,),

                    const SizedBox(height: 12,),
                    //TabView
                    Expanded(child: CustomTabBarView(
                        tabController:tabController, pointsHistoryList: data,))

                  ],
                ),
              ),
            ),
            // SafeArea(child: TopNavigation(back: (){context.pop();},title: "Points",)),


          ],

        ),
      ),
    );
  }
}

//list of point history data.
List<PointHistoryCardData> data =[
  PointHistoryCardData(type: PointCardType.ticket, date: DateTime(2025,5,4),tickets: 2,amount: 1400,points: 4),
  PointHistoryCardData(type: PointCardType.ticket, date: DateTime(2025,5,2),tickets: 1,amount: 500,points: 2),
  PointHistoryCardData(type: PointCardType.share, date: DateTime(2025,2,21),points: 2),
  PointHistoryCardData(type: PointCardType.redeem, date: DateTime(2025,2,21),points: -250,prize: "DB Blue Jersey"),
  PointHistoryCardData(type: PointCardType.ticket, date: DateTime(2025,2,20),tickets: 4,amount: 3500,points: 8),
  PointHistoryCardData(type: PointCardType.ticket, date: DateTime(2025,5,17),tickets: 1,amount: 500,points: 2),
  PointHistoryCardData(type: PointCardType.ticket, date: DateTime(2025,5,16),tickets: 1,amount: 500,points: 2),
  PointHistoryCardData(type: PointCardType.followed, date: DateTime(2025,2,1),points: 2),
];