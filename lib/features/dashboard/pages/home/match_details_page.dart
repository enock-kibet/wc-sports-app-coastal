import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/stripe_checkout/stripe_checkout.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:sports_app/utils/utils.dart';

class MatchDetailsPage extends StatefulWidget {
  const MatchDetailsPage({super.key, required this.match});
  final Map<String, dynamic> match;
  @override
  State<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {
  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14);
  late StripeBloc _stripeBloc;
  @override
  void initState() {
    _stripeBloc = StripeBloc();
    super.initState();
  }

  @override
  void dispose() {
    _stripeBloc.close();
    super.dispose();
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
                          onPressed: () {
                            _stripeBloc.add(const StripeEvent.stripe(
                                email: "john@gmail.com", price: 500));
                          },
                          child: const Text("Buy Ticket")))
                ],
              ),
            ),
          ),
          body: AppBackground(
              childWidget:SafeArea(
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
                            Image.asset(
                              "assets/images/Frame9.png",
                              width: double.infinity,
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
                                  "Friday,27 Oct 2024 . 05:00PM",
                                  maxLines: 2,
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
                                widget.match['name'],
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
                                widget.match["description"],
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
                                "Maps",
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
                                    mapType: MapType.normal,
                                    trafficEnabled: true,
                                    initialCameraPosition: _cameraPosition,
                                    onMapCreated: (controller) {},
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
              )
          )

          // Container(
          //     height: double.infinity,
          //     width: double.infinity,
          //     decoration: const BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage("assets/background.png"),
          //           fit: BoxFit.cover),
          //     ),
          //     child: SafeArea(
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: kMedium),
          //         child: SingleChildScrollView(
          //           child: Column(
          //             children: [
          //               const SizedBox(
          //                 height: kLarge,
          //               ),
          //               Stack(
          //                 children: [
          //                   Image.asset(
          //                     "assets/images/Frame9.png",
          //                     width: double.infinity,
          //                   ),
          //                   Positioned(
          //                     left: 20,
          //                     top: 20,
          //                     child: GestureDetector(
          //                       onTap: () {
          //                         context.pop();
          //                       },
          //                       child: Container(
          //                         padding: const EdgeInsets.all(kSmall),
          //                         decoration: BoxDecoration(
          //                             color:
          //                                 AppColors.darkColor.withOpacity(0.3),
          //                             shape: BoxShape.circle),
          //                         child: Icon(
          //                           LucideIcons.arrowLeft,
          //                           color: AppColors.whiteColor,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   Positioned(
          //                     right: 20,
          //                     top: 20,
          //                     child: Container(
          //                       padding: const EdgeInsets.all(kSmall),
          //                       decoration: BoxDecoration(
          //                           color: AppColors.darkColor.withOpacity(0.3),
          //                           shape: BoxShape.circle),
          //                       child: Icon(
          //                         LucideIcons.moreHorizontal,
          //                         color: AppColors.whiteColor,
          //                       ),
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               Container(
          //                 width: double.infinity,
          //                 color: AppColors.whiteColor,
          //                 padding:
          //                     const EdgeInsets.symmetric(horizontal: kMedium),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     const SizedBox(
          //                       height: kMedium,
          //                     ),
          //                     Center(
          //                       child: Text(
          //                         "Friday,27 Oct 2024 . 05:00PM",
          //                         maxLines: 2,
          //                         overflow: TextOverflow.ellipsis,
          //                         style: TextStyle(
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: kSMedium,
          //                             color: AppColors.darkColor),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: kXSmall,
          //                     ),
          //                     Text(
          //                       widget.match['name'],
          //                       textAlign: TextAlign.start,
          //                       style: TextStyle(
          //                           fontSize: kLarge,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                     const SizedBox(
          //                       height: kMedium,
          //                     ),
          //                     Text(
          //                       "Description",
          //                       textAlign: TextAlign.start,
          //                       style: TextStyle(
          //                           fontSize: kMedium,
          //                           fontWeight: FontWeight.w700,
          //                           color: AppColors.darkColor),
          //                     ),
          //                     const SizedBox(
          //                       height: kXSmall,
          //                     ),
          //                     Text(
          //                       widget.match["description"],
          //                       textAlign: TextAlign.start,
          //                       style: TextStyle(
          //                           fontSize: kSMedium,
          //                           fontWeight: FontWeight.w400,
          //                           color:
          //                               AppColors.darkColor.withOpacity(0.7)),
          //                     ),
          //                     const SizedBox(
          //                       height: kMedium,
          //                     ),
          //                     const SizedBox(
          //                       height: kMedium,
          //                     ),
          //                     Text(
          //                       "Maps",
          //                       textAlign: TextAlign.start,
          //                       style: TextStyle(
          //                           fontSize: kMedium,
          //                           fontWeight: FontWeight.w700,
          //                           color: AppColors.darkColor),
          //                     ),
          //                     const SizedBox(
          //                       height: kSmall,
          //                     ),
          //                     Container(
          //                       height: 300,
          //                       width: double.infinity,
          //                       decoration: BoxDecoration(
          //                           color: AppColors.greyColor,
          //                           borderRadius:
          //                               BorderRadius.circular(kMedium)),
          //                       child: ClipRRect(
          //                         borderRadius: BorderRadius.circular(kMedium),
          //                         child: GoogleMap(
          //                           mapType: MapType.normal,
          //                           trafficEnabled: true,
          //                           initialCameraPosition: _cameraPosition,
          //                           onMapCreated: (controller) {},
          //                         ),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: kLarge,
          //                     ),
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     )),
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
      setState(() {});
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
