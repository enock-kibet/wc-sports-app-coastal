part of 'team.dart';

class TeamStandings extends StatelessWidget {
  const TeamStandings({super.key});
  static const double _rowHeight = 48;
  static const List<String> _headers = [
    "RANK",
    "TEAM",
    "GP",
    "W",
    "L",
    "F",
    "WIN%",
    "PF",
    "PA",
    "PD",
    "POINTS",
  ];
  static const List<double> _columnWidths = [
    84,
    200,
    72,
    72,
    72,
    72,
    88,
    88,
    88,
    88,
    96,
  ];

  Future<void> _refreshStandings(BuildContext context) {
    final bloc = context.read<TeamStatsBloc>();
    return refreshBlocState<TeamStatsState>(
      bloc: bloc,
      dispatch: () => bloc.add(const TeamStatsEvent.standings()),
      isLoading: (state) => state.status.isLoading,
    );
  }

  Widget _buildRefreshMessage(
    BuildContext context, {
    required String message,
  }) {
    return RefreshIndicator.adaptive(
      onRefresh: () => _refreshStandings(context),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 220,
            child: Center(child: Text(message)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamStatsBloc, TeamStatsState>(
      builder: (context, state) {
        if (state.status == TeamStatsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == TeamStatsStatus.failure) {
          return _buildRefreshMessage(
            context,
            message: "Failed to load standings",
          );
        }

        final standings = state.teamstats ?? [];
        if (standings.isEmpty) {
          return _buildRefreshMessage(
            context,
            message: "No standings available",
          );
        }

        // Sort by points (highest first)
        final sortedStandings = [...standings]..sort((a, b) {
            final rankCompare = a.rank.compareTo(b.rank);
            if (rankCompare != 0) return rankCompare;
            return b.points.compareTo(a.points);
          });
        final colorScheme = Theme.of(context).colorScheme;
        final dividerColor = colorScheme.onSurface.withValues(alpha: 0.35);

        return Padding(
          padding: const EdgeInsets.only(top: kMedium),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ColoredBox(
              color: colorScheme.surface,
              child: RefreshIndicator.adaptive(
                onRefresh: () => _refreshStandings(context),
                child: TableView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  columns: _columnWidths
                      .asMap()
                      .entries
                      .map((entry) => TableColumn(
                            width: entry.value,
                            freezePriority: entry.key == 0 ? 1 : 0,
                          ))
                      .toList(growable: false),
                  rowCount: sortedStandings.length,
                  rowHeight: _rowHeight,
                  headerHeight: _rowHeight,
                  headerBuilder: (context, contentBuilder) => ColoredBox(
                    color: colorScheme.surface,
                    child: contentBuilder(
                      context,
                      (context, column) => _buildHeaderCell(
                        column: column,
                        context: context,
                      ),
                    ),
                  ),
                  rowBuilder: (context, row, contentBuilder) {
                    final standing = sortedStandings[row];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: dividerColor, width: 0.5),
                        ),
                      ),
                      child: contentBuilder(
                        context,
                        (context, column) => _buildBodyCell(
                          standing: standing,
                          column: column,
                          context: context,
                        ),
                      ),
                    );
                  },
                  style: TableViewStyle(
                    dividers: TableViewDividersStyle(
                      horizontal: TableViewHorizontalDividersStyle(
                        header: TableViewHorizontalDividerStyle(
                          color: dividerColor,
                          thickness: 0.5,
                          space: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCell({
    required int column,
    required BuildContext context,
  }) {
    final isTeamColumn = column == 1;
    final headerStyle = context.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
    );

    return _buildCell(
      context: context,
      column: column,
      text: _headers[column],
      isTeamColumn: isTeamColumn,
      style: headerStyle,
    );
  }

  Widget _buildBodyCell({
    required TeamStatsData standing,
    required int column,
    required BuildContext context,
  }) {
    final value = switch (column) {
      0 => standing.rank.toString(),
      1 => standing.teamName,
      2 => standing.gamesPlayed.toString(),
      3 => standing.wins.toString(),
      4 => standing.losses.toString(),
      5 => standing.forfeits.toString(),
      6 => _formatWinPercentage(standing.winPercentage),
      7 => standing.pointsScored.toString(),
      8 => standing.pointsAgainst.toString(),
      9 => standing.pointsDifference.toString(),
      10 => standing.points.toString(),
      _ => "",
    };

    return _buildCell(
      context: context,
      column: column,
      text: value,
      isTeamColumn: column == 1,
      style: context.textTheme.bodySmall,
    );
  }

  Widget _buildCell({
    required BuildContext context,
    required int column,
    required String text,
    required bool isTeamColumn,
    TextStyle? style,
  }) {
    final showRightBorder = column < _headers.length - 1;
    final borderColor = Theme.of(context).colorScheme.onSurface.withValues(
          alpha: 0.35,
        );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: showRightBorder
            ? Border(
                right: BorderSide(color: borderColor, width: 0.5),
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Align(
          alignment: isTeamColumn ? Alignment.centerLeft : Alignment.center,
          child: Text(
            text,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  String _formatWinPercentage(double value) {
    final fixed = value.toStringAsFixed(2);
    return fixed
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
}
