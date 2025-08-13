import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/buildcontext.dart';
import 'package:sports_app/data/models/match/match.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/matches/match_bloc.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    service<Talker>().info(getStringDate(DateTime.now()));

    return Scaffold(
        body: AppBackground(
      childWidget: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: kMedium, vertical: kLarge),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(kMedium),
                    bottomRight: Radius.circular(kMedium))),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Team Schedule",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: kMedium,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkColor),
                    ),
                    const SizedBox(
                      height: kSmall,
                    ),
                    EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      onDateChange: (selectedDate) {
                        context
                            .read<MatchBloc>()
                            .add(MatchEvent.datedMatch(date: selectedDate));
                      },
                      headerProps: const EasyHeaderProps(
                        monthPickerType: MonthPickerType.switcher,
                        dateFormatter: DateFormatter.fullDateDayAsStrMY(),
                      ),
                      dayProps: EasyDayProps(
                        dayStructure: DayStructure.dayStrDayNum,
                        activeDayStyle: DayStyle(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(kMedium)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.pinkColor,
                                AppColors.purpleColor,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: kMedium,
          ),
          BlocBuilder<MatchBloc, MatchState>(
            builder: (context, state) {
              if (state.status == MatchStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == MatchStatus.failure) {
                service<Talker>().error(state.failure!.error);
                return Center(
                  child: Text(state.failure!.error),
                );
              }
              if (state.status == MatchStatus.success) {
                service<Talker>().info(state.datedMatches.toString());
                //Check if date is not today
                // if(selectedDate.day != today.day){
                //   return  Center(
                //     child: Text("No Matches",style: TextStyle(color: AppColors.whiteColor),),
                //   );
                // }
                service<Talker>().info(state.datedMatches.length);
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      ...List.generate(state.datedMatches.length, (index) {
                        final match = state.datedMatches[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: kSmall, vertical: kSmall),
                          width: double.infinity,
                          padding: const EdgeInsets.all(kMedium),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kMedium),
                              color: AppColors.whiteColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                match.matchName,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: kSmall,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: kSMedium,
                                  ),
                                  SizedBox(
                                    width: kXSmall,
                                  ),
                                  Text(
                                    match.matchVenue,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: kMedium,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(kSmall),
                                    decoration: BoxDecoration(
                                        color: AppColors.greyColor
                                            .withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(kMedium)),
                                    child: Text(getStringDate(match.matchDate),
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700)),
                                  ),
                                  Text("Ksh ${match.matchPrice.toString()}",
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700)),
                                ],
                              ),
                              const SizedBox(
                                height: kLarge,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        LucideIcons.bookmark,
                                        color: AppColors.purpleColor,
                                      )),
                                  const SizedBox(
                                    width: kLarge,
                                  ),
                                  Expanded(
                                      child: CustomFilledButton("Buy Ticket"))
                                ],
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    ));
  }
}
