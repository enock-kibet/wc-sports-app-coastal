part of 'team.dart';

class TeamStandings extends StatelessWidget {
  const TeamStandings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kMedium,),
        TeamSummaryStats(),
        SizedBox(height: kMedium,),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: DataTable(
                  //headingRowHeight: 30,
                  dividerThickness: 0.0000000001,
                  headingRowColor: const WidgetStatePropertyAll(Color(0xffeeeeee)),
                  dataRowColor: const WidgetStatePropertyAll(Color(0xfff6f6f6)),
                  horizontalMargin: 0,
                  columnSpacing: 20,
                  border:  TableBorder(
                    verticalInside: BorderSide(
                      color: Color(0xffdcdcdc),
                      width: 1
                    )
                  ),
                  showBottomBorder: false,
                  columns: const [
                    DataColumn(label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Pos"),
                    )),
                    DataColumn(label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Team"),
                    )),
                    DataColumn(label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Won"),
                    )),
                    DataColumn(label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Lost"),
                    )),
                    DataColumn(label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Points"),
                    )),

                  ],
                  rows: List.generate(
                      standingData.length,
                          (index) => productDataRow(
                          standingData[index], index, context))),
            ),
          ),
        )
      ],
    );
  }
}
DataRow productDataRow(
    StandingModel productData, index, BuildContext context) {
  return DataRow(selected: false, cells: [
    DataCell(Center(child: Text(productData.position!))),
    DataCell(Text(productData.team!)),
    DataCell(Center(child: Text(productData.won.toString()))),
    DataCell(Center(child: Text(productData.lost.toString()))),
    //DataCell(Text(productData.draw.toString())),
    DataCell(Center(child: Text(productData.points!.toString()))),
  ]);
}
class StandingModel {
  final String? position;
  final String? team;
  final int? won;
  final int? lost;
  final int? draw;
  final int? points;

  StandingModel(
      {required this.position,
        required this.team,
        required this.won,
        required this.lost,
        required this.draw,
        required this.points});
}

List<StandingModel> standingData = [
  StandingModel(
      position: "1", team: "AfroPacers", won: 6, lost: 1, draw: 0, points: 13),
  StandingModel(
      position: "2", team: "Mamluki", won: 4, lost: 2, draw: 0, points: 10),
  StandingModel(
      position: "3",
      team: "Kirinyaga Bulls",
      won: 4,
      lost: 0,
      draw: 0,
      points: 8),
  StandingModel(
      position: "4", team: "Ugwaro Nets", won: 4, lost: 0, draw: 0, points: 8),
  StandingModel(
      position: "5", team: "Kicks Kenya", won: 4, lost: 1, draw: 0, points: 7),
  StandingModel(
      position: "6", team: "Rongai Lions", won: 3, lost: 1, draw: 0, points: 7),
  StandingModel(
      position: "7",
      team: "Chamani Ballers",
      won: 2,
      lost: 2,
      draw: 0,
      points: 6),
  StandingModel(
      position: "8",
      team: "Kibera's Finest",
      won: 2,
      lost: 1,
      draw: 0,
      points: 5),
];