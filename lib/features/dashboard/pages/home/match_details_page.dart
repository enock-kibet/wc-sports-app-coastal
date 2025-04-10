import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/services/service.dart';
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

  final ValueNotifier<int> numberOfTickets = ValueNotifier(1);

  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-1.3044, 36.8254), zoom: 16);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).routeInformationProvider.value.uri.toString();
        return BlocConsumer<ProductBloc,ProductState>(
          bloc: context.read<ProductBloc>(),
            listener: (context,state){
              if(state.status == ProductStatus.processingPayment){
                debugPrint("debugPrint $location");
                rootScaffoldMessengerKey.currentState!.showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.blackColor,
                    content: Text(
                      "Securing Payment",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                );
                //AnimatedOverlaySnackbar.show(context, "Loading",color:const Color(0xff1976D2));

              }else if(state.status == ProductStatus.successfulPayment){
                context.goNamed(
                  AppRoute.paymentWebView.name,
                  extra: state.authorizationUrl,
                );
                //AnimatedOverlaySnackbar.show(context, "Success: ${state.authorizationUrl??"didn't get"}",color:const Color(0xff2E7D32));

              }else if(state.status == ProductStatus.failure){
                AnimatedOverlaySnackbar.show(context, "failed: ${state.failure?.error??"failed"}",color:AppColors.defaultAppRed);
              }
            },
          builder: (context,state) {
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
                      CustomIconButton(
                          size: 60,
                          isRoundedRectBorder: true,
                          iconColor: const Color(0xff3f3d56),
                          borderColor: const Color(0xffe4e4e4),
                          onButtonPress: () {}, icon: Icons.share_outlined),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: GradientFilledButton(
                            radius: 16,
                              onPressed: () {
                                showTicketBottomSheet(context, (TotalAmount: widget.match.matchPrice*numberOfTickets.value,quantity: numberOfTickets.value),
                                    buyMerch:(){
                                      context.read<ProductBloc>().add(
                                        ProductEvent.buyProducts(request: {
                                          "amount": widget.match.matchPrice*numberOfTickets.value,
                                          "email": service<AppPreferencesManager>().currentUserValue!.email,
                                          "productID": "20d802f0-1557-49a5-9fcf-7de02e570c57",
                                          "category": ""
                                        }),
                                      );
                                    },
                                    match: widget.match);},
                              text: "Buy Ticket"))
                    ],
                  ),
                ),
              ),
              body: AppBackground(
                  childWidget:SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(36),topLeft:Radius.circular(36) ),
                                  child: CachedNetworkImage(
                                    imageUrl: RandomImageUrl(),
                                    errorWidget: (context, url, error) => Icon(Icons.person,size: 48,color: AppColors.whiteColor,),
                                    height: 300,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  top: 20,
                                  child: CustomIconButton(
                                      onButtonPress: (){context.pop();},
                                      size: 40,
                                      borderColor: Colors.transparent,
                                      iconColor: AppColors.whiteColor,
                                      backgroundColor: Colors.black.withOpacity(.24),
                                      icon: LucideIcons.arrowLeft

                                  )
                                ),
                                Positioned(
                                  right: 20,
                                  top: 20,
                                  child: CustomIconButton(
                                      onButtonPress: (){},
                                      size: 40,
                                      borderColor: Colors.transparent,
                                      iconColor: AppColors.whiteColor,
                                      backgroundColor: Colors.black.withOpacity(.24),
                                      icon: LucideIcons.bookmark

                                  )
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
                                    height: 20,
                                  ),
                                  Center(
                                    child:
                                    AvatorInText(
                                      fontsize: 13,
                                        firstText: getStringDate(widget.match.matchDate),
                                        secondText: formatTime(widget.match.matchDate),)
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    widget.match.matchName,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: kLarge,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Description",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        height: 1.4,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkColor),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.match.matchDescription,
                                    textAlign: TextAlign.start,
                                    maxLines: 4,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,height: 1.7,
                                        fontWeight: FontWeight.w400,
                                        color:
                                        AppColors.darkColor.withOpacity(0.7)),
                                  ),
                                  const SizedBox(height: 20,),
                                  ValueListenableBuilder(
                                    valueListenable:numberOfTickets,
                                    builder: (context,value,child) {
                                      return TotalAndQuantity(
                                        add: (){ numberOfTickets.value = value + 1 ; },
                                        amount: widget.match.matchPrice*value,
                                        quantity: value ,
                                        subtract: (){ value>1?numberOfTickets.value=value-1:numberOfTickets.value=1;});
                                    }
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Maps",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
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
            );
          }
        );
  }
}
String formatTime(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime);
}