part of 'player.dart';

class PlayerStats extends StatelessWidget {
  const PlayerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: const PlayerStatsTable());
  }
}
