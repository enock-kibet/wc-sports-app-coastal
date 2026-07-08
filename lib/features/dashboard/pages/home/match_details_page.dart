import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/dashboard/pages/home/home.dart';
import 'package:sports_app/features/dashboard/pages/shared/frontend_checkout_flow.dart';
import 'package:sports_app/features/dashboard/pages/shop/shop_page.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/theme/theme.dart';

import '../../../app/blocs/products/product_bloc.dart';

class MatchDetailsPage extends StatefulWidget {
  const MatchDetailsPage({super.key, required this.match});
  final MatchType match;

  @override
  State<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {
  final ValueNotifier<int> numberOfTickets = ValueNotifier(1);
  static const LatLng _fallbackLocation = LatLng(-1.3044, 36.8254);

  late PointsBloc _pointsBloc;
  bool _ownsPointsBloc = false;
  bool _ticketTypesLoading = true;
  String? _ticketTypesError;
  List<Map<String, dynamic>> _ticketTypes = const [];
  String? _selectedTicketTypeId;

  @override
  void initState() {
    super.initState();
    try {
      _pointsBloc = context.read<PointsBloc>();
    } catch (_) {
      _pointsBloc = PointsBloc();
      _ownsPointsBloc = true;
    }
    _loadTicketTypes();
  }

  @override
  void dispose() {
    if (_ownsPointsBloc) {
      _pointsBloc.close();
    }
    numberOfTickets.dispose();
    super.dispose();
  }

  Future<void> _loadTicketTypes() async {
    setState(() {
      _ticketTypesLoading = true;
      _ticketTypesError = null;
    });

    final response = await service<ProductService>()
        .getAvailableTicketTypes(widget.match.matchId);

    if (!mounted) return;

    response.when(
      onError: (error) {
        setState(() {
          _ticketTypesLoading = false;
          _ticketTypesError = error.error;
          _ticketTypes = const [];
          _selectedTicketTypeId = null;
        });
      },
      onSuccess: (ticketTypes) {
        setState(() {
          _ticketTypesLoading = false;
          _ticketTypes = ticketTypes;
          _selectedTicketTypeId = _pickTicketTypeId(ticketTypes.first);
        });
        _clampTicketQuantityToSelection();
      },
    );
  }

  Map<String, dynamic>? get _selectedTicketType {
    for (final ticketType in _ticketTypes) {
      if (_pickTicketTypeId(ticketType) == _selectedTicketTypeId) {
        return ticketType;
      }
    }
    return _ticketTypes.isNotEmpty ? _ticketTypes.first : null;
  }

  String _pickTicketTypeId(Map<String, dynamic> ticketType) {
    return (ticketType['id'] ?? '').toString().trim();
  }

  String _ticketTypeName(Map<String, dynamic> ticketType) {
    final candidates = [
      ticketType['name'],
      ticketType['ticket_name'],
      ticketType['label'],
      ticketType['code'],
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }

    return 'Ticket';
  }

  String? _ticketTypeDescription(Map<String, dynamic> ticketType) {
    final candidates = [
      ticketType['description'],
      ticketType['notes'],
      ticketType['details'],
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }

    return null;
  }

  double _ticketTypePrice(Map<String, dynamic>? ticketType) {
    final rawPrice = ticketType?['price'];
    if (rawPrice is num) return rawPrice.toDouble();
    return double.tryParse(rawPrice?.toString() ?? '') ??
        widget.match.matchPrice;
  }

  int _ticketTypeMaxPerOrder(Map<String, dynamic>? ticketType) {
    final rawValue = ticketType?['max_per_order'];
    if (rawValue is num) return rawValue.toInt();
    return int.tryParse(rawValue?.toString() ?? '') ?? 0;
  }

  int? _ticketTypeRemainingQty(Map<String, dynamic> ticketType) {
    final rawValue = ticketType['remaining_quantity'];
    if (rawValue == null) return null;
    if (rawValue is num) return rawValue.toInt();
    return int.tryParse(rawValue.toString());
  }

  void _selectTicketType(Map<String, dynamic> ticketType) {
    setState(() {
      _selectedTicketTypeId = _pickTicketTypeId(ticketType);
    });
    _clampTicketQuantityToSelection();
  }

  void _clampTicketQuantityToSelection() {
    final maxPerOrder = _ticketTypeMaxPerOrder(_selectedTicketType);
    if (maxPerOrder > 0 && numberOfTickets.value > maxPerOrder) {
      numberOfTickets.value = maxPerOrder;
    }
  }

  @override
  Widget build(BuildContext context) {
    final venue = widget.match.recap?.venue;
    final venueLatLng = venue != null
        ? LatLng(venue.latitude, venue.longitude)
        : _fallbackLocation;
    final selectedTicketType = _selectedTicketType;
    final selectedTicketPrice = _ticketTypePrice(selectedTicketType);
    final selectedTicketName =
        selectedTicketType == null ? null : _ticketTypeName(selectedTicketType);

    return BlocConsumer<ProductBloc, ProductState>(
      bloc: context.read<ProductBloc>(),
      listener: (context, state) {
        if (state.status == ProductStatus.processingPayment) {
          SnackbarService.show(
            'Securing Payment',
            backgroundColor: AppColors.blackColor,
          );
        } else if (state.status == ProductStatus.successfulPayment) {
          final checkout = service<ProductService>().latestCheckoutResult;
          if (checkout == null) {
            SnackbarService.showError('Unable to continue checkout right now.');
            return;
          }
          handleFrontendCheckoutSuccess(context, checkout);
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

                      final payload = {
                        "action_key": "frontend.ticket.shared",
                        "reference_type": "match",
                        "reference_id": match.matchId,
                        "description": "Awarded after sharing match.",
                        "channel": "share_sheet",
                      };
                      _pointsBloc.add(
                        PointsEvent.addPoints(request: payload),
                      );

                      final shareText = '''
          🎟️ ${match.matchName}
          📅 ${getStringDate(match.matchDate)} at ${formatTime(match.matchDate)}
          💸 Ticket Price: ${match.matchPrice}
          📍 Location: ${match.matchVenue}
          Get your tickets now from the Wence Sports app!
          https://play.google.com/store/apps/details?id=com.wtl.siel''';

                      SharePlus.instance.share(
                        ShareParams(
                          text: shareText,
                          subject: 'Check out this event!',
                        ),
                      );
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

                        if (_ticketTypesLoading) {
                          SnackbarService.show(
                            'Loading ticket options...',
                            backgroundColor: AppColors.blackColor,
                          );
                          return;
                        }

                        final ticketType = _selectedTicketType;
                        if (ticketType == null) {
                          SnackbarService.showError(
                            _ticketTypesError ??
                                'No tickets are available for this match yet.',
                          );
                          return;
                        }

                        final bloc = _pointsBloc;
                        final ticketTypeId =
                            (ticketType['id'] ?? '').toString().trim();
                        final ticketPrice = _ticketTypePrice(ticketType);
                        final maxPerOrder = _ticketTypeMaxPerOrder(ticketType);
                        final checkoutQuantity = maxPerOrder > 0
                            ? numberOfTickets.value.clamp(1, maxPerOrder)
                            : numberOfTickets.value;

                        if (maxPerOrder > 0 &&
                            checkoutQuantity != numberOfTickets.value) {
                          numberOfTickets.value = checkoutQuantity;
                          SnackbarService.show(
                            'You can only buy up to $maxPerOrder tickets per order for this match.',
                            backgroundColor: AppColors.blackColor,
                          );
                        }

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
                            TotalAmount: ticketPrice * checkoutQuantity,
                            quantity: checkoutQuantity,
                          ),
                          buyMerch: (usedPoints, promotionCode) {
                            final int redeemablePoints = usedPoints;

                            context.read<ProductBloc>().add(
                                  ProductEvent.buyProducts(request: {
                                    "amount": ticketPrice * checkoutQuantity,
                                    "email": userEmail,
                                    "matchId": widget.match.matchId,
                                    "ticketTypeId": ticketTypeId,
                                    "reference_type": "ticket_type",
                                    "quantity": checkoutQuantity,
                                    "productID":
                                        "20d802f0-1557-49a5-9fcf-7de02e570c57",
                                    "category": "",
                                    if (redeemablePoints > 0)
                                      "redeemablePoints": redeemablePoints,
                                    if (promotionCode != null &&
                                        promotionCode.trim().isNotEmpty)
                                      "promotionCode": promotionCode,
                                  }),
                                );
                          },
                          match: widget.match,
                          pointsState: pointsState,
                          ticketLabel: selectedTicketName,
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
                            child: const AppBackButton(),
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
                            Text(
                              "Ticket Options",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (_ticketTypesLoading)
                              const Center(child: CircularProgressIndicator())
                            else if (_ticketTypes.isEmpty)
                              Text(
                                _ticketTypesError ??
                                    "No tickets are available for this match yet.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                              )
                            else
                              Column(
                                children: _ticketTypes.map((ticketType) {
                                  final ticketTypeId =
                                      _pickTicketTypeId(ticketType);
                                  final isSelected =
                                      ticketTypeId == _selectedTicketTypeId;
                                  final remainingQty =
                                      _ticketTypeRemainingQty(ticketType);
                                  final description =
                                      _ticketTypeDescription(ticketType);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(kMedium),
                                      onTap: () =>
                                          _selectTicketType(ticketType),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(kMedium),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          borderRadius:
                                              BorderRadius.circular(kMedium),
                                          border: Border.all(
                                            color: isSelected
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withValues(alpha: 0.12),
                                            width: isSelected ? 1.6 : 1,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    _ticketTypeName(ticketType),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Ksh ${_ticketTypePrice(ticketType).toStringAsFixed(0)}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (description != null) ...[
                                              const SizedBox(height: 6),
                                              Text(
                                                description,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withValues(alpha: 0.75),
                                                ),
                                              ),
                                            ],
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                if (remainingQty != null)
                                                  Text(
                                                    "Remaining: $remainingQty",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withValues(
                                                              alpha: 0.75),
                                                    ),
                                                  ),
                                                const Spacer(),
                                                if (_ticketTypeMaxPerOrder(
                                                        ticketType) >
                                                    0)
                                                  Text(
                                                    "Max ${_ticketTypeMaxPerOrder(ticketType)} per order",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withValues(
                                                              alpha: 0.75),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(growable: false),
                              ),
                            const SizedBox(height: 20),
                            ValueListenableBuilder(
                              valueListenable: numberOfTickets,
                              builder: (context, value, _) {
                                return TotalAndQuantity(
                                  add: () => numberOfTickets.value = value + 1,
                                  amount: selectedTicketPrice * value,
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
                                      userAgentPackageName: 'com.wtl.siel',
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
