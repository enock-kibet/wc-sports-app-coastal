part of 'team.dart';

class TeamStats extends StatelessWidget {
  const TeamStats({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = context.read<MatchBloc>().state.statsMatches.toList();

    // print(matches);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              /// Tabs inside a container
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
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
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          dividerColor: Colors.transparent,
                        ),
                      ),
                    ],
                  )),

              /// Tab content
              Expanded(
                child: TabBarView(
                  children: [
                    /// Team Stats
                    ListView.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, index) {
                        return MatchCard(
                          homeTeam: matches[index].teamOne,
                          homeAbbr: "AP",
                          homeColor: Colors.indigo,
                          awayTeam: matches[index].teamTwo,
                          awayAbbr: "M",
                          awayColor: Colors.black87,
                          homeScore: matches[index].teamOneScore,
                          awayScore: matches[index].teamTwoScore,
                          date: matches[index].matchDate.toString(),
                        );
                      },
                    ),

                    /// Personal Stats
                    PlayerStats(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget PlayerStats(BuildContext context) {
  return BlocProvider(
    create: (_) => StatBloc()..add(const StatEvent.stats()),
    child: BlocBuilder<StatBloc, StatState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isFailure) {
          return Center(child: Text("Error: ${state.failure}"));
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var category in categories) ...[
                        StatCard(category: category),
                        const SizedBox(height: kSmall),
                      ]
                    ],
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
            details: "${entry.avg}",
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
                  player.avg.toString(),
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
