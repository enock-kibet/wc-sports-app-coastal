import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/match/match-recarp.dart';
import 'package:sports_app/features/dashboard/pages/points/points_page.dart';

class GameRecapPage extends StatelessWidget {
  final MatchModel match;

  const GameRecapPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final clubOne = match.clubOne; // ClubModel
    final clubTwo = match.clubTwo; // ClubModel

    final clubOneName = clubOne.name;
    final clubTwoName = clubTwo.name;

    final clubOneScore = match.clubOneScore;
    final clubTwoScore = match.clubTwoScore;

    final parsedDate = match.matchDate.date; // ✅ already DateTime
    final formattedDate =
        "${parsedDate.day.toString().padLeft(2, '0')} ${_mon(parsedDate.month)}";

    final venueName = match.venue.name;

    // ✅ stats are already typed lists
    final clubOneStats = clubOne.stats;
    final clubTwoStats = clubTwo.stats;

    final team1Totals = _aggregateStats(clubOneStats);
    final team2Totals = _aggregateStats(clubTwoStats);

    // choose the stat keys you want to show (expand later)
final statRows = <String>[
  'Field Goal',
  'Free Throw (FT)',
  'Three Pointer (3 PT)',
  'Steals',
  'Blocks',
  'Assists',
  'Turnovers',
  'Field Goal Attempts',
  '3 Point Attempts',
  'Free Throw Attempts',
  'Offensive Rebounds',
  'Defensive Rebounds',
  'Personal Fouls',
  'Technical Fouls',
];

    return Scaffold(
      body: AppBackground(
        childWidget: SafeArea(
          child: RoundedtopContainer(
            child: Column(
              children: [
                const SizedBox(height: 24),

                    /// ✅ Top Navigation
                    TopNavigation(
                      back: () => context.pop(),
                      title: 'Game Recap',
                    ),

                    const SizedBox(height: 16),
                    Expanded( // 👈 THIS IS THE KEY
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: kSMedium),
        child: Column(
          children: [
            _scoreHeader(
              context: context,
              team1: clubOneName,
              team2: clubTwoName,
              score1: clubOneScore,
              score2: clubTwoScore,
              dateLabel: formattedDate,
              venue: venueName,
            ),
            const SizedBox(height: 18),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Game Stats",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            _statsTable(
              context: context,
              leftTeam: clubOneName,
              rightTeam: clubTwoName,
              statKeys: statRows,
              leftTotals: team1Totals,
              rightTotals: team2Totals,
            ),
          ],
        ),
      ),
    ),
                ],
            ),
          ),
        ),
      ),
    );
  }

  static String _mon(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return (m >= 1 && m <= 12) ? months[m - 1] : "";
  }

  /// ✅ sums typed StatModel list
  static Map<String, num> _aggregateStats(List<StatModel> stats) {
    final totals = <String, num>{};
    for (final s in stats) {
      final key = s.stat.trim();
      if (key.isEmpty) continue;
      totals[key] = (totals[key] ?? 0) + s.statValue;
    }
    return totals;
  }

  Widget _scoreHeader({
    required BuildContext context,
    required String team1,
    required String team2,
    required String score1,
    required String score2,
    required String dateLabel,
    required String venue,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _teamMini(team1),
              Column(
                children: [
                  Text(
                    "$score1  -  $score2",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Final • $dateLabel",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              _teamMini(team2),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              venue,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamMini(String name) {
    final abbr = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .take(2)
        .map((e) => e.substring(0, 1).toUpperCase())
        .join();

    return Column(
      children: [
        CircleAvatar(
          child: Text(abbr.isEmpty ? "?" : abbr),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 110,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _statsTable({
    required BuildContext context,
    required String leftTeam,
    required String rightTeam,
    required List<String> statKeys,
    required Map<String, num> leftTotals,
    required Map<String, num> rightTotals,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  leftTeam,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: Text(
                  rightTeam,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...statKeys.map((k) {
            final l = leftTotals[k] ?? 0;
            final r = rightTotals[k] ?? 0;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(child: Text(l.toString())),
                  Expanded(
                    child: Text(
                      k,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      r.toString(),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
