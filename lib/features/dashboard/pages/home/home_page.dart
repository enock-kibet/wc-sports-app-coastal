import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/models/stripe_checkout/stripe_checkout.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/features/app/blocs/matches/match_schedule/schedule_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:sports_app/utils/dotted.dart';
import 'package:sports_app/utils/utils.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'widget/scheduled_tiles.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StripeBloc _stripeBloc;
  late TextEditingController searchText;
  late HideCubit _hideCubit;
  Map<String,dynamic>? user;
  bool loading=false;
  User currentUser = service<AppPreferencesManager>().currentUserValue!;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _stripeBloc = StripeBloc();
    searchText = TextEditingController();

    _focusNode.addListener((){
      if(_focusNode.hasFocus){
        context.read<HideCubit>().reveal();
      }else{
        if(searchText.text==""){
          context.read<HideCubit>().hide();
        }else{
        }
      }
      //context.read<HideCubit>().reveal;
    });
    super.initState();
  }

  @override
  void dispose() {
    _stripeBloc.close();
    _focusNode.removeListener((){});
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HideCubit,bool>(
      builder: (context,reveal) {
        return Scaffold(
          body: AppBackground(
            childWidget:SafeArea(
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
                        onChanged: (string)=>context.read<MatchBloc>().add(MatchEvent.searchMatch(search: searchText.text))
                      ),
                      reveal?Container():const SizedBox(height: kMedium),
                      reveal?Container():banner(),
                      reveal?Container():const SizedBox(height: kMedium),
                      reveal?Container(): Align(alignment:Alignment.centerLeft,child: Text("Schedule",style: context.textTheme.headlineLarge?.copyWith(fontSize: 18,color: AppColors.whiteColor),)),
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
                                child: Text(state.failure!.error),
                              );
                            case MatchStatus.success:

                              context.read<ScheduleBloc>().add(LoadSchedules(reveal?state.searchedMatches:state.matches));

                              return BlocBuilder<ScheduleBloc,ScheduleState>(
                                builder: (context,scheduledMatches) {
                                  if(scheduledMatches is ScheduleLoading){
                                    return const Center(child:CircularProgressIndicator());
                                  }
                                  else if(scheduledMatches is ScheduleLoaded){
                                    return ListView(
                                      children: scheduledMatches.categorizedSchedulees.entries.map((entry) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top:8.0,bottom: 12),
                                              child: Text(
                                                entry.key.toString().split('.').last.toTitleCase(),
                                                style: context.textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
                                              ),
                                            ),
                                            ...entry.value.map((match) {
                                              return ScheduledTiles(match: match);
                                            }
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  }
                                  return(Container());
                                }
                              );

                            default:
                              return const SizedBox.shrink();
                          }
                        },
                              ),
                      ),
                                ],
                              ),
                )) ,
          ),
        );
      }
    );
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
                    style: context.textTheme.bodyLarge?.copyWith(color: AppColors.whiteColor),
                  ),
                  Text(
                    "All Merch!",
                      style: context.textTheme.headlineLarge?.copyWith(fontSize: kLarge,color: AppColors.whiteColor),
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

  TextField searchField({required onChanged, required focusNode,required controller}) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      controller: controller,
      onTapOutside: (event){
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
              borderRadius: BorderRadius.circular(kXXXXLarge)),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: kMedium, vertical: kXLMedium * 0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kXXXXLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kXXXXLarge),
              borderSide: BorderSide(
                color: AppColors.whiteColor,
              )),
          hintText: "Search",
          hintStyle: context.textTheme.bodyMedium?.copyWith(color:const Color(0xffcfcdcd)),
    ));
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
            Text("Hi ${truncateText(limit:16,currentUser.name)}",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            Text("Nairobi, Kenya",
                style: TextStyle(
                    color: AppColors.whiteColor,
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

  // Future<void> initPaymentSheet(
  //     BuildContext context, StripeCheckout stripeInfo) async {
  //   try {
  //     1. create payment intent on the server
  //     Set the publishable key for stripe - this is mandatory
  //     Stripe.publishableKey = stripeInfo.publishableKey;
  //     Stripe.merchantIdentifier = 'merchant.moboeats.orderer';
  //     Stripe.urlScheme = 'flutterstripe';
  //     await Stripe.instance.applySettings();
  //
  //     // create some billing details
  //     const billingDetails = BillingDetails(
  //          name: 'John Mbugua',
  //         email: 'john@gmail.com',
  //         phone: '+254799005059',
  //         address: Address(
  //           city: "Bermingham",
  //           country: "UK",
  //           line1: "1456 Circle Drive",
  //           line2: '',
  //           state: "Bermingham",
  //           postalCode: '77063',
  //         ));
  //     // 2. initialize the payment sheet
  //     //gpay
  //     var gpay = const PaymentSheetGooglePay(
  //         merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         // appearance: PaymentSheetAppearance(
  //         //   colors: PaymentSheetAppearanceColors(
  //         //     background: AppColors.whiteColor,
  //         //     primary: AppColors.primaryColor,
  //         //   ),
  //         //   shapes:
  //         //       const PaymentSheetShape(borderWidth: 4, borderRadius: kMedium),
  //         //   primaryButton: const PaymentSheetPrimaryButtonAppearance(
  //         //     shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
  //         //   ),
  //         // ),
  //
  //         // Setup to true for custom flow
  //         customFlow: false,
  //         // main params
  //         merchantDisplayName: "Sports App",
  //         paymentIntentClientSecret: stripeInfo.paymentIntent,
  //         // custom keys
  //         customerEphemeralKeySecret: stripeInfo.ephemeralKey,
  //         customerId: stripeInfo.customer,
  //         //Extra options
  //         applePay: const PaymentSheetApplePay(
  //           buttonType: PlatformButtonType.buy,
  //           merchantCountryCode: "GB",
  //         ),
  //         googlePay: gpay,
  //         // style: ThemeMode.light,
  //         billingDetails: billingDetails,
  //         // billingDetailsCollectionConfiguration:
  //         //     BillingDetailsCollectionConfiguration(name: CollectionMode.automatic,email: CollectionMode.automatic,phone: CollectionMode.automatic,address: AddressCollectionMode.automatic),
  //       ),
  //     );
  //     // ignore: use_build_context_synchronously
  //     confirmPayment(context);
  //     setState(() {});
  //   } catch (e) {
  //     showSnackBar(
  //       // ignore: use_build_context_synchronously
  //       context,
  //       content: 'Error: $e',
  //       bgColor: AppColors.dangerColor,
  //     );
  //     rethrow;
  //   }
  // }

  // Future<void> confirmPayment(BuildContext context) async {
  //   try {
  //     // 3. display the payment sheet
  //     await Stripe.instance.presentPaymentSheet().then((value) {
  //       print(value?.toJson());
  //       debugPrint("Success value $value");
  //       showSnackBar(
  //         // ignore: use_build_context_synchronously
  //         context,
  //         content: 'Payment successfully completed',
  //         bgColor: AppColors.primaryColor,
  //       );
  //       //context.read<OrderBloc>().add(OrderFetched());
  //     }).onError((e, stackTrace) {
  //       if (e is StripeException) {
  //         showSnackBar(
  //           // ignore: use_build_context_synchronously
  //           context,
  //           content: '${e.error.localizedMessage}',
  //           bgColor: AppColors.dangerColor,
  //         );
  //       } else {
  //         showSnackBar(
  //           // ignore: use_build_context_synchronously
  //           context,
  //           content: 'Unforeseen error: $e',
  //           bgColor: AppColors.dangerColor,
  //         );
  //       }
  //     });
  //   } on Exception catch (e) {
  //     if (e is StripeException) {
  //       showSnackBar(
  //         // ignore: use_build_context_synchronously
  //         context,
  //         content: 'Error from Stripe: ${e.error.localizedMessage}',
  //         bgColor: AppColors.dangerColor,
  //       );
  //     } else {
  //       showSnackBar(
  //         // ignore: use_build_context_synchronously
  //         context,
  //         content: 'Unforeseen error: $e',
  //         bgColor: AppColors.dangerColor,
  //       );
  //     }
  //   }
  // }
}
RowIconButton(IconData icon,String text){
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon),
      SizedBox(width: kSMedium,),
      Text(text,style: TextStyle(fontSize: 14),)
    ],
  );
}