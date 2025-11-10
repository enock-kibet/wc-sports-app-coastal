part of 'player.dart';

class PlayerInfo extends StatelessWidget {
  final RoasterData player;
  const PlayerInfo({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: [
          StatLine(label: "Name", value: player.playerName),
          StatLine(label: "Positions", value: player.position),
          StatLine(
            label: "Profile",
            value: "${player.playerHeight}, ${player.playerWeight}",
          ),
          StatLine(label: "Jersey Number", value: player.playerNumber),
          // Optional: Display total stat summary
          if (player.stats.isNotEmpty)
            StatLine(
              label: "Total Stats",
              value:
                  "${player.stats.entries.map((e) => '${e.key}: ${e.value}').join(', ')}",
            ),
        ],
      ),
    );
  }
}

List<Map<String, String>> player_info = [
  {'name': 'Joel Embiid'},
  {'age': "30"},
  {"position": "Center"},
  {"profile": "7'0, 127 Kgs"},
  {'experience': "10 Yrs"}, // 7 feet 0 inches
  {'jersey Number': '12'},
  {'Home Town': 'Philadelphia'},
];

class StatLine extends StatelessWidget {
  final String label;
  final String value;

  const StatLine({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 144,
              child: Text(
                "$label:",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
