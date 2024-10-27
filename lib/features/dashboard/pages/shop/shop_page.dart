import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/features/app/blocs/matches/product_bloc.dart';

import 'package:sports_app/features/dashboard/pages/shop/widgets/top_sellers_card.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover),
          ),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              switch (state.status) {
                case ProductStatus.success:
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
                              // TextButton(
                              //     onPressed: () {},
                              //     child: Text("See All",
                              //         style: TextStyle(
                              //             color: AppColors.whiteColor)))
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
                              return  TopSellersCard(product:product);
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
          )),
    );
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
            Text("Hi Ogwambo!",
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
        Container(
          padding: const EdgeInsets.all(kSmall),
          decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.3),
              shape: BoxShape.circle),
          child: Icon(
            LucideIcons.bell,
            color: AppColors.whiteColor,
          ),
        )
      ],
    );
  }
}
