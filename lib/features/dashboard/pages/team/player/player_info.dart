part of 'player.dart';

class PlayerInfo extends StatelessWidget {
  final PlayerProfileData player;
  const PlayerInfo({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:18.0),
      child: Column(
        children: [
          StatLine(label: "name", value: player.name),
          StatLine(label: "Age", value: player.age),
          StatLine(label: "position", value: player.position),
          StatLine(label: "Profile", value: "${player.height}, ${player.weight} Kgs"),
          StatLine(label: "experience", value: player.experience),
          StatLine(label: "jersey number", value: player.jerseyNumber),
          StatLine(label: "home town", value: player.homeTown),

        ]
        )
      );
  }
}
List<Map<String, String>> player_info = [
  {'name': 'Joel Embiid'},
  {'age':"30"},
  {"position":"Center"},
  {"profile":"7'0, 127 Kgs"},
  {'experience': "10 Yrs"}, // 7 feet 0 inches
  {'jersey Number': '12'},
  {'Home Town': 'Philadelphia'},
];
class StatLine extends StatelessWidget {
  final String label;
  final String value;
  const StatLine({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom:12),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 144,
              child: Text("${label.toTitleCase()}:",style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 13),),
            ),
            Expanded(
              child: SizedBox(
                width: 100,
                child: Text(value,overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: 13),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
