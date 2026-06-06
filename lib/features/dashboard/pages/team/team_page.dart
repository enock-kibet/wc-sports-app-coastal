part of "team.dart";

class TeamPage extends StatefulWidget {
  final bool showBackNavigation;
  final ClubRoasterData? selectedClub;

  const TeamPage({
    super.key,
    this.showBackNavigation = false,
    this.selectedClub,
  });

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> with TickerProviderStateMixin {
  late TabController tabController;
  int _statsRefreshTick = 0;

  @override
  void initState() {
    tabController = TabController(initialIndex: 2, length: 3, vsync: this);
    super.initState();
    tabController.addListener(_handleTabChange);
    context.read<MatchBloc>().add(
          MatchEvent.matchstats(clubId: widget.selectedClub?.id),
        );
  }

  void _handleTabChange() {
    if (tabController.indexIsChanging || tabController.index != 1) return;

    context.read<MatchBloc>().add(
          MatchEvent.matchstats(clubId: widget.selectedClub?.id),
        );
    setState(() {
      _statsRefreshTick++;
    });
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        childWidget: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: kSMedium),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 39,
                    ),
                    Text(
                      widget.selectedClub?.name ?? "League",
                      style: context.textTheme.headlineLarge
                          ?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TabBar(
                        dividerColor: Theme.of(context).colorScheme.onSurface,
                        unselectedLabelStyle: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: 1),
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                width: 4,
                                color: Theme.of(context).colorScheme.onSurface),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(3),
                                topRight: Radius.circular(3))),
                        labelStyle: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: 1),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: widget.selectedClub == null
                                ? 'TEAMS'
                                : 'ROSTER',
                          ),
                          Tab(
                            text: 'STATS',
                          ),
                          Tab(text: 'STANDINGS'),
                        ]),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          widget.selectedClub == null
                              ? MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (_) => ClubRoastersBloc()
                                        ..add(
                                            const ClubRoasterEvent.roasters()),
                                    ),
                                    BlocProvider(create: (_) => RoasterBloc()),
                                  ],
                                  child: const LeagueRoaster(),
                                )
                              : BlocProvider(
                                  create: (_) => RoasterBloc()
                                    ..add(RoasterEvent.roasters(
                                      widget.selectedClub!.id,
                                    )),
                                  child: TeamRoster(
                                    clubId: widget.selectedClub!.id,
                                  ),
                                ),
                          TeamStats(
                            key: ValueKey(
                              '${widget.selectedClub?.id ?? "league"}-$_statsRefreshTick',
                            ),
                            selectedClubId: widget.selectedClub?.id,
                          ),
                          BlocProvider(
                            create: (_) => TeamStatsBloc()
                              ..add(const TeamStatsEvent.standings()),
                            child: const TeamStandings(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: AppBackButton(
                  onPressed: widget.showBackNavigation
                      ? null
                      : () => context.go('/home'),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: _TeamNotificationButton(
                  onPressed: () =>
                      context.pushNamed(AppRoute.notifications.name),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamNotificationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _TeamNotificationButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? Colors.white.withValues(alpha: 0.3) : Colors.white;
    final iconColor = isDark ? Colors.white : colorScheme.onSurface;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(kSmall),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          LucideIcons.bell,
          color: iconColor,
        ),
      ),
    );
  }
}
