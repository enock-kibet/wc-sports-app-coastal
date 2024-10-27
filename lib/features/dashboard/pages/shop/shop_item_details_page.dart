import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/location/directions_details.dart';
import 'package:sports_app/data/models/stripe_checkout/stripe_checkout.dart';
import 'package:sports_app/data/repository/geolocation_repository.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sports_app/utils/utils.dart';

class ShopDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ShopDetailsPage({super.key, required this.product});

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  DirectionDetailsInfo? directionDetailsInfo;
  late Map<MarkerId, Marker> _markers;
  Set<Polyline> setOfPolyline = <Polyline>{};

  List<LatLng> polyLinePositionCoordinates = [];
  double mapPadding = 350;

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14);
  bool ready = false;
  late StripeBloc _stripeBloc;
  @override
  void initState() {
    // context.read<StripeBloc>().add(StripeFetched(orderId: widget.order!.id!));
    _markers = <MarkerId, Marker>{};
    _markers.clear();
    _stripeBloc = StripeBloc();
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    _stripeBloc.close();
    super.dispose();
  }

  Future<void> initMarkers() async {
    DirectionDetailsInfo? directionDetailsInfo;
    final GoogleMapController controller = await _controller.future;
    const originLatLng = LatLng(37.42796, -122.18574);
    const destinationLatLng = LatLng(37.42796, -122.08574);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: originLatLng,
          zoom: 15,
        ),
      ),
    );
    var originImage = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(10, 10)), 'assets/origin.png');
    var destinationImage = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(10, 10)), 'assets/destination.png');
    Marker originMarker = Marker(
      markerId: const MarkerId('origin'),
      icon: originImage,
      position: originLatLng,
    );
    Marker destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      icon: destinationImage,
      position: destinationLatLng,
    );
    setState(() {
      _markers[const MarkerId('origin')] = originMarker;
      _markers[const MarkerId('destination')] = destinationMarker;
    });

    await drawPolyLineFromOriginToDestination(originLatLng, destinationLatLng);
  }

  Future<void> drawPolyLineFromOriginToDestination(
      LatLng originLatLng, LatLng destinationLatLng) async {
    var directionInfo = await service<GeolocationRepository>()
        .obtainOriginToDestinationDirectionDetails(
            originLatLng, destinationLatLng);

    if (directionInfo != null) {
      setState(() {
        directionDetailsInfo = directionInfo;
      });
    }

    PolylinePoints pPoints = PolylinePoints();

    List<PointLatLng> decodedPolyLinePointsResultList =
        pPoints.decodePolyline(directionInfo?.ePoints ?? "");

    polyLinePositionCoordinates.clear();

    if (decodedPolyLinePointsResultList.isNotEmpty) {
      for (var pointLatLng in decodedPolyLinePointsResultList) {
        polyLinePositionCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }

    setOfPolyline.clear(); // clear all previous polylines
    Polyline polyline = Polyline(
      color: AppColors.warningColor,
      polylineId: const PolylineId("PolylineID"),
      jointType: JointType.round,
      width: 4,
      points: polyLinePositionCoordinates,
      startCap: Cap.roundCap,
      endCap: Cap.squareCap,
      geodesic: true,
    );

    setState(() {
      setOfPolyline.add(polyline);
    });
    LatLngBounds boundsLatLng;
    if (originLatLng.latitude > destinationLatLng.latitude &&
        originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng =
          LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
        northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude),
      );
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
        northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      boundsLatLng =
          LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 65));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StripeBloc, StripeState>(
      bloc: _stripeBloc,
      listener: (context, state) {
        switch (state.status) {
          case StripeStatus.success:
            print(state.stripe);
            initPaymentSheet(
                context,
                StripeCheckout(
                    paymentIntent: state.stripe!["paymentIntent"],
                    ephemeralKey: state.stripe!["ephemralKey"],
                    customer: state.stripe!["customer"],
                    publishableKey: state.stripe!["publishableKey"]));

            break;
          default:
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 80,
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.symmetric(
                  horizontal: kLarge, vertical: kSmall),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kMedium),
                    topRight: Radius.circular(kMedium)),
                color: AppColors.whiteColor,
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(LucideIcons.bookmark)),
                  const SizedBox(
                    width: kSmall,
                  ),
                  Expanded(
                      child: FilledButton(
                          style: FilledButton.styleFrom(
                              minimumSize: Size(double.infinity, 50)),
                          onPressed: () {
                            _stripeBloc.add(StripeEvent.stripe(
                                email: "john@gmail.com",
                                price: int.parse(widget.product["amount"])));
                          },
                          child: const Text("Add To Cart")))
                ],
              ),
            ),
          ),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kMedium),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: kLarge,
                        ),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(kSMedium),
                                  topRight: Radius.circular(kSMedium)),
                              child: Image.network(
                                widget.product["imageUrl"],
                                width: double.infinity,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 20,
                              child: GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(kSmall),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.darkColor.withOpacity(0.3),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    LucideIcons.arrowLeft,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 20,
                              child: Container(
                                padding: const EdgeInsets.all(kSmall),
                                decoration: BoxDecoration(
                                    color: AppColors.darkColor.withOpacity(0.3),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  LucideIcons.moreHorizontal,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          color: AppColors.whiteColor,
                          padding:
                              const EdgeInsets.symmetric(horizontal: kMedium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: kMedium,
                              ),
                              Center(
                                child: Text(
                                  "Delivery . 2-3 Business Days",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: kSMedium,
                                      color: AppColors.darkColor),
                                ),
                              ),
                              const SizedBox(
                                height: kXSmall,
                              ),
                              Text(
                                widget.product["name"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: kLarge,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: kMedium,
                              ),
                              Text(
                                "Description",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: kMedium,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkColor),
                              ),
                              const SizedBox(
                                height: kXSmall,
                              ),
                              Text(
                                widget.product["description"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: kSMedium,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        AppColors.darkColor.withOpacity(0.7)),
                              ),
                              const SizedBox(
                                height: kMedium,
                              ),
                              const SizedBox(
                                height: kMedium,
                              ),
                              Text(
                                "Maps Guide",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: kMedium,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkColor),
                              ),
                              const SizedBox(
                                height: kSmall,
                              ),
                              Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor,
                                    borderRadius:
                                        BorderRadius.circular(kMedium)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(kMedium),
                                  child: GoogleMap(
                                    padding:
                                        EdgeInsets.only(bottom: mapPadding),
                                    mapType: MapType.normal,
                                    trafficEnabled: true,
                                    initialCameraPosition: _cameraPosition,
                                    onMapCreated: (controller) {
                                      _controller.complete(controller);
                                    },
                                    markers: _markers.values.toSet(),
                                    polylines: setOfPolyline,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: kLarge,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  Future<void> initPaymentSheet(
      BuildContext context, StripeCheckout stripeInfo) async {
    try {
      // 1. create payment intent on the server
      //Set the publishable key for stripe - this is mandatory
      Stripe.publishableKey = stripeInfo.publishableKey;
      Stripe.merchantIdentifier = 'merchant.moboeats.orderer';
      Stripe.urlScheme = 'flutterstripe';
      await Stripe.instance.applySettings();

      // create some billing details
      const billingDetails = BillingDetails(
          name: 'John Mbugua',
          email: 'john@gmail.com',
          phone: '+254799005059',
          address: Address(
            city: "Bermingham",
            country: "UK",
            line1: "1456 Circle Drive",
            line2: '',
            state: "Bermingham",
            postalCode: '77063',
          ));
      // 2. initialize the payment sheet
      //gpay
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // appearance: PaymentSheetAppearance(
          //   colors: PaymentSheetAppearanceColors(
          //     background: AppColors.whiteColor,
          //     primary: AppColors.primaryColor,
          //   ),
          //   shapes:
          //       const PaymentSheetShape(borderWidth: 4, borderRadius: kMedium),
          //   primaryButton: const PaymentSheetPrimaryButtonAppearance(
          //     shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
          //   ),
          // ),

          // Setup to true for custom flow
          customFlow: false,
          // main params
          merchantDisplayName: "Sports App",
          paymentIntentClientSecret: stripeInfo.paymentIntent,
          // custom keys
          customerEphemeralKeySecret: stripeInfo.ephemeralKey,
          customerId: stripeInfo.customer,
          //Extra options
          applePay: const PaymentSheetApplePay(
            buttonType: PlatformButtonType.buy,
            merchantCountryCode: "GB",
          ),
          googlePay: gpay,
          // style: ThemeMode.light,
          billingDetails: billingDetails,
          // billingDetailsCollectionConfiguration:
          //     BillingDetailsCollectionConfiguration(name: CollectionMode.automatic,email: CollectionMode.automatic,phone: CollectionMode.automatic,address: AddressCollectionMode.automatic),
        ),
      );
      // ignore: use_build_context_synchronously
      confirmPayment(context);
      setState(() {
        ready = true;
      });
    } catch (e) {
      showSnackBar(
        // ignore: use_build_context_synchronously
        context,
        content: 'Error: $e',
        bgColor: AppColors.dangerColor,
      );
      rethrow;
    }
  }

  Future<void> confirmPayment(BuildContext context) async {
    try {
      // 3. display the payment sheet
      await Stripe.instance.presentPaymentSheet().then((value) {
        print(value?.toJson());
        debugPrint("Success value $value");
        showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          content: 'Payment successfully completed',
          bgColor: AppColors.primaryColor,
        );
        //context.read<OrderBloc>().add(OrderFetched());
      }).onError((e, stackTrace) {
        if (e is StripeException) {
          showSnackBar(
            // ignore: use_build_context_synchronously
            context,
            content: '${e.error.localizedMessage}',
            bgColor: AppColors.dangerColor,
          );
        } else {
          showSnackBar(
            // ignore: use_build_context_synchronously
            context,
            content: 'Unforeseen error: $e',
            bgColor: AppColors.dangerColor,
          );
        }
      });
    } on Exception catch (e) {
      if (e is StripeException) {
        showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          content: 'Error from Stripe: ${e.error.localizedMessage}',
          bgColor: AppColors.dangerColor,
        );
      } else {
        showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          content: 'Unforeseen error: $e',
          bgColor: AppColors.dangerColor,
        );
      }
    }
  }
}
