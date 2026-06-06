import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/common/utils/pull_to_refresh.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/models/stripe_checkout/stripe_checkout.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/features/app/blocs/matches/match_schedule/schedule_bloc.dart';
import 'package:sports_app/features/app/blocs/notifications/notification_bloc.dart';
import 'package:sports_app/features/app/blocs/stripe/stripe_bloc.dart';
import 'package:sports_app/features/app/side_menu_cubit.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/features/dashboard/pages/notifications/widgets/notifications_card.dart';
import 'package:sports_app/features/dashboard/pages/pages.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:sports_app/utils/dotted.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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

  Future<void> _refreshNotifications() {
    final bloc = context.read<NotificationBloc>();
    return refreshBlocState<NotificationState>(
      bloc: bloc,
      dispatch: () => bloc.add(const NotificationEvent.notifications()),
      isLoading: (state) => state.status.isLoading,
    );
  }

  Widget _refreshableMessage(String message) {
    return RefreshIndicator.adaptive(
      onRefresh: _refreshNotifications,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 220,
            child: Center(child: Text(message)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HideCubit, bool>(builder: (context, reveal) {
      return Scaffold(
        body: AppBackground(
          childWidget: SafeArea(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kMedium),
            child: Column(
              children: [
                const SizedBox(height: kMedium),
                headerSection(context),
                const SizedBox(height: kMedium),
                reveal ? Container() : const SizedBox(height: kMedium),
                reveal
                    ? Container()
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Clear All",
                          style: context.textTheme.headlineSmall?.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface),
                        )),
                Expanded(
                  child: BlocBuilder<NotificationBloc, NotificationState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case NotificationStatus.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case NotificationStatus.failure:
                          return _refreshableMessage(state.failure!.error);
                        case NotificationStatus.success:
                          if (state.notifications.isEmpty) {
                            return _refreshableMessage("No Notifications");
                          }

                          return BlocBuilder<NotificationBloc,
                              NotificationState>(
                            builder: (context, state) {
                              switch (state.status) {
                                case NotificationStatus.success:
                                  return SafeArea(
                                    child: RefreshIndicator.adaptive(
                                      onRefresh: _refreshNotifications,
                                      child: SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: kMedium),
                                            //TODO! Add upcoming matches
                                            AutoHeightGridView(
                                              itemCount:
                                                  state.notifications.length,
                                              crossAxisCount:
                                                  context.isTablet ? 1 : 1,
                                              mainAxisSpacing: kSmall,
                                              crossAxisSpacing: kSmall,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              builder: (context, index) {
                                                final notification =
                                                    state.notifications[index];
                                                return NotificationsCard(
                                                    notification: notification);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                case NotificationStatus.failure:
                                  return _refreshableMessage(
                                      state.failure!.error);
                                case NotificationStatus.loading:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                default:
                                  return const SizedBox.shrink();
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
        const AppBackButton(),
        Text(
          "Notifications",
          style: context.textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
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
