part of "player.dart";

class PlayerPage extends StatefulWidget {
  final RoasterData player; // ✅ updated from PlayerProfileData → RoasterData
  const PlayerPage({super.key, required this.player});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 1, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return Scaffold(
      body: AppBackground(
        childWidget: Stack(
          children: [
            SafeArea(
              child: RoundedtopContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    /// ✅ Top Navigation
                    TopNavigation(
                      back: () => context.pop(),
                      title: player.playerName,
                    ),

                    const SizedBox(height: 16),

                    /// ✅ Player image
                    PlayerProfilePicture(
                      player: player,
                    ),

                    const SizedBox(height: 8),

                    /// ✅ Basic Info
                    Text(
                      player.position,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${player.playerHeight} • ${player.playerWeight} • ${player.playerNumber}",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ✅ Tabs
                    PlayerTab(tabController: tabController),

                    /// ✅ Tab Content
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          /// Player Stats
                          ///
                          PlayerStats(
                            player: player,
                          ),

                          /// Player Info
                          PlayerInfo(player: player),

                          /// Media / Highlights
                          BlocProvider(
                            create: (context) => StatBloc()
                              ..add(StatEvent.getPlayerMedia(
                                  playerId: player.playerId)),
                            child: const PlayerMedia(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
