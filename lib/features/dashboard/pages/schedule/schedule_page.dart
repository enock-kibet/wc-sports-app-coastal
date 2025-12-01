import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/router/router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/features/app/blocs/matches/match_schedule/schedule_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
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
    return DateFormat('d MMM yyyy').format(dt); // e.g., 14 Sep 2025
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

    // 👇 Trigger MatchBloc load after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final focusedDay = DateTime.now();
      context.read<MatchBloc>().add(MatchEvent.monthMatches(month: focusedDay));
    });
  }

  @override
  void dispose() {
    _stripeBloc.close();
    _focusNode.removeListener(() {});
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
                    horizontal: kSmall, vertical: kLarge),
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
                              _selectedDay = null; // reset selection
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
                            leftChevronIcon: Icon(Icons.chevron_left,
                                color: Theme.of(context).colorScheme.onSurface),
                            rightChevronIcon: Icon(Icons.chevron_right,
                                color: Theme.of(context).colorScheme.onSurface),
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
                              // find if this day has a match
                              final matches = context
                                  .read<MatchBloc>()
                                  .state
                                  .monthMatches
                                  .where((m) => isSameDay(m.matchDate, day))
                                  .toList();

                              if (matches.isNotEmpty) {
                                final match = matches
                                    .first; // handle one match per day for now
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
                                                  .onSurface),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          match
                                              .matchName, // e.g. "@ LAL" or "vs POR"
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Text(
                                        //   DateFormat("h:mm a")
                                        //       .format(match.matchDate),
                                        //   style: const TextStyle(
                                        //       fontSize: 9,
                                        //       fontWeight: FontWeight.w400,
                                        //       color: Theme.of(context).colorScheme.onSurface),
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              // otherwise: empty box with just the date in the corner
                              return Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(2)),
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
                              // show matches for the selected day
                              context.read<MatchBloc>().add(
                                  MatchEvent.datedMatch(date: selectedDay));
                            } else {
                              // fallback to full month matches
                              context.read<MatchBloc>().add(
                                  MatchEvent.monthMatches(month: focusedDay));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // const SizedBox(height: 5),

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

                      print(_usedFutureFallback);
                      // print(state.matches);

                      if (state.monthMatches.isEmpty) {
                        if (isCurrentMonth && !_usedFutureFallback) {
                          // ⭐ EDIT: Use fallback only once
                          matchesToShow = state.matches;
                        } else {
                          // ⭐ EDIT: No fallback on other months
                          matchesToShow = [];
                        }
                      } else {
                        matchesToShow = state.monthMatches;
                      }
                    } else {
                      // Day view (never fallback)
                      matchesToShow = state.datedMatches;
                    }

                    if (matchesToShow.isEmpty) {
                      final message = _selectedDay == null
                          ? "No schedules found for this month"
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
                            child: const Text(
                              "Upcoming Matches",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: matchesToShow.length,
                              itemBuilder: (context, index) {
                                final match = matchesToShow[index];
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
                                      Text(match.matchName,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: kSmall),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              size: kSMedium),
                                          const SizedBox(width: kXSmall),
                                          Text(match.matchVenue,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300)),
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
                                                            FontWeight.w700)),
                                          ),
                                          Text("Ksh ${match.matchPrice}",
                                              style: context
                                                  .textTheme.titleLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700)),
                                        ],
                                      ),
                                      const SizedBox(height: kLarge),
                                      if (match.matchDate
                                          .isAfter(DateTime.now()))
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                context.pushNamed(
                                                    AppRoute.matchDetails.name,
                                                    extra: match);
                                              },
                                              icon: Icon(LucideIcons.bookmark,
                                                  color: AppColors.purpleColor),
                                            ),
                                            const SizedBox(width: kLarge * 3),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.pushNamed(
                                                      AppRoute
                                                          .matchDetails.name,
                                                      extra: match);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  height: 50,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: kMedium,
                                                      vertical: kXSmall),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AppColors.pinkColor,
                                                          AppColors.purpleColor
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              kMedium)),
                                                  child: Text("Buy Ticket",
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface)),
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
      )),
    );
  }

  Row headerSection(BuildContext context) {
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
                color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
            child: const Icon(
              LucideIcons.menu,
              color: Colors.white,
            ),
          ),
        ),
        const Column(
          children: [
            Text(
              'Team Schedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'All Upcoming Matches',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.pushNamed(AppRoute.notifications.name),
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.bell, color: Colors.white),
          ),
        )
      ],
    );
  }
}
