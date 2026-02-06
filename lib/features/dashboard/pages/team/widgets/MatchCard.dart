import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final String homeAbbr;
  final String awayAbbr;
  final Color homeColor;
  final Color awayColor;
  final String? homeScore;
  final String? awayScore;
  final String date;

  const MatchCard({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeAbbr,
    required this.awayAbbr,
    required this.homeColor,
    required this.awayColor,
    required this.homeScore,
    required this.awayScore,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // format date
    final parsedDate = DateTime.parse(date);

    final formattedDate =
        "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";

    final formattedTime =
        "${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";

    String abbreviationFromName(String name) {
    final cleaned = name.trim();
    if (cleaned.isEmpty) return "N/A";

    // split on ANY whitespace and remove empties
    final parts = cleaned.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (parts.isEmpty) return "N/A";

    if (parts.length == 1) {
      final word = parts.first;
      // take up to 3 chars safely
      final len = word.length >= 3 ? 3 : word.length;
      return word.substring(0, len).toUpperCase();
    }

    // initials of first 2 words (safe)
    return parts.take(2).map((w) => w.substring(0, 1).toUpperCase()).join();
  }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: const Color.fromARGB(117, 199, 199, 199), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Row with scores + teams
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _teamInfo(abbreviationFromName(homeTeam), homeTeam, homeColor,
                    homeScore ?? ""),
                Column(
                  children: [
                    const Text("Final",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey)),
                    Text(formattedDate,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(formattedTime,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                _teamInfo(abbreviationFromName(awayTeam), awayTeam, awayColor,
                    awayScore ?? ""),
              ],
            ),
            const SizedBox(height: 12),

            /// View More
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade200,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   alignment: Alignment.center,
            //   child: const Text(
            //     "View More",
            //     style: TextStyle(color: Colors.black54),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _teamInfo(String abbr, String name, Color color, String score) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Text(abbr,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11)),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  abbr,
                  textAlign: TextAlign.center,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 8),
                ),
              ],
            )),
        const SizedBox(height: 6),
        Text(
          "$score",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
