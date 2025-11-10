part of 'player.dart';

class PlayerStats extends StatelessWidget {
  final RoasterData player;
  const PlayerStats({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          StatBloc()..add(StatEvent.getPlayerStats(playerId: player.playerId)),
      child: const PlayerStatsTable(),
    );
  }
}
