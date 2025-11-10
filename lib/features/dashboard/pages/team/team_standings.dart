part of 'team.dart';

class TeamStandings extends StatelessWidget {
  const TeamStandings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamStatsBloc, TeamStatsState>(
      builder: (context, state) {
        if (state.status == TeamStatsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == TeamStatsStatus.failure) {
          return Center(child: Text("Failed to load standings"));
        }

        final standings = state.teamstats ?? [];
        if (standings.isEmpty) {
          return const Center(child: Text("No standings available"));
        }

        // Sort by points (highest first)
        final sortedStandings = [...standings]
          ..sort((a, b) => b.points.compareTo(a.points));

        return Column(
          children: [
            const SizedBox(height: kMedium),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: DataTable(
                    dividerThickness: 0.0000000001,
                    headingRowColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.surface),
                    dataRowColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.surface),
                    horizontalMargin: 0,
                    columnSpacing: 20,
                    border: TableBorder(
                      verticalInside: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 0.5),
                      horizontalInside: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 0.5),
                    ),
                    showBottomBorder: false,
                    columns: const [
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Pos"),
                        ),
                      ),
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Team"),
                        ),
                      ),
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Won"),
                        ),
                      ),
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Lost"),
                        ),
                      ),
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Points"),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      sortedStandings.length,
                      (index) => _buildStandingRow(
                        sortedStandings[index],
                        index + 1,
                        context,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  DataRow _buildStandingRow(
      TeamStatsData standing, int position, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Center(child: Text(position.toString()))),
        DataCell(Text(standing.teamName)),
        DataCell(Center(child: Text(standing.wins.toString()))),
        DataCell(Center(child: Text(standing.losses.toString()))),
        DataCell(Center(child: Text(standing.points.toString()))),
      ],
    );
  }
}
