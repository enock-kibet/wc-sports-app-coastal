import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/features/dashboard/pages/points/points_page.dart';
import 'package:sports_app/features/dashboard/pages/team/game-recarp.dart';

class PreviousGameRecapPage extends StatelessWidget {
  final MatchType match;

  const PreviousGameRecapPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final recap = match.recap;

    if (recap != null) {
      return GameRecapPage(match: recap);
    }

    return Scaffold(
      body: AppBackground(
        childWidget: SafeArea(
          child: RoundedtopContainer(
            child: Column(
              children: [
                const SizedBox(height: 24),
                TopNavigation(
                  back: () => context.pop(),
                  title: 'Game Recap',
                ),
                const Expanded(
                  child: Center(
                    child: Text('Game recap is not available yet.'),
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
