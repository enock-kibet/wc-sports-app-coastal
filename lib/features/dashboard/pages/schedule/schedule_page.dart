import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/features/app/blocs/product/match_bloc.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:sports_app/theme/theme.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime selectedDate=DateTime.now();
  DateTime today= DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          AppBackground(childWidget: Column(
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
                          onDateChange: (selectedDatee) {
                            selectedDate= selectedDatee;
                            context
                                .read<MatchBloc>()
                                .add(const MatchEvent.matches());
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
                  if(state.status==MatchStatus.loading){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(state.status==MatchStatus.failure){
                    return Center(child: Text(state.failure!.error),);
                  }
                  if(state.status==MatchStatus.success) {
                    //Check if date is not today
                    if(selectedDate.day != today.day){
                      return  Center(
                        child: Text("No Matches",style: TextStyle(color: AppColors.whiteColor),),
                      );
                    }

                    return Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          ...List.generate(state.matches.length, (index){
                            final match= state.matches[index];
                            return
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: kSmall,vertical: kSmall),
                                width: double.infinity,
                                padding: const EdgeInsets.all(kMedium),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(kMedium),
                                    color: AppColors.whiteColor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      match["name"],
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: kMedium, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: kSmall,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.map),
                                        SizedBox(
                                          width: kSmall,
                                        ),
                                        Text(match["venue"]["name"])
                                      ],
                                    ),
                                    const SizedBox(
                                      height: kMedium,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(kSmall),
                                          decoration: BoxDecoration(
                                              color: AppColors.greyColor.withOpacity(0.3),
                                              borderRadius: BorderRadius.circular(kMedium)),
                                          child: const Text("Friday, 27 Oct 2024",
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        const Text("Ksh500",
                                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                                            child: FilledButton(
                                                style: FilledButton.styleFrom(
                                                    minimumSize:
                                                    const Size(double.infinity, 50)),
                                                onPressed: () {},
                                                child: const Text("Buy Ticket")))
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
          ),)
    );
  }
}
