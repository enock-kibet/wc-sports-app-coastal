import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/common/utils/pull_to_refresh.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/models/products/frontend_checkout.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/data/services/upgrade_service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/features/app/blocs/media/media_bloc.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/dashboard/pages/home/widget/home_media.dart';
import 'package:sports_app/features/dashboard/pages/home/widget/previous_tiles.dart';
import 'package:sports_app/features/dashboard/pages/pages.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:sports_app/utils/dotted.dart';
import 'package:shimmer/shimmer.dart';

// import '../../../../data/services/notification_service.dart';
part 'widget/scheduled_tiles.dart';
part 'widget/total_quantity.dart';
part 'widget/ticket_purchase_bottom_sheet.dart';

enum _HomeScheduleCategory { today, tomorrow, thisWeek, future }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferencesAsync get asyncPrefs => SharedPreferencesAsync();
  late StripeBloc _stripeBloc;
  late MediaBloc _mediaBloc;
  late TextEditingController searchText;
  Map<String, dynamic>? user;
  bool loading = false;
  final FocusNode _focusNode = FocusNode();
  Timer? _searchDebounce;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AndroidInAppUpdates.checkAndUpdate(
          immediate: true); // or false for flexible
    });

    _stripeBloc = StripeBloc();
    _mediaBloc = MediaBloc()..add(MediaEvent.getHomeMedia());
    searchText = TextEditingController();

    super.initState();
    _focusNode.addListener(_handleFocusChange);
    context.read<MatchBloc>().add(const MatchEvent.matchstats());
    _registerForNotifications();
  }

  Future<void> _registerForNotifications() async {
    await asyncPrefs.getStringList("USERDATA");
    // await WCNotificationService.registerDevice(
    //     userID.toString(), uToken.toString());
    // WCNotificationService.listenForTokenRefresh(
    //     userID.toString(), uToken.toString());
  }

  Future<void> _refreshHomeData() {
    final bloc = context.read<MatchBloc>();
    return refreshBlocState<MatchState>(
      bloc: bloc,
      dispatch: () {
        bloc.add(const MatchEvent.matches());
        bloc.add(const MatchEvent.matchstats());
      },
      isLoading: (state) => state.status.isLoading,
    );
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      context.read<HideCubit>().reveal();
      return;
    }

    if (searchText.text.isEmpty) {
      context.read<HideCubit>().hide();
    }
  }

  void _handleSearchChanged(String value) {
    final query = value.trim();
    _searchDebounce?.cancel();

    if (query.isEmpty) {
      context.read<MatchBloc>().add(const MatchEvent.searchMatch(search: ''));
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.read<MatchBloc>().add(MatchEvent.searchMatch(search: query));
    });
  }

  Map<_HomeScheduleCategory, List<MatchType>> _categorizeSchedules(
    List<MatchType> matches,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final endOfWeek = today.add(Duration(days: 7 - today.weekday));

    final categorized = <_HomeScheduleCategory, List<MatchType>>{
      _HomeScheduleCategory.today: [],
      _HomeScheduleCategory.tomorrow: [],
      _HomeScheduleCategory.thisWeek: [],
      _HomeScheduleCategory.future: [],
    };

    for (final match in matches) {
      final matchDate = DateTime(
        match.matchDate.year,
        match.matchDate.month,
        match.matchDate.day,
      );

      if (matchDate == today) {
        categorized[_HomeScheduleCategory.today]!.add(match);
      } else if (matchDate == tomorrow) {
        categorized[_HomeScheduleCategory.tomorrow]!.add(match);
      } else if (matchDate.isAfter(tomorrow) && matchDate.isBefore(endOfWeek)) {
        categorized[_HomeScheduleCategory.thisWeek]!.add(match);
      } else if (matchDate.isAfter(endOfWeek)) {
        categorized[_HomeScheduleCategory.future]!.add(match);
      }
    }

    categorized.removeWhere((key, value) => value.isEmpty);
    return categorized;
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _stripeBloc.close();
    _mediaBloc.close();
    searchText.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HideCubit, bool>(builder: (context, reveal) {
      return Scaffold(
        body: AppBackground(
          childWidget: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMedium),
            child: Column(
              children: [
                const SizedBox(height: kMedium),
                headerSection(context),
                const SizedBox(height: kMedium),
                searchField(
                    controller: searchText,
                    focusNode: _focusNode,
                    onChanged: _handleSearchChanged),
                reveal ? Container() : const SizedBox(height: kMedium),
                reveal
                    ? Container()
                    : BlocProvider.value(
                        value: _mediaBloc,
                        child: const HomeMediaBanner(),
                      ),
                reveal ? Container() : const SizedBox(height: kMedium),
                reveal ? Container() : SizedBox(),
                Expanded(
                  child: BlocBuilder<MatchBloc, MatchState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case MatchStatus.loading:
                          return const _HomeMatchesSkeleton();
                        case MatchStatus.failure:
                          return RefreshIndicator.adaptive(
                            onRefresh: _refreshHomeData,
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 260,
                                  child: Center(
                                    child: Text(
                                      state.failure?.error ??
                                          "Unable to load matches right now.",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        case MatchStatus.success:
                          final visibleMatches =
                              reveal ? state.searchedMatches : state.matches;
                          final categorized =
                              _categorizeSchedules(visibleMatches);
                          final statsMatches = state.statsMatches;
                          final statsLoaded = state.statsLoaded;

                          if (!statsLoaded) {
                            return const _HomeMatchesSkeleton();
                          }

                          return RefreshIndicator.adaptive(
                            onRefresh: _refreshHomeData,
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                if (categorized.isNotEmpty) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1.0),
                                    child: Text(
                                      "Upcoming Matches",
                                      style: context.textTheme.headlineLarge
                                          ?.copyWith(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                  ...categorized.entries.map((entry) {
                                    String entryTitle = entry.key
                                        .toString()
                                        .split('.')
                                        .last
                                        .toTitleCase();
                                    if (entryTitle == 'Thisweek') {
                                      entryTitle = "This Week";
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 12),
                                          child: Text(
                                            entryTitle,
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.65),
                                            ),
                                          ),
                                        ),
                                        _buildUpcomingMatchesTiles(
                                          context,
                                          entry.value,
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                                if (statsMatches.isNotEmpty) ...[
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: Text(
                                      "Previous Matches",
                                      style: context.textTheme.headlineLarge
                                          ?.copyWith(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                  _buildPreviousMatchesTiles(
                                    context,
                                    statsMatches,
                                  ),
                                ],
                                if (categorized.isEmpty &&
                                    statsMatches.isEmpty &&
                                    statsLoaded)
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 40.0),
                                      child: Text(
                                        "No matches available",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );

                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }

  Widget _buildPreviousMatchesTiles(
    BuildContext context,
    List<MatchType> statsMatches,
  ) {
    final isIpad = _isIpadLayout(context);

    if (!isIpad) {
      return Column(
        children: statsMatches
            .map((match) => PreviousTiles(match: match))
            .toList(growable: false),
      );
    }

    return _buildIpadTwoColumnTileRows(
      statsMatches,
      (match) => PreviousTiles(match: match),
    );
  }

  Widget _buildUpcomingMatchesTiles(
    BuildContext context,
    List<MatchType> upcomingMatches,
  ) {
    final isIpad = _isIpadLayout(context);

    if (!isIpad) {
      return Column(
        children: upcomingMatches
            .map((match) => ScheduledTiles(match: match))
            .toList(growable: false),
      );
    }

    return _buildIpadTwoColumnTileRows(
      upcomingMatches,
      (match) => ScheduledTiles(match: match),
    );
  }

  Widget _buildIpadTwoColumnTileRows(
    List<MatchType> matches,
    Widget Function(MatchType match) tileBuilder,
  ) {
    final rowCount = (matches.length / 2).ceil();
    return Column(
      children: List.generate(rowCount, (rowIndex) {
        final leftIndex = rowIndex * 2;
        final rightIndex = leftIndex + 1;
        final isLastRow = rowIndex == rowCount - 1;

        return Padding(
          padding: EdgeInsets.only(bottom: isLastRow ? 0 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: tileBuilder(matches[leftIndex]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: rightIndex < matches.length
                    ? tileBuilder(matches[rightIndex])
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      }),
    );
  }

  bool _isIpadLayout(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS &&
        MediaQuery.of(context).size.shortestSide >= 600;
  }

  SingleChildScrollView schedules({required List<MatchType> matches}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocConsumer<StripeBloc, StripeState>(
        bloc: _stripeBloc,
        listener: (context, state) {
          switch (state.status) {
            case StripeStatus.success:
              print(state.stripe);
              // initPaymentSheet(
              //     context,
              //     StripeCheckout(
              //         paymentIntent: state.stripe!["paymentIntent"],
              //         ephemeralKey: state.stripe!["ephemralKey"],
              //         customer: state.stripe!["customer"],
              //         publishableKey: state.stripe!["publishableKey"]));

              break;
            default:
          }
        },
        builder: (context, state) {
          return Row(
            children: List.generate(matches.length, (index) {
              final match = matches[index];
              return Container(
                margin: const EdgeInsets.only(right: kSmall),
                padding: const EdgeInsets.all(kSmall),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(kSmall)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Next Game",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        Text(match.matchName, style: TextStyle(fontSize: 10)),
                        const SizedBox(height: kSmall),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 8,
                            ),
                            const SizedBox(width: kXSmall),
                            Text(match.teamOne)
                          ],
                        ),
                        const SizedBox(height: kSmall),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.purpleColor,
                              radius: 8,
                            ),
                            const SizedBox(width: kXSmall),
                            Text(match.teamTwo)
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: kLarge,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 1,
                          color: AppColors.greyColor,
                        ),
                        const SizedBox(
                          width: kSmall,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(getStringDate(match.matchDate),
                                style: TextStyle(fontSize: 10)),
                            Text(match.matchVenue,
                                style: const TextStyle(fontSize: 10)),
                            Text("Amount -ksh ${match.matchPrice}",
                                style: TextStyle(fontSize: 10)),
                            const SizedBox(
                              height: kSmall,
                            ),
                            GestureDetector(
                              onTap: () {
                                final isGuest = service<AppPreferencesManager>()
                                        .currentUserValue ==
                                    null;
                                if (isGuest) {
                                  context.go('/signIn');
                                  return;
                                }
                                _stripeBloc.add(const StripeEvent.stripe(
                                    email: "john@gmail.com", price: 500));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kMedium, vertical: kXSmall),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.pinkColor,
                                        AppColors.purpleColor
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(kMedium)),
                                child: Text("Buy Ticket",
                                    style:
                                        TextStyle(color: AppColors.whiteColor)),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Container banner() {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(kSmall)),
        child: Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(kMedium),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kSmall),
                    bottomLeft: Radius.circular(kSmall)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "30% Off Discount",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: AppColors.whiteColor),
                  ),
                  Text(
                    "All Merch!",
                    style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: kLarge, color: AppColors.whiteColor),
                  ),
                  Text(
                    "24 Feb - 04 May",
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: kSMedium,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(kSmall),
                    bottomRight: Radius.circular(kSmall)),
                color: AppColors.whiteColor,
                image: const DecorationImage(
                  image: AssetImage("assets/images/merch.png"),
                ),
              ),
              child: Image.asset("assets/images/merch.png"),
            )),
          ],
        ));
  }

  TextField searchField(
      {required onChanged, required focusNode, required controller}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.whiteColor : const Color(0xFFDADADA);
    final iconColor =
        isDark ? AppColors.whiteColor : Theme.of(context).colorScheme.onSurface;
    final fillColor =
        isDark ? AppColors.whiteColor.withOpacity(0.2) : Colors.white;

    return TextField(
        onChanged: onChanged,
        focusNode: focusNode,
        controller: controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: Container(
              padding: const EdgeInsets.only(right: kSmall),
              child: Icon(LucideIcons.search, color: iconColor)),
          fillColor: fillColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(kXXXXLarge)),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: kMedium, vertical: kXLMedium * 0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kXXXXLarge),
              borderSide: BorderSide(
                color: borderColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kXXXXLarge),
              borderSide: BorderSide(
                color: borderColor,
              )),
          hintText: "Search",
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: isDark ? const Color(0xffcfcdcd) : const Color(0xFF9A9A9A),
          ),
        ));
  }

  Row headerSection(BuildContext context) {
    final currentUser = service<AppPreferencesManager>().currentUserValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor =
        isDark ? AppColors.whiteColor.withOpacity(0.3) : Colors.white;
    final iconColor =
        isDark ? AppColors.whiteColor : Theme.of(context).colorScheme.onSurface;
    final titleColor =
        isDark ? AppColors.whiteColor : Theme.of(context).colorScheme.onSurface;
    final subtitleColor = isDark
        ? AppColors.whiteColor
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
            decoration: BoxDecoration(color: chipColor, shape: BoxShape.circle),
            child: Icon(
              LucideIcons.menu,
              color: iconColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hi ${truncateText(limit: 16, currentUser?.name ?? 'Guest')}",
                style: TextStyle(
                    color: titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            Text("Nairobi, Kenya",
                style: TextStyle(
                    color: subtitleColor,
                    fontSize: kMedium,
                    fontWeight: FontWeight.w400)),
          ],
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoute.notifications.name);
          },
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(color: chipColor, shape: BoxShape.circle),
            child: Icon(
              LucideIcons.bell,
              color: iconColor,
            ),
          ),
        )
      ],
    );
  }
}

class _HomeMatchesSkeleton extends StatelessWidget {
  const _HomeMatchesSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _SkeletonLine(width: 160, height: 22),
        SizedBox(height: 12),
        _SkeletonLine(width: 82, height: 12),
        SizedBox(height: 12),
        _MatchSkeletonCard(),
        _MatchSkeletonCard(),
        _MatchSkeletonCard(),
      ],
    );
  }
}

class _MatchSkeletonCard extends StatelessWidget {
  const _MatchSkeletonCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? Theme.of(context).colorScheme.surfaceContainerHighest
        : Theme.of(context).colorScheme.surface;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              _SkeletonBox(width: 33, height: 34, radius: 4),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonLine(width: 110, height: 10),
                    SizedBox(height: 8),
                    _SkeletonLine(width: double.infinity, height: 10),
                    SizedBox(height: 6),
                    _SkeletonLine(width: 170, height: 10),
                  ],
                ),
              ),
              SizedBox(width: 16),
              _SkeletonLine(width: 64, height: 10),
            ],
          ),
          SizedBox(height: 11),
          _SkeletonLine(width: double.infinity, height: 1),
          SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SkeletonTeamRow(width: 128),
                  SizedBox(height: 8),
                  _SkeletonTeamRow(width: 108),
                ],
              ),
              _SkeletonBox(width: 102, height: 48, radius: 12),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonTeamRow extends StatelessWidget {
  final double width;

  const _SkeletonTeamRow({required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _SkeletonBox(width: 20, height: 20, radius: 10),
        const SizedBox(width: kXSmall),
        _SkeletonLine(width: width, height: 12),
      ],
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonLine({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return _SkeletonBox(width: width, height: height, radius: height / 2);
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xff3e434b) : Colors.grey.shade300;
    final highlightColor =
        isDark ? const Color(0xff555b65) : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

RowIconButton(IconData icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon),
      SizedBox(
        width: kSMedium,
      ),
      Text(
        text,
        style: TextStyle(fontSize: 14),
      )
    ],
  );
}
