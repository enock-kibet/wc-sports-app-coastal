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
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4d4d4d)),
            ),
            SizedBox(
              height: kXXSmall,
            ),
            Text(
              (details ?? "16.7") + " $Category Per Game",
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4d4d4d)),
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
            fit: BoxFit.cover,
          )
        : const Text(""),
  );
}

class StatCard extends StatelessWidget {
  final String category;

  const StatCard({super.key, this.category = "Points"});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatBloc>().state.stats;
    final entries = (stats ?? {})[category] ?? [];

    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: kSmall, horizontal: kSMedium),
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).colorScheme.surface, width: 0.5),
        borderRadius: BorderRadius.circular(kMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: kSMedium,
            ),
          ),
          const SizedBox(height: kSMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 144,
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < entries.length && i < 4; i++) ...[
                      TeamStatValues(
                        Category: category,
                        alternate: i % 2 == 1,
                        name: "${entries[i].rank}. ${entries[i].playerName}",
                        details: "${entries[i].avg}",
                      ),
                      if (i < 3) const SizedBox(height: kSMedium),
                    ],
                  ],
                ),
              ),
              if (entries.isNotEmpty)
                PlayerImage(
                    image: entries[0].imageUrl, name: entries[0].playerName)
              else
                PlayerImage(),
            ],
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
