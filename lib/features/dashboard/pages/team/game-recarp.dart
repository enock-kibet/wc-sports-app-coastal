import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/match/match-recarp.dart';
import 'package:sports_app/data/models/stats/stat.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/dashboard/pages/points/points_page.dart';

class GameRecapPage extends StatefulWidget {
  final MatchModel match;

  const GameRecapPage({super.key, required this.match});

  @override
  State<GameRecapPage> createState() => _GameRecapPageState();
}

class _GameRecapPageState extends State<GameRecapPage> {
  late final Future<List<_LeaderCategory>> _statLeadersFuture;
  late MatchModel _resolvedMatch;
  bool _isHydratingMatch = false;

  MatchModel get match => _resolvedMatch;

  @override
  void initState() {
    super.initState();
    _resolvedMatch = widget.match;
    _statLeadersFuture = _loadStatLeaders();
    _hydrateMatchIfNeeded();
  }

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
    final playerStatistics = match.playerStatistics;

    final team1Totals = _aggregateStats(playerStatistics, 'home');
    final team2Totals = _aggregateStats(playerStatistics, 'away');
    final quarterBreakdown = _buildQuarterBreakdown();

    // choose the stat keys you want to show (expand later)
    final statRows = <String>[
      'Points',
      'Field Goal',
      'Free Throw (FT)',
      'Three Pointer (3 PT)',
      'Steals',
      'Blocks',
      'Assists',
      'Turnovers',
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
                          quarterBreakdown: quarterBreakdown,
                        ),
                        const SizedBox(height: 18),
                        FutureBuilder<List<_LeaderCategory>>(
                          future: _statLeadersFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _gameStatLeadersLoading(context);
                            }

                            final leaders = snapshot.data ?? const [];
                            if (leaders.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return _gameStatLeaders(context, leaders);
                          },
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

  static Map<String, num> _aggregateStats(
    List<PlayerBoxScoreModel> stats,
    String side,
  ) {
    final totals = <String, num>{};
    for (final stat in stats) {
      if (stat.teamSide.toLowerCase() != side.toLowerCase()) {
        continue;
      }

      totals['Points'] = (totals['Points'] ?? 0) + stat.points;
      totals['Field Goal'] = (totals['Field Goal'] ?? 0) + stat.fieldGoalsMade;
      totals['Field Goal Attempts'] =
          (totals['Field Goal Attempts'] ?? 0) + stat.fieldGoalsAttempted;
      totals['Free Throw (FT)'] =
          (totals['Free Throw (FT)'] ?? 0) + stat.freeThrowsMade;
      totals['Free Throw Attempts'] =
          (totals['Free Throw Attempts'] ?? 0) + stat.freeThrowsAttempted;
      totals['Three Pointer (3 PT)'] =
          (totals['Three Pointer (3 PT)'] ?? 0) + stat.threePointersMade;
      totals['3 Point Attempts'] =
          (totals['3 Point Attempts'] ?? 0) + stat.threePointersAttempted;
      totals['Steals'] = (totals['Steals'] ?? 0) + stat.steals;
      totals['Blocks'] = (totals['Blocks'] ?? 0) + stat.blocks;
      totals['Assists'] = (totals['Assists'] ?? 0) + stat.assists;
      totals['Turnovers'] = (totals['Turnovers'] ?? 0) + stat.turnovers;
      totals['Offensive Rebounds'] =
          (totals['Offensive Rebounds'] ?? 0) + stat.offensiveRebounds;
      totals['Defensive Rebounds'] =
          (totals['Defensive Rebounds'] ?? 0) + stat.defensiveRebounds;
      totals['Personal Fouls'] =
          (totals['Personal Fouls'] ?? 0) + stat.personalFouls;
      totals['Technical Fouls'] =
          (totals['Technical Fouls'] ?? 0) + stat.technicalFouls;
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
    required _QuarterBreakdown? quarterBreakdown,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor =
        theme.brightness == Brightness.dark ? Colors.white24 : Colors.black12;
    final mutedColor = theme.brightness == Brightness.dark
        ? Colors.white60
        : const Color(0xFF8A8A8A);

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
          if (quarterBreakdown != null)
            _quarterBreakdown(context, quarterBreakdown)
          else if (_isHydratingMatch)
            const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        ],
      ),
    );
  }

  Future<void> _hydrateMatchIfNeeded() async {
    if (!_needsDetailedRecap(_resolvedMatch)) {
      return;
    }

    setState(() {
      _isHydratingMatch = true;
    });

    final response = await service<MatchService>().getMatchRecap(_resolvedMatch.id);

    if (!mounted) {
      return;
    }

    response.when(
      onError: (_) {
        setState(() {
          _isHydratingMatch = false;
        });
      },
      onSuccess: (hydratedMatch) {
        setState(() {
          _resolvedMatch = hydratedMatch;
          _isHydratingMatch = false;
        });
      },
    );
  }

  bool _needsDetailedRecap(MatchModel match) {
    return match.intervalScores.isEmpty || match.playerStatistics.isEmpty;
  }

  Widget _quarterBreakdown(
    BuildContext context,
    _QuarterBreakdown quarterBreakdown,
  ) {
    final headers = [...quarterBreakdown.headers, "T"];
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final headerColor = theme.brightness == Brightness.dark
        ? Colors.white60
        : const Color(0xFF8A8A8A);
    final valueColor = theme.brightness == Brightness.dark
        ? Colors.white70
        : const Color(0xFF4A4A4A);

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
        ...quarterBreakdown.rows.map((row) {
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
                for (final value in row.intervalScores) statCell(value),
                statCell(row.total),
              ],
            ),
          );
        }),
      ],
    );
  }

  _QuarterBreakdown? _buildQuarterBreakdown() {
    if (match.intervalScores.isEmpty) return null;

    final sortedIntervals = [...match.intervalScores]
      ..sort((a, b) => a.sequencePosition.compareTo(b.sequencePosition));

    return _QuarterBreakdown(
      headers: sortedIntervals
          .map((score) => _intervalLabel(
                sequencePosition: score.sequencePosition,
                interval: score.interval,
              ))
          .toList(),
      rows: [
        _QuarterRow(
          teamName: match.clubOne.name,
          intervalScores:
              sortedIntervals.map((score) => score.homeTeamScore).toList(),
          total: match.clubOneScore,
        ),
        _QuarterRow(
          teamName: match.clubTwo.name,
          intervalScores:
              sortedIntervals.map((score) => score.awayTeamScore).toList(),
          total: match.clubTwoScore,
        ),
      ],
    );
  }

  String _intervalLabel({
    required int sequencePosition,
    required String interval,
  }) {
    final normalizedInterval = interval.trim().toLowerCase();
    if (normalizedInterval.contains('first')) return 'Q1';
    if (normalizedInterval.contains('second')) return 'Q2';
    if (normalizedInterval.contains('third')) return 'Q3';
    if (normalizedInterval.contains('fourth')) return 'Q4';
    if (normalizedInterval.contains('overtime')) {
      final overtimeNumber = sequencePosition - 4;
      return overtimeNumber > 0 ? 'OT$overtimeNumber' : 'OT';
    }
    if (sequencePosition >= 1 && sequencePosition <= 4) {
      return 'Q$sequencePosition';
    }
    return 'P$sequencePosition';
  }

  Future<List<_LeaderCategory>> _loadStatLeaders() async {
    final response = await service<StatService>().getMatchStatLeaders(match.id);

    return response.when(
      onError: (_) => const [],
      onSuccess: (leadersByCategory) {
        final categories = <_LeaderCategory>[];

        leadersByCategory.forEach((category, clubs) {
          final leftLeader = _toLeaderEntry(
            clubs[match.clubOne.name],
            category,
          );
          final rightLeader = _toLeaderEntry(
            clubs[match.clubTwo.name],
            category,
          );

          if (leftLeader == null && rightLeader == null) {
            return;
          }

          categories.add(
            _LeaderCategory(
              title: category,
              leftLeader: leftLeader ??
                  const _LeaderEntry(name: 'No leader', value: '--'),
              rightLeader: rightLeader ??
                  const _LeaderEntry(name: 'No leader', value: '--'),
            ),
          );
        });

        return categories;
      },
    );
  }

  _LeaderEntry? _toLeaderEntry(
    List<MatchStatLeader>? leaders,
    String category,
  ) {
    if (leaders == null || leaders.isEmpty) return null;

    final leader = leaders.first;
    return _LeaderEntry(
      name: leader.playerName.trim().isEmpty
          ? 'Unknown Player'
          : leader.playerName.trim(),
      value: '${leader.stat} ${_statValueLabel(category)}',
    );
  }

  String _statValueLabel(String category) {
    switch (category) {
      case 'Field Goal':
        return 'FG';
      case 'Free Throw (FT)':
        return 'FT';
      case 'Three Pointer (3 PT)':
        return '3PT';
      case 'Personal Fouls':
        return 'PF';
      case 'Technical Fouls':
        return 'TF';
      default:
        return category;
    }
  }

  Widget _gameStatLeaders(BuildContext context, List<_LeaderCategory> leaders) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor = theme.brightness == Brightness.dark
        ? Colors.white24
        : const Color(0xFFD5D5D5);
    final dividerColor = theme.brightness == Brightness.dark
        ? Colors.white12
        : const Color(0xFFDCDCDC);

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

  Widget _gameStatLeadersLoading(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor = theme.brightness == Brightness.dark
        ? Colors.white24
        : const Color(0xFFD5D5D5);

    Widget placeholderTile() {
      return Expanded(
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark
                ? Colors.white10
                : Colors.black.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

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
        ...List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  placeholderTile(),
                  const SizedBox(width: 14),
                  placeholderTile(),
                ],
              ),
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
    final mutedColor = theme.brightness == Brightness.dark
        ? Colors.white60
        : const Color(0xFF777777);

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
    final mutedColor = theme.brightness == Brightness.dark
        ? Colors.white70
        : const Color(0xFF5B5B5B);
    final abbr = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .take(2)
        .map((e) => e.substring(0, 1).toUpperCase())
        .join();
    final hasPic = pic != null && pic.isNotEmpty;
    final fallbackAbbr = abbr.isEmpty ? "?" : abbr;

    Widget fallbackAvatarText() {
      return SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: Text(
            fallbackAbbr,
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurface),
          ),
        ),
      );
    }

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
                    errorWidget: (context, url, error) => fallbackAvatarText(),
                  ),
                )
              : fallbackAvatarText(),
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
            final leftValue = _formatStatValue(
              statKey: k,
              value: l,
              totals: leftTotals,
            );
            final rightValue = _formatStatValue(
              statKey: k,
              value: r,
              totals: rightTotals,
            );
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      leftValue,
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
                      rightValue,
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

  String _formatStatValue({
    required String statKey,
    required num value,
    required Map<String, num> totals,
  }) {
    final attemptsKey = _attemptsStatKey(statKey);
    if (attemptsKey == null) {
      return _formatNumber(value);
    }

    final attempts = totals[attemptsKey] ?? 0;
    return '${_formatNumber(value)}/${_formatNumber(attempts)}';
  }

  String? _attemptsStatKey(String statKey) {
    switch (statKey) {
      case 'Field Goal':
        return 'Field Goal Attempts';
      case 'Free Throw (FT)':
        return 'Free Throw Attempts';
      case 'Three Pointer (3 PT)':
        return '3 Point Attempts';
      default:
        return null;
    }
  }

  String _formatNumber(num value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }
}

class _QuarterRow {
  final String teamName;
  final List<String> intervalScores;
  final String total;

  const _QuarterRow({
    required this.teamName,
    required this.intervalScores,
    required this.total,
  });
}

class _QuarterBreakdown {
  final List<String> headers;
  final List<_QuarterRow> rows;

  const _QuarterBreakdown({
    required this.headers,
    required this.rows,
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
