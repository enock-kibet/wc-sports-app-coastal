import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/models/addresses/pickupaddress.dart';
import 'package:sports_app/data/models/products/cart.dart';
import 'package:sports_app/data/models/products/frontend_checkout.dart';
import 'package:sports_app/data/models/products/product.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/points/points_bloc.dart';
import 'package:sports_app/features/app/blocs/products/cart_bloc.dart';
import 'package:sports_app/features/app/blocs/products/product_bloc.dart';
import 'package:sports_app/features/dashboard/pages/shared/frontend_checkout_flow.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/address_bottom_sheet.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/product_image_placeholder.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/top_sellers_card.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:sports_app/utils/dotted.dart';

import '../../../../data/models/addresses/address.dart';
import '../../../app/blocs/address/address_bloc.dart';

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
  Widget _buildShopContent(ProductState state) {
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
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
            const SizedBox(height: kMedium),
            if (state.products.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: kMedium,
                  vertical: kXLarge,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(kMedium),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      LucideIcons.shoppingBag,
                      size: 36,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.55),
                    ),
                    const SizedBox(height: kSmall),
                    Text(
                      "No products available right now.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: kMedium,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: kXXSmall),
                    Text(
                      "Please check back again later.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              )
            else
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBackground(
      childWidget: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.success:
            case ProductStatus.successfulPayment:
            case ProductStatus.processingPayment:
              return _buildShopContent(state);
            case ProductStatus.failure:
              if (state.products.isNotEmpty) {
                return _buildShopContent(state);
              }
              return Center(
                child: Text(
                  state.failure?.error ??
                      "Unable to load shop items right now.",
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.whiteColor : const Color(0xFFDADADA);
    return TextField(
      decoration: InputDecoration(
          suffixIcon: Container(
              padding: const EdgeInsets.only(right: kSmall),
              child: Icon(
                LucideIcons.search,
                color: isDark
                    ? AppColors.whiteColor
                    : Theme.of(context).colorScheme.onSurface,
              )),
          fillColor: isDark
              ? AppColors.whiteColor.withValues(alpha: 0.2)
              : Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(kLarge)),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: kMedium, vertical: kXLMedium * 0.9),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kLarge),
              borderSide: BorderSide(
                color: borderColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kLarge),
              borderSide: BorderSide(
                color: borderColor,
              )),
          hintText: "Search merch",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: isDark
                  ? AppColors.whiteColor.withValues(alpha: 0.8)
                  : const Color(0xFF9A9A9A))),
    );
  }

  Row headerSection() {
    final currentUser = service<AppPreferencesManager>().currentUserValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor =
        isDark ? AppColors.whiteColor.withValues(alpha: 0.3) : Colors.white;
    final iconColor =
        isDark ? AppColors.whiteColor : Theme.of(context).colorScheme.onSurface;
    final titleColor =
        isDark ? AppColors.whiteColor : Theme.of(context).colorScheme.onSurface;
    final subtitleColor = isDark
        ? AppColors.whiteColor
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppBackButton(onPressed: () => context.go('/home')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hi ${truncateText(currentUser?.name ?? 'Guest', limit: 16)}",
                style: TextStyle(
                    color: titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            Text("Nairobi, Kenya",
                style: TextStyle(
                    color: subtitleColor,
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

              if (!mounted) return;
              await showCartShopBottomSheet(context, pointsState: pointsState);
            },
            child: Container(
              padding: const EdgeInsets.all(kSmall),
              decoration: BoxDecoration(
                color: chipColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.shoppingCart,
                color: iconColor,
              ),
            ))
      ],
    );
  }
}
