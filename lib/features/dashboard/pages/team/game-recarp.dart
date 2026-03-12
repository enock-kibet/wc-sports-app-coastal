import 'package:cached_network_image/cached_network_image.dart';
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
    final quarterRows = _dummyQuarterRows(
      clubOneScore,
      clubTwoScore,
    );
    final statLeaders = _dummyStatLeaders();

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
                Expanded(
                  // 👈 THIS IS THE KEY
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: kSMedium),
                    child: Column(
                      children: [
                        _scoreHeader(
                          context: context,
                          team1: clubOneName,
                          team2: clubTwoName,
                          team1Pic: clubOne.pic,
                          team2Pic: clubTwo.pic,
                          score1: clubOneScore,
                          score2: clubTwoScore,
                          dateLabel: formattedDate,
                          venue: venueName,
                          quarterRows: quarterRows,
                        ),
                        const SizedBox(height: 18),
            _gameStatLeaders(context, statLeaders),
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
    required String? team1Pic,
    required String? team2Pic,
    required String score1,
    required String score2,
    required String dateLabel,
    required String venue,
    required List<_QuarterRow> quarterRows,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor =
        theme.brightness == Brightness.dark ? Colors.white24 : Colors.black12;
    final mutedColor =
        theme.brightness == Brightness.dark ? Colors.white60 : const Color(0xFF8A8A8A);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _teamMini(context, team1, pic: team1Pic),
              ),
              SizedBox(
                width: 64,
                child: Text(
                  score1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              SizedBox(
                width: 72,
                child: Column(
                  children: [
                    Text(
                      "Final",
                      style: TextStyle(
                        fontSize: 15,
                        color: mutedColor,
                      ),
                    ),
                    Text(
                      dateLabel,
                      style: TextStyle(
                        fontSize: 14,
                        color: mutedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 64,
                child: Text(
                  score2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: _teamMini(context, team2, pic: team2Pic),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: borderColor, height: 1),
          const SizedBox(height: 14),
          _quarterBreakdown(context, quarterRows),
        ],
      ),
    );
  }

  Widget _quarterBreakdown(BuildContext context, List<_QuarterRow> quarterRows) {
    const headers = ["Q1", "Q2", "Q3", "Q4", "T"];
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final headerColor =
        theme.brightness == Brightness.dark ? Colors.white60 : const Color(0xFF8A8A8A);
    final valueColor =
        theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF4A4A4A);

    Widget statCell(
      String value, {
      bool bold = false,
      TextAlign textAlign = TextAlign.center,
      Color? color,
    }) {
      return Expanded(
        child: Text(
          value,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 12,
            color: color ?? valueColor,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 140),
            for (final header in headers)
              statCell(
                header,
                bold: false,
                color: headerColor,
              ),
          ],
        ),
        const SizedBox(height: 12),
        ...quarterRows.map((row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    row.teamName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                statCell(row.q1),
                statCell(row.q2),
                statCell(row.q3),
                statCell(row.q4),
                statCell(row.total),
              ],
            ),
          );
        }),
      ],
    );
  }

  List<_QuarterRow> _dummyQuarterRows(
    String homeTotal,
    String awayTotal,
  ) {
    return [
      _QuarterRow(
        teamName: match.clubOne.name,
        q1: "21",
        q2: "16",
        q3: "08",
        q4: "19",
        total: homeTotal,
      ),
      _QuarterRow(
        teamName: match.clubTwo.name,
        q1: "25",
        q2: "02",
        q3: "05",
        q4: "26",
        total: awayTotal,
      ),
    ];
  }

  List<_LeaderCategory> _dummyStatLeaders() {
    return const [
      _LeaderCategory(
        title: "Points",
        leftLeader: _LeaderEntry(
          name: "Jamal Kibet",
          value: "23 PTS",
        ),
        rightLeader: _LeaderEntry(
          name: "Tom Obiri",
          value: "18 PTS",
        ),
      ),
      _LeaderCategory(
        title: "Assists",
        leftLeader: _LeaderEntry(
          name: "Jamal Kibet",
          value: "5 Assists",
        ),
        rightLeader: _LeaderEntry(
          name: "Tom Obiri",
          value: "6 Assists",
        ),
      ),
      _LeaderCategory(
        title: "Rebounds",
        leftLeader: _LeaderEntry(
          name: "Jamal Kibet",
          value: "8 Rebounds",
        ),
        rightLeader: _LeaderEntry(
          name: "Tom Obiri",
          value: "14 Rebounds",
        ),
      ),
      _LeaderCategory(
        title: "Steals",
        leftLeader: _LeaderEntry(
          name: "Jamal Kibet",
          value: "5 Steals",
        ),
        rightLeader: _LeaderEntry(
          name: "Tom Obiri",
          value: "7 Steals",
        ),
      ),
      _LeaderCategory(
        title: "Blocks",
        leftLeader: _LeaderEntry(
          name: "Jamal Kibet",
          value: "4 Blocks",
        ),
        rightLeader: _LeaderEntry(
          name: "Tom Obiri",
          value: "2 Blocks",
        ),
      ),
    ];
  }

  Widget _gameStatLeaders(BuildContext context, List<_LeaderCategory> leaders) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor =
        theme.brightness == Brightness.dark ? Colors.white24 : const Color(0xFFD5D5D5);
    final dividerColor =
        theme.brightness == Brightness.dark ? Colors.white12 : const Color(0xFFDCDCDC);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Game Stat Leaders",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 14),
        ...leaders.map((leader) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leader.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _leaderTile(context, leader.leftLeader)),
                      Container(
                        width: 1,
                        height: 46,
                        color: dividerColor,
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                      ),
                      Expanded(child: _leaderTile(context, leader.rightLeader)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _leaderTile(BuildContext context, _LeaderEntry leader) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final avatarBg = theme.brightness == Brightness.dark
        ? scheme.primary.withValues(alpha: 0.22)
        : const Color(0xFFE8E1F7);
    final avatarFg = theme.brightness == Brightness.dark
        ? scheme.primary
        : const Color(0xFF4A4372);
    final mutedColor =
        theme.brightness == Brightness.dark ? Colors.white60 : const Color(0xFF777777);

    final initials = leader.name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part.substring(0, 1).toUpperCase())
        .join();

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: avatarBg,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            initials.isEmpty ? "?" : initials,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: avatarFg,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leader.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                leader.value,
                style: TextStyle(
                  fontSize: 12,
                  color: mutedColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _teamMini(BuildContext context, String name, {String? pic}) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final mutedColor =
        theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF5B5B5B);
    final abbr = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .take(2)
        .map((e) => e.substring(0, 1).toUpperCase())
        .join();
    final hasPic = pic != null && pic.isNotEmpty;

    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: theme.brightness == Brightness.dark
              ? Colors.white10
              : scheme.primary.withValues(alpha: 0.12),
          child: hasPic
              ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: pic,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        Text(
                          abbr.isEmpty ? "?" : abbr,
                          style: TextStyle(color: scheme.onSurface),
                        ),
                  ),
                )
              : Text(
                  abbr.isEmpty ? "?" : abbr,
                  style: TextStyle(color: scheme.onSurface),
                ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 84,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: mutedColor,
            ),
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor =
        theme.brightness == Brightness.dark ? Colors.white24 : Colors.black12;
    final mutedColor =
        theme.brightness == Brightness.dark ? Colors.white60 : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  leftTeam,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: Text(
                  rightTeam,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
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
                  Expanded(
                    child: Text(
                      l.toString(),
                      style: TextStyle(color: scheme.onSurface),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      k,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: mutedColor),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      r.toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(color: scheme.onSurface),
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

class _QuarterRow {
  final String teamName;
  final String q1;
  final String q2;
  final String q3;
  final String q4;
  final String total;

  const _QuarterRow({
    required this.teamName,
    required this.q1,
    required this.q2,
    required this.q3,
    required this.q4,
    required this.total,
  });
}

class _LeaderCategory {
  final String title;
  final _LeaderEntry leftLeader;
  final _LeaderEntry rightLeader;

  const _LeaderCategory({
    required this.title,
    required this.leftLeader,
    required this.rightLeader,
  });
}

class _LeaderEntry {
  final String name;
  final String value;

  const _LeaderEntry({
    required this.name,
    required this.value,
  });
}
