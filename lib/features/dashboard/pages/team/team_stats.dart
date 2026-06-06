part of 'team.dart';

class TeamStats extends StatelessWidget {
  final String? selectedClubId;

  const TeamStats({super.key, this.selectedClubId});

  Future<void> _refreshMatchStats(BuildContext context) {
    final bloc = context.read<MatchBloc>();
    return refreshBlocState<MatchState>(
      bloc: bloc,
      dispatch: () => bloc.add(MatchEvent.matchstats(clubId: selectedClubId)),
      isLoading: (state) => state.status.isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        final matches = state.statsMatches;
        final isIpad = _isIpadLayout(context);

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isIpad ? 760 : double.infinity,
                        ),
                        child: TabBar(
                          isScrollable: false,
                          tabs: [
                            Container(
                              alignment: Alignment.center,
                              child: const Tab(text: "Team Stats"),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Tab(text: "Personal Stats"),
                            ),
                          ],
                          labelColor: Theme.of(context).colorScheme.onSurface,
                          unselectedLabelColor: Colors.grey,
                          indicator: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          dividerColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        RefreshIndicator.adaptive(
                          onRefresh: () => _refreshMatchStats(context),
                          child: _buildTeamStatsMatches(context, matches),
                        ),
                        PlayerStats(
                          context,
                          selectedClubId: selectedClubId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeamStatsMatches(BuildContext context, List<MatchType> matches) {
    if (!_isIpadLayout(context)) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: matches.length,
        itemBuilder: (context, index) => _buildMatchCard(matches[index]),
      );
    }

    final rowCount = (matches.length / 2).ceil();

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: rowCount,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, rowIndex) {
        final leftIndex = rowIndex * 2;
        final rightIndex = leftIndex + 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildMatchCard(matches[leftIndex]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: rightIndex < matches.length
                  ? _buildMatchCard(matches[rightIndex])
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMatchCard(MatchType match) {
    return MatchCard(
      match: match.recap,
      homeTeam: match.teamOne,
      homePic: match.recap?.clubOne.pic,
      homeAbbr: "AP",
      homeColor: Colors.indigo,
      awayTeam: match.teamTwo,
      awayPic: match.recap?.clubTwo.pic,
      awayAbbr: "M",
      awayColor: Colors.black87,
      homeScore: match.teamOneScore,
      awayScore: match.teamTwoScore,
      date: match.matchDate.toString(),
    );
  }

  bool _isIpadLayout(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS &&
        MediaQuery.of(context).size.shortestSide >= 600;
  }
}

Widget PlayerStats(BuildContext context, {String? selectedClubId}) {
  return BlocProvider(
    create: (_) =>
        StatBloc(clubId: selectedClubId)..add(const StatEvent.stats()),
    child: BlocBuilder<StatBloc, StatState>(
      builder: (context, state) {
        Future<void> onRefresh() {
          final bloc = context.read<StatBloc>();
          return refreshBlocState<StatState>(
            bloc: bloc,
            dispatch: () => bloc.add(const StatEvent.stats()),
            isLoading: (state) => state.status.isLoading,
          );
        }

        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isFailure) {
          return RefreshIndicator.adaptive(
            onRefresh: onRefresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 220,
                  child: Center(child: Text("Error: ${state.failure}")),
                ),
              ],
            ),
          );
        }
        if (state.status.isSuccess && state.stats != null) {
          final categories = state.stats!.keys.toList();

          return Column(
            children: [
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Team Stat Leaders",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              const SizedBox(height: kSmall),
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      for (var category in categories) ...[
                        StatCard(category: category),
                        const SizedBox(height: kSmall),
                      ]
                    ]),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox(); // initial state
      },
    ),
  );
}

// Widget CardComponent(int Position, String Category) {
//   // Convert the Position into an ordinal string like "1st", "2nd", "3rd", etc.
//   String position = switch (Position) {
//     1 => "1st",
//     2 => "2nd",
//     3 => "3rd",
//     _ => "$Position" + "th", // Default case for other numbers
//   };

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       // Use the position string dynamically here
//       Text(position,
//           style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: Color(0xff0F0C2E))),
//       SizedBox(height: 4),
//       Text(Category,
//           style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)),
//     ],
//   );
// }

Widget TeamStatValues(
    {String Category = "Points",
    String? name = null,
    String? details = null,
    bool? alternate = false}) {
  return alternate ?? true
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "2. Kenya Moja",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: kXXSmall,
            ),
            Text(
              (details ?? "16.7") + " $Category Per Game",
              style: TextStyle(fontSize: 8),
            )
          ],
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "1. Jamal Kibet",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
            Text(
              (details ?? "18.2") + " $Category Per Game",
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
            )
          ],
        );
}

Widget PlayerImage(
    {String? image = null,
    String? name = null,
    double? width = null,
    double? height = null,
    double radius = 6}) {
  const placeholder = 'assets/images/user.png';

  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: image != null && image.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: image,
            errorWidget: (context, url, error) => Image.asset(
              placeholder,
              width: width ?? 116,
              height: height ?? 104,
              fit: BoxFit.cover,
            ),
            width: width ?? 116,
            height: height ?? 104,
            fit: BoxFit.contain,
          )
        : const Text(""),
  );
}

class StatCard extends StatelessWidget {
  final String category;

  const StatCard({
    super.key,
    this.category = "Points",
  });

  static const int maxItems = 3;

  @override
  Widget build(BuildContext context) {
    final entries = context.select<StatBloc, List<Stats>>(
      (bloc) => bloc.state.stats?[category] ?? [],
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kSmall,
        horizontal: kSMedium,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(kMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, entries),
          const SizedBox(height: kSMedium),
          _buildContent(context, entries),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, List<Stats> entries) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: kSMedium,
          ),
        ),
        if (entries.length > maxItems)
          TextButton(
            onPressed: () => _showMoreDialog(context, entries),
            child: const Text("View More", style: TextStyle(fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, List<Stats> entries) {
    if (entries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(kSmall),
          child: Text("No data available"),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: _buildStatsList(entries)),
        _buildPlayerImage(entries),
      ],
    );
  }

  Widget _buildStatsList(List<Stats> entries) {
    final itemCount = entries.length.clamp(0, maxItems);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(itemCount, (i) {
        final entry = entries[i];

        return Padding(
          padding: EdgeInsets.only(
            bottom: i < itemCount - 1 ? kSMedium : 0,
          ),
          child: TeamStatValues(
            Category: category,
            alternate: i.isOdd,
            name: "${entry.rank}. ${entry.playerName}",
            details: _formatAverage(entry.avg),
          ),
        );
      }),
    );
  }

  Widget _buildPlayerImage(List<Stats> entries) {
    if (entries.isEmpty) {
      return PlayerImage();
    }

    final topPlayer = entries.first;

    return PlayerImage(
      image: topPlayer.imageUrl,
      name: topPlayer.playerName,
    );
  }

  void _showMoreDialog(BuildContext context, List<Stats> entries) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (_) => AlertDialog(
        title: Text("$category Leaders", style: TextStyle(fontSize: 15)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: entries.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              final player = entries[i];

              return ListTile(
                leading: SizedBox(
                  width: 56, // fixed width
                  child: PlayerImage(
                    image: player.imageUrl,
                    name: player.playerName,
                  ),
                ),
                title: Text(
                  "${player.rank}. ${player.playerName}",
                  style: TextStyle(fontSize: 10),
                ),
                subtitle: Text("${player.clubname} • ${player.games} games",
                    style: TextStyle(fontSize: 10)),
                trailing: Text(
                  _formatAverage(player.avg),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  String _formatAverage(double avg) {
    final fixed = avg.toStringAsFixed(3);
    return fixed
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
}
// Widget TeamSummaryStats() {
//   return Card(
//     margin: EdgeInsets.zero,
//     color: const Color(0xfff2f2f2),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CardComponent(1, "Points"),
//           CardComponent(2, "Assists"),
//           CardComponent(1, "Rebounds"),
//           CardComponent(3, "Freethrows"),
//           CardComponent(1, "Turnovers")
//         ],
//       ),
//     ),
//   );
// }
