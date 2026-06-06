import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/utils/pull_to_refresh.dart';
import 'package:sports_app/data/models/points/points.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/dashboard/pages/pages.dart';
import 'package:sports_app/features/dashboard/pages/points/components/totalpoints_card.dart';
import 'package:sports_app/features/dashboard/pages/points/widgets/redeem_bottom_sheet.dart';
import 'package:sports_app/theme/app_colors.dart';

part 'components/roundedtop_container.dart';
part 'components/rounded_container.dart';
part 'components/points_tab.dart';
part 'components/points_tab_view.dart';
part 'components/top_navigation.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> with TickerProviderStateMixin {
  late TabController tabController;
  late PointsBloc _pointsBloc;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _pointsBloc = context.read<PointsBloc>();
    _pointsBloc.add(const PointsEvent.points()); // Trigger data fetch
  }

  Future<void> _refreshPoints() {
    return refreshBlocState<PointsState>(
      bloc: _pointsBloc,
      dispatch: () => _pointsBloc.add(const PointsEvent.points()),
      isLoading: (state) => state.status.isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        childWidget: SafeArea(
          child: RoundedtopContainer(
            child: Column(
              children: [
                const SizedBox(height: 24),
                TopNavigation(
                  back: () => context.pop(),
                  title: "Points",
                ),
                const SizedBox(height: 24),

                // BlocBuilder listens to PointsBloc updates
                Expanded(
                  child: BlocBuilder<PointsBloc, PointsState>(
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state.status.isFailure) {
                        return RefreshIndicator.adaptive(
                          onRefresh: _refreshPoints,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              SizedBox(
                                height: 220,
                                child: Center(
                                  child: Text(
                                    "Failed to load points",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final balance = state.balance;
                      final points = state.points;

                      return Column(
                        children: [
                          TotalpointsCard(
                            totalpoints: balance, // shows shimmer if null
                          ),
                          const SizedBox(height: 16),
                          PointsTabBar(tabController: tabController),
                          const SizedBox(height: 12),
                          Expanded(
                            child: CustomTabBarView(
                              tabController: tabController,
                              pointsHistoryList: points,
                              balance: balance,
                              onRefresh: _refreshPoints,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
