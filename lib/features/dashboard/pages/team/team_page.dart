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
  ClubRoasterData? _resolvedSelectedClub;
  bool _isResolvingDefaultClub = false;
  int _statsRefreshTick = 0;

  ClubRoasterData? get _effectiveSelectedClub =>
      widget.selectedClub ?? _resolvedSelectedClub;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: widget.selectedClub == null ? 2 : 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(_handleTabChange);
    final selectedClub = _effectiveSelectedClub;
    context.read<MatchBloc>().add(
          MatchEvent.matchstats(clubId: selectedClub?.id),
        );
    if (widget.selectedClub == null) {
      _resolveDefaultClub();
    }
  }

  void _handleTabChange() {
    if (tabController.indexIsChanging || tabController.index != 1) return;

    final selectedClub = _effectiveSelectedClub;
    context.read<MatchBloc>().add(
          MatchEvent.matchstats(clubId: selectedClub?.id),
        );
    setState(() {
      _statsRefreshTick++;
    });
  }

  Future<void> _resolveDefaultClub() async {
    final contextData = service<AppPreferencesManager>().currentContextValue;
    final normalizedBrandName = _normalizeSearchKey(
      contextData?.brandingName ?? contextData?.resolvedBrandName,
    );
    final normalizedLeagueId = _normalizeValue(contextData?.activeLeagueId);

    if (normalizedBrandName == null && normalizedLeagueId == null) {
      return;
    }

    setState(() {
      _isResolvingDefaultClub = true;
    });

    ClubRoasterData? resolvedClub;
    final result = await service<RoasterService>().getLeagueRoasters();
    await result.when(
      onError: (_) async {},
      onSuccess: (clubs) async {
        resolvedClub = _findDefaultClub(
          clubs: clubs,
          normalizedBrandName: normalizedBrandName,
          normalizedLeagueId: normalizedLeagueId,
        );
      },
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _resolvedSelectedClub = resolvedClub;
      _isResolvingDefaultClub = false;
    });

    if (resolvedClub != null) {
      context.read<MatchBloc>().add(
            MatchEvent.matchstats(clubId: resolvedClub!.id),
          );
      if (tabController.index != 0) {
        tabController.animateTo(0);
      }
    }
  }

  ClubRoasterData? _findDefaultClub({
    required List<ClubRoasterData> clubs,
    required String? normalizedBrandName,
    required String? normalizedLeagueId,
  }) {
    if (clubs.isEmpty) {
      return null;
    }

    var prioritizedClubs = clubs;
    if (normalizedLeagueId != null) {
      final sameLeague = clubs
          .where(
            (club) => _normalizeValue(club.leagueId) == normalizedLeagueId,
          )
          .toList();
      if (sameLeague.isNotEmpty) {
        prioritizedClubs = sameLeague;
      }
    }

    if (normalizedBrandName != null) {
      for (final club in prioritizedClubs) {
        if (_normalizeSearchKey(club.name) == normalizedBrandName) {
          return club;
        }
      }

      for (final club in prioritizedClubs) {
        final normalizedClubName = _normalizeSearchKey(club.name);
        if (normalizedClubName == null) {
          continue;
        }
        if (normalizedClubName.contains(normalizedBrandName) ||
            normalizedBrandName.contains(normalizedClubName)) {
          return club;
        }
      }
    }

    return prioritizedClubs.length == 1 ? prioritizedClubs.first : null;
  }

  String? _normalizeValue(String? value) {
    if (value == null) {
      return null;
    }

    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed.toLowerCase();
  }

  String? _normalizeSearchKey(String? value) {
    final normalizedValue = _normalizeValue(value);
    if (normalizedValue == null) {
      return null;
    }

    final compact = normalizedValue.replaceAll(RegExp(r'[^a-z0-9]'), '');
    return compact.isEmpty ? null : compact;
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedClub = _effectiveSelectedClub;

    if (_isResolvingDefaultClub && selectedClub == null) {
      return const Scaffold(
        body: AppBackground(
          childWidget: SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

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
                      selectedClub?.name ?? "Team",
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
                            text: selectedClub == null ? 'TEAMS' : 'ROSTER',
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
                          selectedClub == null
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
                                      selectedClub.id,
                                    )),
                                  child: TeamRoster(
                                    clubId: selectedClub.id,
                                  ),
                                ),
                          TeamStats(
                            key: ValueKey(
                              '${selectedClub?.id ?? "league"}-$_statsRefreshTick',
                            ),
                            selectedClubId: selectedClub?.id,
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
