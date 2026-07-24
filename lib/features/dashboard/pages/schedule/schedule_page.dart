import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/dashboard/pages/home/widget/previous_tiles.dart';
import 'package:sports_app/router/router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/utils/pull_to_refresh.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/features/dashboard/widgets/upcoming_match_tile.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, this.clubId});

  final String? clubId;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late StripeBloc _stripeBloc;

  final FocusNode _focusNode = FocusNode();
  final TextEditingController searchText = TextEditingController();

  // If you still want a fallback, keep this. Otherwise you can remove it.
  bool _usedFutureFallback = false;

  String getStringDate(dynamic value) {
    late final DateTime dt;
    if (value is DateTime) {
      dt = value;
    } else if (value is String) {
      dt = DateTime.tryParse(value) ?? DateTime.now();
    } else {
      throw ArgumentError('Unsupported date type for getStringDate: $value');
    }
    return DateFormat('d MMM yyyy').format(dt);
  }

  DateTime _startOfToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Upcoming = today or future (local time)
  bool _isUpcoming(DateTime d) {
    final local = d.toLocal();
    return !local.isBefore(_startOfToday());
  }

  List<MatchType> _combinedMatches(MatchState state) {
    final matchesById = <String, MatchType>{};

    for (final match in state.matches) {
      matchesById[match.matchId] = match;
    }

    for (final match in state.statsMatches) {
      matchesById[match.matchId] = match;
    }

    return matchesById.values.toList();
  }

  bool _isSameMonth(DateTime month, DateTime dateToCompare) {
    final local = dateToCompare.toLocal();
    return month.year == local.year && month.month == local.month;
  }

  void _handleBuyTicketTap(MatchType match) {
    final isGuest = service<AppPreferencesManager>().currentUserValue == null;
    if (isGuest) {
      context.go('/signIn');
      return;
    }
    context.pushNamed(
      AppRoute.matchDetails.name,
      extra: match,
    );
  }

  void _openMatchDetails(MatchType match) {
    final isGuest = service<AppPreferencesManager>().currentUserValue == null;
    if (isGuest) {
      context.go('/signIn');
      return;
    }

    context.pushNamed(
      AppRoute.matchDetails.name,
      extra: match,
    );
  }

  Future<void> _refreshScheduleData() {
    final bloc = context.read<MatchBloc>();
    _usedFutureFallback = false;
    return refreshBlocState<MatchState>(
      bloc: bloc,
      dispatch: () {
        bloc.add(MatchEvent.matches(clubId: widget.clubId));
        bloc.add(MatchEvent.matchstats(clubId: widget.clubId));
        bloc.add(MatchEvent.monthMatches(month: _focusedDay));
      },
      isLoading: (state) => state.status.isLoading,
    );
  }

  @override
  void initState() {
    _stripeBloc = StripeBloc();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.read<HideCubit>().reveal();
      } else {
        if (searchText.text == "") {
          context.read<HideCubit>().hide();
        }
      }
    });

    super.initState();

    // Trigger month load after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final focusedDay = DateTime.now();
      context.read<MatchBloc>().add(MatchEvent.matches(clubId: widget.clubId));
      context
          .read<MatchBloc>()
          .add(MatchEvent.matchstats(clubId: widget.clubId));
      context.read<MatchBloc>().add(MatchEvent.monthMatches(month: focusedDay));
    });
  }

  @override
  void dispose() {
    _stripeBloc.close();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    service<Talker>().info(getStringDate(DateTime.now()));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final pageTextColor = isDark ? Colors.white : colorScheme.onSurface;
    final calendarBorderColor = isDark ? Colors.white24 : Colors.black26;
    final todayForegroundColor =
        isDark ? colorScheme.onSurface : const Color(0xFF5F4A00);
    final matchState = context.watch<MatchBloc>().state;

    return Scaffold(
      body: AppBackground(
        childWidget: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kMedium),
            child: Column(
              children: [
                const SizedBox(height: kMedium),
                headerSection(context),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSmall,
                    vertical: kLarge,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kMedium),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Calendar Grid
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kMedium),
                            color: colorScheme.surface,
                          ),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: _focusedDay,
                            onPageChanged: (focusedDay) {
                              setState(() {
                                _focusedDay = focusedDay;
                                _selectedDay = null;
                              });

                              context.read<MatchBloc>().add(
                                    MatchEvent.monthMatches(month: focusedDay),
                                  );
                            },
                            selectedDayPredicate: (day) =>
                                isSameDay(_selectedDay, day),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: colorScheme.onSurface,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: colorScheme.onSurface,
                              ),
                              titleTextStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                            ),
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: false,
                              defaultTextStyle: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              weekendTextStyle: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              selectedTextStyle: TextStyle(
                                color: todayForegroundColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                              todayTextStyle: TextStyle(
                                color: todayForegroundColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              todayDecoration: BoxDecoration(
                                color:
                                    colorScheme.primary.withValues(alpha: 0.35),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                color: colorScheme.onSurface,
                              ),
                              weekendStyle: TextStyle(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, focusedDay) {
                                // show markers from monthMatches (which should already be upcoming if you updated the Bloc)
                                final matches = _combinedMatches(matchState)
                                    .where((m) => isSameDay(m.matchDate, day))
                                    .toList();

                                if (matches.isNotEmpty) {
                                  final match = matches.first;
                                  final isHome =
                                      match.matchVenue.contains("Home");
                                  return Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: isHome
                                          ? Colors.yellow[700]
                                          : const Color(0xFFD50B36),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${day.day}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: isHome
                                                  ? const Color(0xFF1B1F28)
                                                  : Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            match.matchName,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: isHome
                                                  ? const Color(0xFF1B1F28)
                                                  : Colors.white,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: calendarBorderColor),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });

                              context.read<MatchBloc>().add(
                                    MatchEvent.datedMatch(date: selectedDay),
                                  );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// Match List
                Expanded(
                  child: BlocBuilder<MatchBloc, MatchState>(
                    builder: (context, state) {
                      if (state.status == MatchStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == MatchStatus.failure) {
                        service<Talker>().error(state.failure!.error);
                        return RefreshIndicator.adaptive(
                          onRefresh: _refreshScheduleData,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 220,
                                child:
                                    Center(child: Text(state.failure!.error)),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state.status == MatchStatus.success) {
                        final allMatches = _combinedMatches(state);
                        List<MatchType> matchesToShow;

                        if (_selectedDay == null) {
                          final isCurrentMonth =
                              _focusedDay.month == DateTime.now().month &&
                                  _focusedDay.year == DateTime.now().year;

                          final monthMatches = allMatches
                              .where((match) =>
                                  _isSameMonth(_focusedDay, match.matchDate))
                              .toList();

                          if (monthMatches.isEmpty) {
                            if (isCurrentMonth && !_usedFutureFallback) {
                              matchesToShow = allMatches;
                              _usedFutureFallback = true;
                            } else {
                              matchesToShow = [];
                            }
                          } else {
                            matchesToShow = monthMatches;
                          }
                        } else {
                          matchesToShow = allMatches
                              .where((match) => isSameDay(
                                    match.matchDate,
                                    _selectedDay,
                                  ))
                              .toList();
                        }

                        final listMatches = (_selectedDay == null)
                            ? List<MatchType>.from(matchesToShow)
                            : List<MatchType>.from(matchesToShow);

                        listMatches
                            .sort((a, b) => a.matchDate.compareTo(b.matchDate));

                        const title = "Matches";

                        if (listMatches.isEmpty) {
                          final message = _selectedDay == null
                              ? "No matches found for this month"
                              : "No schedules found for this date";

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: kLarge),
                            child: RefreshIndicator.adaptive(
                              onRefresh: _refreshScheduleData,
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: 220,
                                    child: Center(
                                      child: Text(
                                        message,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: pageTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: pageTextColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: RefreshIndicator.adaptive(
                                onRefresh: _refreshScheduleData,
                                child: _isIpadLayout(context)
                                    ? _buildIpadTwoColumnScheduleList(
                                        context,
                                        listMatches,
                                      )
                                    : ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: listMatches.length,
                                        itemBuilder: (context, index) =>
                                            _buildScheduleMatchTile(
                                          context,
                                          listMatches[index],
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIpadTwoColumnScheduleList(
    BuildContext context,
    List<MatchType> matches,
  ) {
    final rowCount = (matches.length / 2).ceil();

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(kSmall),
      itemCount: rowCount,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, rowIndex) {
        final leftIndex = rowIndex * 2;
        final rightIndex = leftIndex + 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildScheduleMatchTile(
                context,
                matches[leftIndex],
                useOuterMargin: false,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: rightIndex < matches.length
                  ? _buildScheduleMatchTile(
                      context,
                      matches[rightIndex],
                      useOuterMargin: false,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildScheduleMatchTile(
    BuildContext context,
    MatchType match, {
    bool useOuterMargin = true,
  }) {
    if (!_isUpcoming(match.matchDate)) {
      final previous = PreviousTiles(match: match);
      if (!useOuterMargin) return previous;

      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kSmall,
          vertical: kSmall,
        ),
        child: previous,
      );
    }

    return UpcomingMatchTile(
      match: match,
      onTap: () => _openMatchDetails(match),
      onBuyTicketTap: () => _handleBuyTicketTap(match),
      margin: useOuterMargin
          ? const EdgeInsets.symmetric(horizontal: kSmall, vertical: kSmall)
          : EdgeInsets.zero,
    );
  }

  bool _isIpadLayout(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS &&
        MediaQuery.of(context).size.shortestSide >= 600;
  }

  Row headerSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor =
        isDark ? Colors.white.withValues(alpha: 0.3) : Colors.white;
    final iconColor =
        isDark ? Colors.white : Theme.of(context).colorScheme.onSurface;
    final titleColor =
        isDark ? Colors.white : Theme.of(context).colorScheme.onSurface;
    final subtitleColor = isDark
        ? Colors.white70
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.read<SideMenuCubit>().openDrawer();
          },
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
              color: chipColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.menu,
              color: iconColor,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Team Schedule',
              style: TextStyle(
                color: titleColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'All Upcoming Matches',
              style: TextStyle(color: subtitleColor, fontSize: 12),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.pushNamed(AppRoute.notifications.name),
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
              color: chipColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.bell,
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
