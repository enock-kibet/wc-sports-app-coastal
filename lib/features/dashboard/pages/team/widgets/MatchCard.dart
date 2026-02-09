import 'package:flutter/material.dart';
import 'package:sports_app/data/models/match/match-recarp.dart';
import 'package:sports_app/features/dashboard/pages/team/game-recarp.dart';

class MatchCard extends StatelessWidget {
  final MatchModel? match;

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
    required this.match, // 👈 add this
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
    final parsedDate = DateTime.tryParse(date);

    final formattedDate = parsedDate == null
        ? "-"
        : "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";

    final formattedTime = parsedDate == null
        ? "-"
        : "${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";

      String abbreviationFromName(String name) {
        final parts = name.split(" ");
        if (parts.length > 1) {
          // single word → first 3 letters
          return parts.first.substring(0, 3).toUpperCase();
        } else {
          // take only the first two words' initials
          return parts.take(2).map((word) => word[0].toUpperCase()).join();
        }
      }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          final m = match;

          if (m == null) return;

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GameRecapPage(match: m), // ✅ now non-null
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color.fromARGB(117, 199, 199, 199),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _teamInfo(abbreviationFromName(homeTeam), homeTeam, homeColor, homeScore ?? ""),
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
                _teamInfo(abbreviationFromName(awayTeam), awayTeam, awayColor, awayScore ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _teamInfo(String abbr, String name, Color color, String score) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Text(
            abbr,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 100,
          child: Column(
            children: [
              Text(abbr, textAlign: TextAlign.center),
              Text(name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 8)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          score,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
