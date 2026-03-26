import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/models/stripe_checkout/stripe_checkout.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/data/services/upgrade_service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/features/app/blocs/matches/match_schedule/schedule_bloc.dart';
import 'package:sports_app/features/app/blocs/media/media_bloc.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/dashboard/pages/home/widget/home_media.dart';
import 'package:sports_app/features/dashboard/pages/pages.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:sports_app/utils/dotted.dart';

// import '../../../../data/services/notification_service.dart';
part 'widget/scheduled_tiles.dart';
part 'widget/previous_tiles.dart';
part 'widget/total_quantity.dart';
part 'widget/ticket_purchase_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferencesAsync get asyncPrefs => SharedPreferencesAsync();
  late StripeBloc _stripeBloc;
  late TextEditingController searchText;
  late HideCubit _hideCubit;
  Map<String, dynamic>? user;
  bool loading = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AndroidInAppUpdates.checkAndUpdate(
          immediate: true); // or false for flexible
    });

    _stripeBloc = StripeBloc();
    searchText = TextEditingController();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.read<HideCubit>().reveal();
      } else {
        if (searchText.text == "") {
          context.read<HideCubit>().hide();
        } else {}
      }
      //context.read<HideCubit>().reveal;
    });
    super.initState();
    context.read<MatchBloc>().add(const MatchEvent.matchstats());
    _registerForNotifications();
  }

  Future<void> _registerForNotifications() async {
    final userData = await asyncPrefs.getStringList("USERDATA");
    final uToken =
        userData != null && userData.length >= 6 ? userData[4] : null;
    final userID =
        userData != null && userData.length >= 6 ? userData[6] : null;
    // await WCNotificationService.registerDevice(
    //     userID.toString(), uToken.toString());
    // WCNotificationService.listenForTokenRefresh(
    //     userID.toString(), uToken.toString());
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
                    onChanged: (string) => context
                        .read<MatchBloc>()
                        .add(MatchEvent.searchMatch(search: searchText.text))),
                reveal ? Container() : const SizedBox(height: kMedium),
                reveal
                    ? Container()
                    : BlocProvider(
                        create: (context) =>
                            MediaBloc()..add(MediaEvent.getHomeMedia()),
                        child: const HomeMediaBanner(),
                      ),
                reveal ? Container() : const SizedBox(height: kMedium),
                reveal ? Container() : SizedBox(),
                Expanded(
                  child: BlocBuilder<MatchBloc, MatchState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case MatchStatus.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case MatchStatus.failure:
                          return Center(
                            child: Text(
                              state.failure?.error ??
                                  "Unable to load matches right now.",
                            ),
                          );
                        case MatchStatus.success:
                          context.read<ScheduleBloc>().add(LoadSchedules(
                              reveal ? state.searchedMatches : state.matches));

                          return BlocBuilder<ScheduleBloc, ScheduleState>(
                              builder: (context, scheduledMatches) {
                            if (scheduledMatches is ScheduleLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (scheduledMatches is ScheduleLoaded) {
                              final categorized =
                                  scheduledMatches.categorizedSchedulees;
                              final statsMatches =
                                  context.read<MatchBloc>().state.statsMatches;
                              final hasUpcomingMatches = categorized.isNotEmpty;

                              return ListView(
                                children: [
                                  // --- Upcoming Schedule ---
                                  if (categorized.isNotEmpty) ...[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 1.0),
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
                                          ...entry.value.map((match) =>
                                              ScheduledTiles(match: match)),
                                        ],
                                      );
                                    }),
                                  ],

                                  // --- Previous Matches ---
                                  if (!hasUpcomingMatches &&
                                      statsMatches.isNotEmpty) ...[
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
                                    ...statsMatches.map(
                                        (match) => PreviousTiles(match: match)),
                                  ],

                                  // --- If both are empty ---
                                  if (categorized.isEmpty &&
                                      statsMatches.isEmpty)
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 40.0),
                                        child: Text(
                                          "No matches available",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.7),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }
                            return (Container());
                          });

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
    final borderColor =
        isDark ? AppColors.whiteColor : const Color(0xFFDADADA);
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
          hintStyle: context.textTheme.bodyMedium
              ?.copyWith(
                color: isDark
                    ? const Color(0xffcfcdcd)
                    : const Color(0xFF9A9A9A),
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
            decoration: BoxDecoration(
                color: chipColor,
                shape: BoxShape.circle),
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
            decoration: BoxDecoration(
                color: chipColor,
                shape: BoxShape.circle),
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
