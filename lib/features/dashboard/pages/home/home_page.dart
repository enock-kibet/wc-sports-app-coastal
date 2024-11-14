import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/data/models/stripe_checkout/stripe_checkout.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/product/match_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:sports_app/utils/utils.dart';

import 'widget/match.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StripeBloc _stripeBloc;
  Map<String,dynamic>? user;
  bool loading=false;
  getUserInfo()async{
    loading=true;
    final response =await service<ProfileService>().getMe();
    response.when(onError: (error){}, onSuccess: (data){
      setState(() {
        user=data;
        loading=false;
      });
    });
  }
  @override
  void initState() {
    _stripeBloc = StripeBloc();
    getUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    _stripeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        childWidget:SafeArea(child: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          switch (state.status) {
            case MatchStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MatchStatus.failure:
              return Center(
                child: Text(state.failure!.error),
              );
            case MatchStatus.success:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMedium),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: kMedium),
                      headerSection(context),
                      const SizedBox(height: kMedium),
                      searchField(),
                      const SizedBox(height: kMedium),
                      banner(),
                      const SizedBox(height: kMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Schedule",
                            style: TextStyle(
                                fontSize: kMedium,
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text("See All",
                                  style: TextStyle(
                                      color: AppColors.whiteColor)))
                        ],
                      ),
                      const SizedBox(height: kSMedium),
                      //TODO! Add schedules
                      schedules(matches: state.matches),
                      const SizedBox(height: kMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upcoming Matches",
                            style: TextStyle(
                                fontSize: kMedium,
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text("See All",
                                  style: TextStyle(
                                      color: AppColors.whiteColor)))
                        ],
                      ),
                      const SizedBox(height: kMedium),
                      //TODO! Add upcoming matches
                      AutoHeightGridView(
                        itemCount: state.matches.length,
                        crossAxisCount: context.isTablet ? 3 : 2,
                        mainAxisSpacing: kSmall,
                        crossAxisSpacing: kSmall,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        builder: (context, index) {
                          final match = state.matches[index];
                          return ProductCard(match: match);
                        },
                      ),
                    ],
                  ),
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      )) ,
      )
    );
  }

  SingleChildScrollView schedules({required dynamic matches}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocConsumer<StripeBloc, StripeState>(
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
                        Text(match["name"], style: TextStyle(fontSize: 10)),
                        const SizedBox(height: kSmall),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 8,
                            ),
                            const SizedBox(width: kXSmall),
                            Text(match["clubOne"]["name"])
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
                            Text(match["clubTwo"]["name"])
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
                            const Text("27 Oct, 2024",
                                style: TextStyle(fontSize: 10)),
                            Text(match["venue"]["name"],
                                style: const TextStyle(fontSize: 10)),
                            const Text("Amount -ksh 500",
                                style: TextStyle(fontSize: 10)),
                            const SizedBox(
                              height: kSmall,
                            ),
                            GestureDetector(
                              onTap: () {
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
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: kMedium,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "All Merch!",
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: kLarge,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "24 Feb - 04 May",
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: kSMedium,
                        fontWeight: FontWeight.normal),
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
                  image: AssetImage("assets/images/shirt.png"),
                ),
              ),
              child: Image.asset("assets/images/shirt.png"),
            )),
          ],
        ));
  }

  TextField searchField() {
    return TextField(
      decoration: InputDecoration(
          suffixIcon: Container(
              padding: const EdgeInsets.only(right: kSmall),
              child: Icon(LucideIcons.search, color: AppColors.whiteColor)),
          fillColor: AppColors.whiteColor.withOpacity(0.2),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              ),
              borderRadius: BorderRadius.circular(kLarge)),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: kMedium, vertical: kXLMedium * 0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          hintText: "Search HRBC events",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.whiteColor.withOpacity(0.8))),
    );
  }

  Row headerSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
           // context.go('/onboarding');
          context.read<SideMenuCubit>().state.currentState!.openDrawer();
          },
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.3),
                shape: BoxShape.circle),
            child: Icon(
              LucideIcons.menu,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hi ${user?["name"]}!",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: kLarge,
                    fontWeight: FontWeight.bold)),
            Text("Nairobi, Kenya",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: kMedium,
                    fontWeight: FontWeight.normal)),
          ],
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoute.notifications.name);
          },
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.3),
                shape: BoxShape.circle),
            child: Icon(
              LucideIcons.bell,
              color: AppColors.whiteColor,
            ),
          ),
        )
      ],
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
