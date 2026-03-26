import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/router/router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

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
                            color: Theme.of(context).colorScheme.surface,
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
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              titleTextStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: false,
                              selectedDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              todayDecoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              weekendStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, focusedDay) {
                                // show markers from monthMatches (which should already be upcoming if you updated the Bloc)
                                final matches = context
                                    .read<MatchBloc>()
                                    .state
                                    .monthMatches
                                    .where((m) => isSameDay(m.matchDate, day))
                                    .toList();

                                if (matches.isNotEmpty) {
                                  final match = matches.first;
                                  return Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: match.matchVenue.contains("Home")
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
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            match.matchName,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
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
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
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

                              if (selectedDay != null) {
                                context.read<MatchBloc>().add(
                                      MatchEvent.datedMatch(date: selectedDay),
                                    );
                              } else {
                                context.read<MatchBloc>().add(
                                      MatchEvent.monthMatches(
                                          month: focusedDay),
                                    );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// Match List
                BlocBuilder<MatchBloc, MatchState>(
                  builder: (context, state) {
                    if (state.status == MatchStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == MatchStatus.failure) {
                      service<Talker>().error(state.failure!.error);
                      return Center(child: Text(state.failure!.error));
                    }

                    if (state.status == MatchStatus.success) {
                      List<MatchType> matchesToShow;

                      if (_selectedDay == null) {
                        final isCurrentMonth =
                            _focusedDay.month == DateTime.now().month &&
                                _focusedDay.year == DateTime.now().year;

                        if (state.monthMatches.isEmpty) {
                          if (isCurrentMonth && !_usedFutureFallback) {
                            // Fallback (raw matches)
                            matchesToShow = state.matches;
                            _usedFutureFallback = true;
                          } else {
                            matchesToShow = [];
                          }
                        } else {
                          // monthMatches should be ALL month matches (past + future) for calendar markers
                          matchesToShow = state.monthMatches;
                        }
                      } else {
                        // Day view -> show all matches for that day (past allowed)
                        matchesToShow = state.datedMatches;
                      }

                      // ✅ LIST FILTER RULE:
                      // - No selected day => Upcoming only
                      // - Selected day => Show all (past allowed)
                      // final listMatches = (_selectedDay == null)
                      //     ? matchesToShow.where((m) => _isUpcoming(m.matchDate)).toList()
                      //     : List<MatchType>.from(matchesToShow);

                      final listMatches = (_selectedDay == null)
                          // ✅ Month view: show ALL matches for that month (past + future)
                          ? List<MatchType>.from(matchesToShow)
                          // ✅ Day view: show ALL matches for that day (past + future)
                          : List<MatchType>.from(matchesToShow);

                      listMatches
                          .sort((a, b) => a.matchDate.compareTo(b.matchDate));

                      String title;

                      final now = DateTime.now();
                      final isPastMonth = _focusedDay.year < now.year ||
                          (_focusedDay.year == now.year &&
                              _focusedDay.month < now.month);

                      if (_selectedDay != null) {
                        title = "Matches";
                      } else if (isPastMonth) {
                        title = "Matches";
                      } else {
                        title = "Upcoming Matches";
                      }

                      if (listMatches.isEmpty) {
                        final message = _selectedDay == null
                            ? "No upcoming schedules found for this month"
                            : "No schedules found for this date";

                        return Padding(
                          padding: const EdgeInsets.all(kLarge),
                          child: Text(
                            message,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                title,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: listMatches.length,
                                itemBuilder: (context, index) {
                                  final match = listMatches[index];

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: kSmall, vertical: kSmall),
                                    padding: const EdgeInsets.all(kMedium),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(kMedium),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          match.matchName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: kSmall),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on,
                                                size: kSMedium),
                                            const SizedBox(width: kXSmall),
                                            Text(
                                              match.matchVenue,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: kMedium),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(kSmall),
                                              decoration: BoxDecoration(
                                                color: AppColors.greyColor
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kMedium),
                                              ),
                                              child: Text(
                                                getStringDate(match.matchDate),
                                                style: context
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ),
                                            Text(
                                              "Ksh ${match.matchPrice}",
                                              style: context
                                                  .textTheme.titleLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: kLarge),

                                        // ✅ Buttons:
                                        // - In month view: only show for upcoming matches
                                        // - In day view: still only show for upcoming matches
                                        if (_isUpcoming(match.matchDate))
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  // context.pushNamed(
                                                  //   AppRoute.matchDetails.name,
                                                  //   extra: match,
                                                  // );
                                                },
                                                icon: Icon(
                                                  LucideIcons.bookmark,
                                                  color: AppColors.purpleColor,
                                                ),
                                              ),
                                              const SizedBox(width: kLarge * 3),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _handleBuyTicketTap(match);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: kMedium,
                                                      vertical: kXSmall,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AppColors.pinkColor,
                                                          AppColors.purpleColor,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              kMedium),
                                                    ),
                                                    child: Text(
                                                      "Buy Ticket",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
