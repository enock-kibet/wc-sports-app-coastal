part of 'team.dart';

class TeamRoster extends StatelessWidget {
  final String? clubId;
  const TeamRoster({super.key, this.clubId});

  Future<void> _refreshRoster(BuildContext context) {
    final bloc = context.read<RoasterBloc>();
    return refreshBlocState<RoasterState>(
      bloc: bloc,
      dispatch: () => bloc.add(RoasterEvent.roasters(clubId)),
      isLoading: (state) => state.status.isLoading,
    );
  }

  Widget _buildRefreshMessage(
    BuildContext context, {
    required String message,
  }) {
    return RefreshIndicator.adaptive(
      onRefresh: () => _refreshRoster(context),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 220,
            child: Center(child: Text(message)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoasterBloc, RoasterState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isFailure) {
          return _buildRefreshMessage(context, message: "Failed to load");
        } else if (state.status.isSuccess && state.roasters != null) {
          final players = state.roasters!;
          if (players.isEmpty) {
            return _buildRefreshMessage(context, message: "No players found");
          }
          return Padding(
            padding: const EdgeInsets.only(top: kMedium),
            child: RefreshIndicator.adaptive(
              onRefresh: () => _refreshRoster(context),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: PlayerProfile(
                      player: player,
                      context: context,
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state.roasters != null && state.roasters!.isEmpty) {
          return _buildRefreshMessage(context, message: "No players found");
        } else {
          return _buildRefreshMessage(context, message: "No players found");
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
