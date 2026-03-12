import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    as google_maps_flutter;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/models/addresses/pickupaddress.dart';
import 'package:sports_app/data/models/products/cart.dart';
import 'package:sports_app/data/models/products/product.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/app/blocs/products/cart_bloc.dart';
import 'package:sports_app/features/app/blocs/products/product_bloc.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/dashboard/pages/profile/components/circular_toggle.dart';
import 'package:sports_app/features/dashboard/pages/shop/shop_item_details_page.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/address_bottom_sheet.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/cart_location_picker.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/top_sellers_card.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:sports_app/utils/dotted.dart';

import '../../../../data/models/addresses/address.dart';
import '../../../../main.dart';
import '../../../../router/router.dart';
import '../../../app/blocs/address/address_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppBackground(
      childWidget: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.status == ProductStatus.processingPayment) {
            SnackbarService.show(
              'Securing Payment',
              backgroundColor: AppColors.blackColor,
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
                child: Text(
                  state.failure?.error ?? "Unable to load shop items right now.",
                ),
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
    final currentUser = service<AppPreferencesManager>().currentUserValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.3),
                shape: BoxShape.circle),
            child: GestureDetector(
              onTap: () {
                context.go('/home');
              },
              child: Icon(
                LucideIcons.arrowLeft,
                color: AppColors.whiteColor,
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hi ${truncateText(currentUser?.name ?? 'Guest', limit: 16)}",
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
            onTap: () async {
              final bloc = context.read<PointsBloc>();

              // Step 1: Trigger loading of points
              bloc.add(const PointsEvent.points());

              // Step 2: Wait for points to load (listen for success)
              await Future.doWhile(() async {
                await Future.delayed(const Duration(milliseconds: 100));
                final state = bloc.state;
                return state.status == PointsStatus.loading;
              });

              final pointsState = bloc.state;

              context.read<CartBloc>().add(
                    const CartEvent.getCartItems(request: {}),
                  );
              context.read<AddressBloc>().add(
                    const AddressEvent.getAddresses(request: {}),
                  );
              final cartItems = context
                  .read<CartBloc>()
                  .state
                  .cartItems; // adjust property name if needed
              final addressItems = context
                  .read<AddressBloc>()
                  .state
                  .data; // adjust property name if needed
              showCartShopBottomSheet(context, pointsState: pointsState);
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
