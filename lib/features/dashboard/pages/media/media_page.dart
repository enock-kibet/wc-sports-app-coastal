import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/common/utils/pull_to_refresh.dart';
import 'package:sports_app/features/app/blocs/media/media_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/dashboard/pages/media/widget/season_highlights_list.dart';
import 'package:sports_app/theme/app_colors.dart';

import '../../../../router/router.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  late StripeBloc _stripeBloc;
  late TextEditingController searchText;
  late VoidCallback _focusListener;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _stripeBloc = StripeBloc();
    searchText = TextEditingController();

    _focusListener = () {
      if (_focusNode.hasFocus) {
        context.read<HideCubit>().reveal();
      } else {
        if (searchText.text.isEmpty) {
          context.read<HideCubit>().hide();
        }
      }
    };

    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _stripeBloc.close();
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    searchText.dispose();
    super.dispose();
  }

  Future<void> _refreshMedia() {
    final bloc = context.read<MediaBloc>();
    return refreshBlocState<MediaState>(
      bloc: bloc,
      dispatch: () => bloc.add(const MediaEvent.media()),
      isLoading: (state) => state.status.isLoading,
    );
  }

  Widget _refreshableMessage(String message) {
    return RefreshIndicator.adaptive(
      onRefresh: _refreshMedia,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 260,
            child: Center(
              child: Text(
                message,
                style: context.textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HideCubit, bool>(
      builder: (context, reveal) {
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
                    searchField(controller: searchText, focusNode: _focusNode),
                    const SizedBox(height: kMedium),
                    reveal
                        ? const SizedBox.shrink()
                        : const SizedBox(height: kMedium),
                    const SizedBox(height: kMedium),
                    Expanded(
                      child: BlocBuilder<MediaBloc, MediaState>(
                        builder: (context, state) {
                          switch (state.status) {
                            case MediaStatus.loading:
                              return const Center(
                                  child: CircularProgressIndicator());

                            case MediaStatus.failure:
                              return _refreshableMessage(
                                state.failure?.error ??
                                    "Unable to load media right now.",
                              );

                            case MediaStatus.success:
                              if (state.media.isEmpty) {
                                return _refreshableMessage("No Media");
                              }

                              final mediaData = state.media.first;

                              return RefreshIndicator.adaptive(
                                onRefresh: _refreshMedia,
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // RecentHighlightsList(
                                      //     highlights: mediaData.recentHighlights),
                                      // const SizedBox(height: 24),
                                      SeasonHighlightsList(
                                          seasonHighlights:
                                              mediaData.seasonHighlights),
                                    ],
                                  ),
                                ),
                              );

                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Row headerSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor =
        isDark ? AppColors.whiteColor.withValues(alpha: 0.3) : Colors.white;
    final iconColor =
        isDark ? AppColors.whiteColor : Theme.of(context).colorScheme.onSurface;
    final titleColor =
        isDark ? Colors.white : Theme.of(context).colorScheme.onSurface;
    final subtitleColor = isDark
        ? Colors.white70
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppBackButton(),
        Column(
          children: [
            Text(
              'Team Media',
              style: TextStyle(
                color: titleColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'All Media Highlights',
              style: TextStyle(color: subtitleColor, fontSize: 12),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.pushNamed(AppRoute.notifications.name),
          child: Container(
            padding: const EdgeInsets.all(kSmall),
            decoration: BoxDecoration(
              color: chipColor,
              shape: BoxShape.circle,
            ),
            child: Icon(LucideIcons.bell, color: iconColor),
          ),
        )
      ],
    );
  }

  TextField searchField({
    required FocusNode focusNode,
    required TextEditingController controller,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.whiteColor : const Color(0xFFDADADA);
    final fillColor =
        isDark ? AppColors.whiteColor.withValues(alpha: 0.2) : Colors.white;
    final iconColor =
        isDark ? AppColors.whiteColor : Theme.of(context).colorScheme.onSurface;
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: kSmall),
          child: Icon(LucideIcons.search, color: iconColor),
        ),
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(kXXXXLarge),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kMedium,
          vertical: kXLMedium * 0.9,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kXXXXLarge),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kXXXXLarge),
          borderSide: BorderSide(color: borderColor),
        ),
        hintText: "Search",
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: isDark ? const Color(0xffcfcdcd) : const Color(0xFF9A9A9A),
        ),
      ),
    );
  }
}

Row RowIconButton(IconData icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon),
      const SizedBox(width: kSMedium),
      Text(text, style: const TextStyle(fontSize: 14)),
    ],
  );
}
