part of "team.dart";

class LeaguePage extends StatefulWidget {
  final bool showBackNavigation;

  const LeaguePage({super.key, this.showBackNavigation = false});

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(initialIndex: 2, length: 3, vsync: this);
    super.initState();
    context.read<MatchBloc>().add(const MatchEvent.matchstats());
  }

  @override
  void dispose() {
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
                      "League",
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
                            text: 'TEAMS',
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
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => ClubRoastersBloc()
                                  ..add(const ClubRoasterEvent.roasters()),
                              ),
                              BlocProvider(create: (_) => RoasterBloc()),
                            ],
                            child: const LeagueRoaster(),
                          ),
                          TeamStats(),
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
              widget.showBackNavigation
                  ? Positioned(top: 20, left: 20, child: const AppBackButton())
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
