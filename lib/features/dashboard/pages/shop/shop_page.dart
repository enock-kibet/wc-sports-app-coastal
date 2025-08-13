import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/data/models/products/cart.dart';
import 'package:sports_app/data/models/products/product.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/products/cart_bloc.dart';
import 'package:sports_app/features/app/blocs/products/product_bloc.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/circular_toggle.dart';
import 'package:sports_app/features/dashboard/pages/shop/shop_item_details_page.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/top_sellers_card.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:sports_app/utils/dotted.dart';

import '../../../../main.dart';
import '../../../../router/router.dart';
import '../profile/components/circular_icon_container.dart';

part 'widgets/price_card.dart';

part 'widgets/text_avator_text.dart';

part 'widgets/buy_merch_bottom_sheet.dart';

part 'widgets/cart_bottom_sheet.dart';

part 'widgets/animatedoverlaysnackbar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  User currentUser = service<AppPreferencesManager>().currentUserValue!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBackground(
      childWidget: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.status == ProductStatus.processingPayment) {
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
          } else if (state.status == ProductStatus.successfulPayment) {
            context.goNamed(
              AppRoute.paymentWebView.name,
              extra: state.authorizationUrl,
            );
            //AnimatedOverlaySnackbar.show(context, "Success: ${state.authorizationUrl??"didn't get"}",color:const Color(0xff2E7D32));
          } else if (state.status == ProductStatus.failure) {
            AnimatedOverlaySnackbar.show(
                context, "failed: ${state.failure?.error ?? "failed"}",
                color: AppColors.defaultAppRed);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.success:
            case ProductStatus.successfulPayment:
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMedium),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: kMedium),
                      headerSection(),
                      const SizedBox(height: kMedium),
                      searchField(),
                      const SizedBox(height: kMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Selling",
                            style: TextStyle(
                                fontSize: kMedium,
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: kMedium),
                      //TODO! Add upcoming matches
                      AutoHeightGridView(
                        itemCount: state.products.length,
                        crossAxisCount: context.isTablet ? 3 : 2,
                        mainAxisSpacing: kSmall,
                        crossAxisSpacing: kSmall,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        builder: (context, index) {
                          final product = state.products[index];
                          return TopSellersCard(product: product);
                        },
                      ),
                    ],
                  ),
                ),
              ));
            case ProductStatus.failure:
              return Center(
                child: Text(state.failure!.error),
              );
            case ProductStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
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
          hintText: "Search merch",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.whiteColor.withOpacity(0.8))),
    );
  }

  Row headerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(kSmall),
          decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.3),
              shape: BoxShape.circle),
          child: Icon(
            LucideIcons.arrowLeft,
            color: AppColors.whiteColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hi ${truncateText(currentUser.name, limit: 16)}",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            Text("Nairobi, Kenya",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: kMedium,
                    fontWeight: FontWeight.normal)),
          ],
        ),
        GestureDetector(
            onTap: () {
              context.read<CartBloc>().add(
                const CartEvent.getCartItems(request: {}),
              );
              final cartItems = context.read<CartBloc>().state.cartItems; // adjust property name if needed
              showCartShopBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.all(kSmall),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.3),
                  shape: BoxShape.circle),
              child: Icon(
                LucideIcons.shoppingCart,
                color: AppColors.whiteColor,
              ),
            ))
      ],
    );
  }
}
