part of 'team.dart';

class LeagueRoaster extends StatelessWidget {
  const LeagueRoaster({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubRoastersBloc, ClubRoastersState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isFailure) {
          return Center(child: Text("Failed to load"));
        }
        if (state.status.isSuccess) {
          if (state.clubRoasters!.isEmpty) {
            return const Center(
              child: Text("No teams found"),
            );
          }
          final teams = state.clubRoasters!;
          return Padding(
            padding: const EdgeInsets.only(top: kMedium),
            child: Container(
              child: GridView.builder(
                itemCount: teams.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return ClubProfile(
                    team: team,
                    context: context,
                  );
                },
              ),
            ),
          );
        } else if (state.clubRoasters != null && state.clubRoasters!.isEmpty) {
          return const Center(child: Text("No teams found"));
        } else {
          return const Center(child: Text("No teams found"));
        }
      },
    );
  }
}

final List<Color> teamColors = [
  const Color(0xff5B5AAE),
  const Color(0xff2E2F3E),
  const Color(0xffF19A6A),
  const Color(0xffB066F0),
  const Color(0xffB3771F),
  const Color(0xff42C233),
  const Color(0xff5A5F62),
  const Color(0xffF07A89),
  const Color(0xff2196F3),
  const Color(0xff009688),
  const Color(0xffE91E63),
  const Color(0xffFF9800),
];

Color getColorFromName(String name) {
  final index = name.hashCode.abs() % teamColors.length;
  return teamColors[index];
}

Widget ClubProfile({
  required BuildContext context,
  required ClubRoasterData team,
}) {
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
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xffE6E6E6)),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getColorFromName(team.name),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xffE6E6E6)),
          ),
          // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  getInitials(team.name),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              // const SizedBox(height: 5),
              Text(
                team.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 10,
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
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
