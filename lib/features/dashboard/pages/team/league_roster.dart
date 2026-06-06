part of 'team.dart';

class LeagueRoaster extends StatelessWidget {
  const LeagueRoaster({super.key});

  Future<void> _refreshTeams(BuildContext context) {
    final bloc = context.read<ClubRoastersBloc>();
    return refreshBlocState<ClubRoastersState>(
      bloc: bloc,
      dispatch: () => bloc.add(const ClubRoasterEvent.roasters()),
      isLoading: (state) => state.status.isLoading,
    );
  }

  Widget _buildRefreshMessage(
    BuildContext context, {
    required String message,
  }) {
    return RefreshIndicator.adaptive(
      onRefresh: () => _refreshTeams(context),
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
    return BlocBuilder<ClubRoastersBloc, ClubRoastersState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isFailure) {
          return _buildRefreshMessage(context, message: "Failed to load");
        }
        if (state.status.isSuccess) {
          if (state.clubRoasters!.isEmpty) {
            return _buildRefreshMessage(context, message: "No teams found");
          }
          final teams = state.clubRoasters!;
          final isIpad = Theme.of(context).platform == TargetPlatform.iOS &&
              MediaQuery.of(context).size.shortestSide >= 600;
          return Padding(
            padding: const EdgeInsets.only(top: kMedium),
            child: RefreshIndicator.adaptive(
              onRefresh: () => _refreshTeams(context),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount =
                      isIpad ? (constraints.maxWidth >= 1100 ? 3 : 2) : 2;
                  final childAspectRatio = isIpad ? 2.7 : 2.0;
                  return GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: teams.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final team = teams[index];
                      return ClubProfile(team: team);
                    },
                  );
                },
              ),
            ),
          );
        } else if (state.clubRoasters != null && state.clubRoasters!.isEmpty) {
          return _buildRefreshMessage(context, message: "No teams found");
        } else {
          return _buildRefreshMessage(context, message: "No teams found");
        }
      },
    );
  }
}

String? resolveClubLogoUrl(String? rawImageUrl) {
  if (rawImageUrl == null) return null;

  final value = rawImageUrl.trim();
  if (value.isEmpty) return null;

  const backendHost = 'https://backend.wencetechnologies.com';

  if (value.startsWith('http://') || value.startsWith('https://')) {
    return value;
  }

  if (value.startsWith('/SportApp/')) {
    return '$backendHost$value';
  }

  if (value.startsWith('/images/')) {
    return '$backendHost/SportApp$value';
  }

  if (value.startsWith('images/')) {
    return '$backendHost/SportApp/$value';
  }

  return '$backendHost/SportApp/images/$value';
}

class ClubProfile extends StatelessWidget {
  const ClubProfile({super.key, required this.team});

  final ClubRoasterData team;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoUrl = resolveClubLogoUrl(team.imageUrl);
    final hasLogo = !showTeamAbbrOnly && logoUrl != null && logoUrl.isNotEmpty;
    final borderColor = theme.brightness == Brightness.dark
        ? Colors.white24
        : const Color(0xffE6E6E6);
    final foregroundColor = theme.colorScheme.onSurface;

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(kMedium),
      child: InkResponse(
        onTap: () {
          context.pushNamed(AppRoute.clubRoaster.name, extra: team);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: hasLogo
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: CachedNetworkImage(
                            imageUrl: logoUrl,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Text(
                              getInitials(team.name),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: foregroundColor,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9D96B),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            getInitials(team.name),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      team.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: foregroundColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String getInitials(String name) {
  if (name.trim().isEmpty) return "";

  List<String> parts = name.trim().split(" ");

  if (parts.length == 1) {
    return parts[0].substring(0, 1).toUpperCase();
  }

  return (parts[0][0] + parts[1][0]).toUpperCase();
}

// class _TeamCard extends StatelessWidget {
//   final _TeamItem team;

//   const _TeamCard({required this.team});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: const Color(0xffE6E6E6)),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 72,
//             width: 72,
//             decoration: BoxDecoration(
//               color: team.color,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               team.initials,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             team.name,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   color: const Color(0xff8E8E8E),
//                   fontSize: 10,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
