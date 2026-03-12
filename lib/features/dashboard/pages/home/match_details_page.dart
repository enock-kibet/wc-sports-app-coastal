import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/auth/auth_bloc.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/dashboard/pages/home/home.dart';
import 'package:sports_app/features/dashboard/pages/shop/shop_page.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/theme.dart';

import '../../../app/blocs/products/product_bloc.dart';

class MatchDetailsPage extends StatefulWidget {
  const MatchDetailsPage({super.key, required this.match});
  final MatchType match;

  @override
  State<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {
  SharedPreferencesAsync get asyncPrefs => SharedPreferencesAsync();
  final ValueNotifier<int> numberOfTickets = ValueNotifier(1);
  static const LatLng _fallbackLocation = LatLng(-1.3044, 36.8254);

  late PointsBloc _pointsBloc;
  bool _ownsPointsBloc = false;
  String? userID;

  @override
  void initState() {
    super.initState();
    try {
      _pointsBloc = context.read<PointsBloc>();
    } catch (_) {
      _pointsBloc = PointsBloc();
      _ownsPointsBloc = true;
    }
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await asyncPrefs.getStringList("USERDATA");
    if (mounted) {
      setState(() {
        userID =
            (userData != null && userData.length >= 6) ? userData[6] : null;
      });
    }
  }

  @override
  void dispose() {
    if (_ownsPointsBloc) {
      _pointsBloc.close();
    }
    numberOfTickets.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final venue = widget.match.recap?.venue;
    final venueLatLng = venue != null
        ? LatLng(venue.latitude, venue.longitude)
        : _fallbackLocation;

    return BlocConsumer<ProductBloc, ProductState>(
      bloc: context.read<ProductBloc>(),
      listener: (context, state) {
        if (state.status == ProductStatus.processingPayment) {
          SnackbarService.show(
            'Securing Payment',
            backgroundColor: AppColors.blackColor,
          );
        } else if (state.status == ProductStatus.successfulPayment) {
          context.goNamed(
            AppRoute.paymentWebView.name,
            extra: state.authorizationUrl,
          );
        } else if (state.status == ProductStatus.failure) {
          AnimatedOverlaySnackbar.show(
            context,
            "failed: ${state.failure?.error ?? "failed"}",
            color: AppColors.defaultAppRed,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: SafeArea(
            child: Container(
              width: double.infinity,
              height: 80,
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(
                  horizontal: kLarge, vertical: kSmall),
              child: Row(
                children: [
                  CustomIconButton(
                    size: 50,
                    isRoundedRectBorder: true,
                    iconColor: Theme.of(context).colorScheme.onSurface,
                    borderColor: Theme.of(context).colorScheme.onSurface,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onButtonPress: () {
                      final match = widget.match;

                      if (userID != null) {
                        final payload = {
                          "userId": userID ?? "",
                          "actionCode": "SHARED_TICKET",
                          "externalRef": match.matchId,
                        };
                        _pointsBloc.add(
                          PointsEvent.addPoints(request: payload),
                        );
                      }

                      final shareText = '''
          🎟️ ${match.matchName}
          📅 ${getStringDate(match.matchDate)} at ${formatTime(match.matchDate)}
          💸 Ticket Price: ${match.matchPrice}
          📍 Location: ${match.matchVenue}
          Get your tickets now from the Wence Sports app!
          https://play.google.com/store/apps/details?id=com.wtl.dvsavio''';

                      Share.share(shareText, subject: 'Check out this event!');
                    },
                    icon: Icons.share_outlined,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GradientFilledButton(
                      radius: 16,
                      onPressed: () async {
                        final currentUser =
                            service<AppPreferencesManager>().currentUserValue;
                        final userEmail = currentUser?.email;
                        if (userEmail == null || userEmail.isEmpty) {
                          if (context.mounted) {
                            context.go('/signIn');
                          }
                          return;
                        }

                        final bloc = _pointsBloc;

                        // Step 1: Trigger loading of points
                        bloc.add(const PointsEvent.points());

                        // Step 2: Wait for points to load (listen for success)
                        await Future.doWhile(() async {
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          final state = bloc.state;
                          return state.status == PointsStatus.loading;
                        });
                        if (!context.mounted) return;

                        final pointsState = bloc.state;

                        showTicketBottomSheet(
                          context,
                          (
                            TotalAmount:
                                widget.match.matchPrice * numberOfTickets.value,
                            quantity: numberOfTickets.value,
                          ),
                          buyMerch: (usedPoints) {
                            final int redeemablePoints = usedPoints;

                            context.read<ProductBloc>().add(
                                  ProductEvent.buyProducts(request: {
                                    "amount": widget.match.matchPrice *
                                        numberOfTickets.value,
                                    "email": userEmail,
                                    "productID":
                                        "20d802f0-1557-49a5-9fcf-7de02e570c57",
                                    "category": "",
                                    if (redeemablePoints > 0)
                                      "redeemablePoints": redeemablePoints,
                                  }),
                                );
                          },
                          match: widget.match,
                          pointsState: pointsState,
                        );
                      },
                      text: "Buy Ticket",
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: AppBackground(
            childWidget: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(36),
                              topLeft: Radius.circular(36),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: RandomImageUrl(),
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 48,
                                color: AppColors.whiteColor,
                              ),
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 20,
                            child: CustomIconButton(
                              onButtonPress: () => context.pop(),
                              size: 40,
                              borderColor: Colors.transparent,
                              iconColor: AppColors.whiteColor,
                              backgroundColor: Colors.black.withOpacity(.24),
                              icon: LucideIcons.arrowLeft,
                            ),
                          ),
                          Positioned(
                            right: 20,
                            top: 20,
                            child: CustomIconButton(
                              onButtonPress: () {},
                              size: 40,
                              borderColor: Colors.transparent,
                              iconColor: AppColors.whiteColor,
                              backgroundColor: Colors.black.withOpacity(.24),
                              icon: LucideIcons.bookmark,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.surface,
                        padding:
                            const EdgeInsets.symmetric(horizontal: kMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: AvatorInText(
                                fontsize: 13,
                                firstText:
                                    getStringDate(widget.match.matchDate),
                                secondText: formatTime(widget.match.matchDate),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.match.matchName,
                              style: const TextStyle(
                                fontSize: kLarge,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Description",
                              style: TextStyle(
                                height: 1.4,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.match.matchDescription,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.7,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ValueListenableBuilder(
                              valueListenable: numberOfTickets,
                              builder: (context, value, _) {
                                return TotalAndQuantity(
                                  add: () => numberOfTickets.value = value + 1,
                                  amount: widget.match.matchPrice * value,
                                  quantity: value,
                                  subtract: () => numberOfTickets.value =
                                      value > 1 ? value - 1 : 1,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Maps",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: kSmall),
                            if (venue != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                venue.location,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                            Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(kMedium),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(kMedium),
                                child: FlutterMap(
                                  options: MapOptions(
                                    initialCenter: venueLatLng,
                                    initialZoom: 16,
                                    interactionOptions:
                                        const InteractionOptions(
                                      flags: InteractiveFlag.drag |
                                          InteractiveFlag.pinchZoom |
                                          InteractiveFlag.doubleTapZoom,
                                    ),
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.wtl.dvsavio',
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: venueLatLng,
                                          width: 44,
                                          height: 44,
                                          child: Icon(
                                            Icons.location_on,
                                            size: 40,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: kLarge),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String formatTime(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime);
}
