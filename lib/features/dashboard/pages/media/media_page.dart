import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/media/media_bloc.dart';
import 'package:sports_app/features/app/blocs/notifications/notification_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/dashboard/pages/media/widget/media_highlight_card.dart';
import 'package:sports_app/features/dashboard/pages/notifications/widgets/notifications_card.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';

import '../../../../router/router.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  late StripeBloc _stripeBloc;
  late TextEditingController searchText;
  late HideCubit _hideCubit;
  Map<String, dynamic>? user;
  bool loading = false;
  User currentUser = service<AppPreferencesManager>().currentUserValue!;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _stripeBloc = StripeBloc();
    searchText = TextEditingController();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.read<HideCubit>().reveal();
      } else {
        if (searchText.text == "") {
          context.read<HideCubit>().hide();
        } else {}
      }
      //context.read<HideCubit>().reveal;
    });
    super.initState();
  }

  @override
  void dispose() {
    _stripeBloc.close();
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HideCubit, bool>(builder: (context, reveal) {
      return Scaffold(
        body: AppBackground(
          childWidget: SafeArea(
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
                ),
                const SizedBox(height: kMedium),
                reveal ? Container() : const SizedBox(height: kMedium),
                const SizedBox(height: kMedium),
                Expanded(
                  child: BlocBuilder<MediaBloc, MediaState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case MediaStatus.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case MediaStatus.failure:
                          return Center(
                            child: Text(state.failure!.error),
                          );
                        case MediaStatus.success:
                          if (state.media.isEmpty) {
                            return Center(
                              child: Text(
                                "No Media",
                                style: context.textTheme.headlineSmall,
                              ),
                            );
                          }

                          return BlocBuilder<MediaBloc, MediaState>(
                            builder: (context, state) {
                              switch (state.status) {
                                case MediaStatus.success:
                                  return SafeArea(
                                      child: Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [

                                          const Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Recent Highlights',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold)),
                                              Text('See All',
                                                  style: TextStyle(color: Colors.white70, fontSize: 12)),
                                            ],
                                          ),
                                          const SizedBox(height: kMedium),
                                          //TODO! Add upcoming matches
                                          SizedBox(
                                            height: 80,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: state.media[0]
                                                  .recentHighlights.length,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                final item = state.media[0]
                                                    .recentHighlights[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                item.image
                                                            ),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        item.title,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Season Highlights',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('See All',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Container(
                                              child: ListView.builder(
                                                  itemCount: state.media[0]
                                                      .seasonHighlights.length,
                                                  physics: const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item = state.media[0]
                                                            .seasonHighlights[
                                                        index];
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .vertical(
                                                                    top: Radius
                                                                        .circular(
                                                                            16)),
                                                            child: Image.network(
                                                                item.image,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  item.title,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  '${item.time} • posted on ${item.date}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })),
                                        ],
                                      ),
                                    ),
                                  ));
                                case MediaStatus.failure:
                                  return Center(
                                    child: Text(state.failure!.error),
                                  );
                                case MediaStatus.loading:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                default:
                                  return SizedBox.shrink();
                              }
                            },
                          );

                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            ),
          )),
        ),
      );
    });
  }

  Row headerSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.3),
                shape: BoxShape.circle),
            child: Icon(
              LucideIcons.arrowLeft,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        const Column(
          children: [
            Text('Team Media',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text('All Media Highlights',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
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

  TextField searchField({required focusNode, required controller}) {
    return TextField(
        focusNode: focusNode,
        controller: controller,
        onTapOutside: (event) {
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
          hintStyle: context.textTheme.bodyMedium
              ?.copyWith(color: const Color(0xffcfcdcd)),
        ));
  }
}

RowIconButton(IconData icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon),
      SizedBox(
        width: kSMedium,
      ),
      Text(
        text,
        style: TextStyle(fontSize: 14),
      )
    ],
  );
}
