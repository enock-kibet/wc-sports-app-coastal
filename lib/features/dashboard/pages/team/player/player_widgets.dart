part of 'player.dart';

class PlayerTab extends StatelessWidget {
  final tabController;
  const PlayerTab({super.key, this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        dividerHeight: .5,
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        dividerColor: AppColors.greyColor,
        unselectedLabelStyle: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.greyColor,
            letterSpacing: 1),
        indicator: UnderlineTabIndicator(
            insets: const EdgeInsets.symmetric(horizontal: -30),
            borderSide: BorderSide(width: 4, color: AppColors.blackColor),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3), topRight: Radius.circular(3))),
        labelStyle: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.darkColor,
            letterSpacing: 1),
        controller: tabController,
        tabs: const [
          Tab(text: "  STATS  "),
          Tab(
            text: "PROFILE ",
          ),
          Tab(
            text: '  MEDIA  ',
          )
        ]);
  }
}

class PlayerProfilePicture extends StatelessWidget {
  final RoasterData player;
  const PlayerProfilePicture({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
        radius: 16,
        padding: EdgeInsets.all(0),
        showBorder: false,
        height: 300,
        backgroundColor: Colors.black,
        child: PlayerImage(radius: 10, image: player.imageUrl));
  }
}

class PlayerStatsTable extends StatelessWidget {
  const PlayerStatsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatBloc, StatState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.status.isFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Failed to load player stats",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        }

        final matchStats = state.playerStats ?? [];

        if (matchStats.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text("No stats available"),
          );
        }

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
                    border: const TableBorder(
                      verticalInside:
                          BorderSide(color: Color(0xffdcdcdc), width: 1),
                    ),
                    showBottomBorder: false,
                    columns: const [
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Vs"),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Result"),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Field Goals"),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Free Throws"),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Three Pointers"),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Fouls"),
                      )),
                    ],
                    rows: matchStats.map((match) {
                      // Helper to get a stat count by name
                      int getStat(String name) {
                        return match.statsByType
                                .firstWhere(
                                  (s) => s.statType.stattype == name,
                                  orElse: () => StatsByType(
                                    statType: StatType(stattype: name),
                                    count: 0,
                                  ),
                                )
                                .count ??
                            0;
                      }

                      return DataRow(
                        cells: [
                          DataCell(Text(match.matchTitle)),
                          DataCell(Text(match.scoreboard)),
                          DataCell(Text('${getStat("Field Goal")}')),
                          DataCell(Text('${getStat("Free Throw (FT)")}')),
                          DataCell(Text('${getStat("Three Pointer (3 PT)")}')),
                          DataCell(Text('${getStat("Personal Fouls")}')),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

DataRow productDataRow(StandingModel productData, index, BuildContext context) {
  return DataRow(selected: false, cells: [
    DataCell(Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        productData.Vs,
        style: TextStyle(fontSize: 12),
      ),
    )),
    DataCell(Text(productData.Result, style: TextStyle(fontSize: 12))),
    DataCell(
        Center(child: Text(productData.Min, style: TextStyle(fontSize: 12)))),
    DataCell(Center(
        child: Text(productData.Points.toString(),
            style: TextStyle(fontSize: 12)))),
    DataCell(Center(
        child: Text(productData.OffReb.toString(),
            style: TextStyle(fontSize: 12)))),
    DataCell(Center(
        child: Text(productData.DefReb.toString(),
            style: TextStyle(fontSize: 12)))),
    DataCell(Center(
        child: Text(productData.Steals.toString(),
            style: TextStyle(fontSize: 12)))),
    DataCell(Center(
        child: Text(productData.Assists.toString(),
            style: TextStyle(fontSize: 12)))),
    DataCell(Center(
        child: Text(productData.Blocks.toString(),
            style: TextStyle(fontSize: 12)))),
  ]);
}

class StandingModel {
  final String Vs;
  final String Result;
  final String Min;
  final int Points;
  final int OffReb;
  final int DefReb;
  final int Steals;
  final int Assists;
  final int Blocks;

  StandingModel({
    required this.Vs,
    required this.Result,
    required this.Min,
    required this.Points,
    required this.OffReb,
    required this.DefReb,
    required this.Steals,
    required this.Assists,
    required this.Blocks,
  });
}

List<StandingModel> standingData = [
  StandingModel(
      Vs: "Boston Celtics",
      Result: "85-78 W",
      Min: "34",
      Points: 28,
      OffReb: 5,
      DefReb: 7,
      Steals: 2,
      Assists: 6,
      Blocks: 3),
  StandingModel(
      Vs: "Golden State Warriors",
      Result: "70-64 W",
      Min: "35",
      Points: 22,
      OffReb: 6,
      DefReb: 1,
      Steals: 13,
      Assists: 3,
      Blocks: 2),
  StandingModel(
      Vs: "Miami Heat",
      Result: "88-92 L",
      Min: "36",
      Points: 30,
      OffReb: 3,
      DefReb: 9,
      Steals: 1,
      Assists: 5,
      Blocks: 1),
  StandingModel(
      Vs: "Chicago Bulls",
      Result: "95-89 W",
      Min: "38",
      Points: 25,
      OffReb: 4,
      DefReb: 6,
      Steals: 4,
      Assists: 7,
      Blocks: 2),
  StandingModel(
      Vs: "Phoenix Suns",
      Result: "60-58 W",
      Min: "29",
      Points: 18,
      OffReb: 2,
      DefReb: 3,
      Steals: 5,
      Assists: 2,
      Blocks: 0),
  StandingModel(
      Vs: "Milwaukee Bucks",
      Result: "101-104 L",
      Min: "41",
      Points: 34,
      OffReb: 5,
      DefReb: 5,
      Steals: 3,
      Assists: 9,
      Blocks: 4),
  StandingModel(
      Vs: "Denver Nuggets",
      Result: "77-70 W",
      Min: "32",
      Points: 20,
      OffReb: 3,
      DefReb: 4,
      Steals: 6,
      Assists: 4,
      Blocks: 1),
  StandingModel(
      Vs: "Los Angeles Lakers",
      Result: "90-85 W",
      Min: "37",
      Points: 26,
      OffReb: 6,
      DefReb: 5,
      Steals: 2,
      Assists: 8,
      Blocks: 3),
  StandingModel(
      Vs: "Brooklyn Nets",
      Result: "66-72 L",
      Min: "30",
      Points: 16,
      OffReb: 1,
      DefReb: 4,
      Steals: 7,
      Assists: 3,
      Blocks: 2),
  StandingModel(
      Vs: "Dallas Mavericks",
      Result: "93-91 W",
      Min: "39",
      Points: 31,
      OffReb: 7,
      DefReb: 6,
      Steals: 4,
      Assists: 6,
      Blocks: 5),
];
