part of 'team.dart';

class TeamRoster extends StatelessWidget {
  const TeamRoster({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoasterBloc, RoasterState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isFailure) {
          return Center(child: Text("Failed to load"));
        } else if (state.status.isSuccess && state.roasters != null) {
          final players = state.roasters!;
          if (players.isEmpty) {
            return const Center(child: Text("No players found"));
          }
          return Padding(
            padding: const EdgeInsets.only(top: kMedium),
            child: SingleChildScrollView(
              child: Column(
                children: players.map((player) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: PlayerProfile(
                      player: player,
                      context: context,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else if (state.roasters != null && state.roasters!.isEmpty) {
          return const Center(child: Text("No players found"));
        } else {
          return const Center(child: Text("No players found"));
        }
      },
    );
  }
}

Widget PlayerProfile({
  required BuildContext context,
  required RoasterData player,
}) {
  return Material(
    color: Colors.transparent,
    clipBehavior: Clip.hardEdge,
    borderRadius: BorderRadius.circular(kMedium),
    child: InkResponse(
      onTap: () {
        context.pushNamed(AppRoute.playerProfile.name, extra: player);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(kMedium),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        child: Row(
          children: [
            PlayerImage(
              image: player.imageUrl,
              height: 48,
              width: 48,
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.playerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${player.playerNumber}   ${player.playerHeight}   ${player.playerWeight}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(0xff4d4d4d),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
