import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/data/models/products/product.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/auth/auth_bloc.dart';
import 'package:sports_app/features/app/blocs/products/product_bloc.dart';
import 'package:sports_app/features/dashboard/pages/pages.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/theme.dart';


class ShopDetailsPage extends StatefulWidget {
  final Product product;
  const ShopDetailsPage({super.key, required this.product});

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  final multiNotifier = MultiValueNotifier();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc,ProductState>(
      bloc: context.read<ProductBloc>(),
      listener: (context,state){
        if(state.status == ProductStatus.processingPayment ){
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
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMedium),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white, // Ensure it's the same as the background
                  boxShadow: [], // Remove shadow if present
                ),
                child: Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: multiNotifier,
                      builder: (context, value, child) {
                        return CustomIconButton(
                          borderColor: Color(0xffe4e4e4),
                          iconColor: AppColors.defaultAppPurple,
                          onButtonPress: () {},
                          icon: LucideIcons.bookmark,
                          isRoundedRectBorder: true,
                          size: 60,
                        );
                      },
                    ),
                    const SizedBox(width: kSmall),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: multiNotifier,
                        builder: (context, value, child) {
                          return GradientFilledButton(
                            text: "Add to Cart",
                            onPressed: value.$1 == 0
                                ? () {
                              rootScaffoldMessengerKey.currentState!.showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.blackColor,
                                  content: Text(
                                    "Add an item to proceed",
                                    style: TextStyle(color: AppColors.whiteColor),
                                  ),
                                ),
                              );
                            }
                                : () async {
                              showShopBottomSheet(
                                context,
                                value,
                                widget.product,
                                buyMerch: () {
                                  context.read<ProductBloc>().add(
                                    ProductEvent.buyProducts(request: {
                                      "amount": value.$1,
                                      "email": service<AppPreferencesManager>().currentUserValue!.email,
                                      "productID": widget.product.id,
                                      "category": ""
                                    }),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            body:
                AppBackground(childWidget: SafeArea(
                  child: Stack(
                    children: [
                      //back navigation icon

                      Container(
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                          children: [

                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(36),
                                  topRight: Radius.circular(36)),
                              child: Image.network(
                                widget.product.imageUrl,
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: kMedium,
                                  ),
                                  Center(
                                      child: AvatorInText()
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.product.name,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: kLarge,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  //product description title
                                  Text(

                                      "Description",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkColor
                                      )
                                  ),
                                  const SizedBox(
                                    height: kXSmall,
                                  ),
                                  //description text
                                  Text(
                                    widget.product.description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: kSMedium,
                                        fontWeight: FontWeight.w400,
                                        color:
                                        AppColors.darkColor.withOpacity(0.7)),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: multiNotifier,
                                    builder: (context,value,child) {
                                      final (total,small,medium,large)=value;
                                      return Text("Ksh ${total.ceil()}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),);
                                    },
                                  ),
                                  SizedBox(height: 24,),
                                  Text(
                                    "Size Guide",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: kMedium,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkColor),
                                  ),
                                  const SizedBox(
                                    height: kSmall,
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: multiNotifier,
                                    builder: (context, value, child) {
                                      final (total, small, medium, large) = value;

                                      void updateCount(int newSmall, int newMedium, int newLarge) {
                                        multiNotifier.update(
                                          total + (newSmall - small + newMedium - medium + newLarge - large) * int.parse(widget.product.price),
                                          newSmall, newMedium, newLarge,
                                        );
                                      }

                                      return PriceCard(
                                        value: value,
                                        product: widget.product,
                                        smallAdd: () => updateCount(small < 99 ? small + 1 : small, medium, large),
                                        mediumAdd: () => updateCount(small, medium < 99 ? medium + 1 : medium, large),
                                        largeAdd: () => updateCount(small, medium, large < 99 ? large + 1 : large),
                                        smallSubtract: () => updateCount(small > 0 ? small - 1 : small, medium, large),
                                        mediumSubtract: () => updateCount(small, medium > 0 ? medium - 1 : medium, large),
                                        largeSubtract: () => updateCount(small, medium, large > 0 ? large - 1 : large),
                                      );
                                    },
                                  )

                              ],
                              ),
                            )


                          ],
                                          ),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          top: 20,
                          child: CustomIconButton(
                            onButtonPress: (){
                              print("iwaspressed");
                              context.pop();},
                            icon: Icons.arrow_back,
                            size: 40,
                            borderColor: Color(0xff828282),
                            iconColor: Colors.white,
                            backgroundColor: Color(0xff828282),
                          )
                      ),
                      Positioned(
                          right: 20,
                          top: 20,
                          child: CustomIconButton(
                            onButtonPress: (){
                              print("iwaspressed");
                              },
                            icon: Icons.more_horiz,
                            size: 40,
                            borderColor: Color(0xff828282),
                            iconColor: Colors.white,
                            backgroundColor: Color(0xff828282),
                          )
                      ),

                      //more hortz


                    ]

                  ),
                ),)

            );
      }
    );

  }


}
class MultiValueNotifier extends ValueNotifier<(double,int,int,int)>{
  MultiValueNotifier() : super((0,0,0,0));
  void update(double totalPrice, smallQuantity, mediumQuantity, largeQuantity){
    value = (totalPrice,smallQuantity,mediumQuantity,largeQuantity);
  }
}

