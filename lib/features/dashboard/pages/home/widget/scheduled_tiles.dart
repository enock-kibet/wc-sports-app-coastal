part of '../home_page.dart';

class ScheduledTiles extends StatelessWidget {
  final MatchType match;
  const ScheduledTiles({required this.match,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
            AppRoute.matchDetails.name,
            extra: match
        );
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 14),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12)
          ),
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                              height: 17,
                              width: 33,
                              decoration: const BoxDecoration(
                                  border: Border(
                                    top:BorderSide(color: Color(0xff2d2d2d)),
                                    right:BorderSide(color: Color(0xff2d2d2d)),
                                    left: BorderSide(color: Color(0xff2d2d2d)),
                                  ),
                                  color: Color(0xff2d2d2d),
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(4),topLeft: Radius.circular(4))
                              ),
                              child: Center(
                                child: Text(truncateText(monthMap[match.matchDate.month].toString().toTitleCase(),limit: 3,show: false),style: context.textTheme.labelSmall?.copyWith(color: AppColors.whiteColor),
                                ),
                              )
                          ),
                          Container(
                              height: 17,
                              width: 33,
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom:BorderSide(color: Color(0xff2d2d2d)),
                                    right:BorderSide(color: Color(0xff2d2d2d)),
                                    left: BorderSide(color: Color(0xff2d2d2d)),
                                  ),
                                  color: const Color(0xffd9d9d9),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(4),bottomLeft: Radius.circular(4))
                              ),
                              child: Center(
                                child: Text(match.matchDate.day.toString(),style: context.textTheme.labelSmall?.copyWith(color: Color(0xff2d2d2d)),
                                ),
                              )
                          )
                        ],
                      ),
                      const SizedBox(width: 13,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(getStringDate(match.matchDate,withoutWeekday: true),style: TextStyle(color: Color(0xff2d2d2d),fontSize: 10,fontWeight: FontWeight.w400),),
                          SizedBox(height: 7,),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Color(0xff2d2d2d),fontWeight: FontWeight.w400, fontSize: 10), // Default style
                              children: [
                                TextSpan(text: "${match.matchLocation} - "),// Regular text
                                TextSpan(
                                  text: truncateText(match.matchVenue),// Bold text
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text("Ksh ${match.matchPrice}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 9),)

                ],
              ),
              SizedBox(height: 11,),
              DottedDivider(),
              SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.defaultAppRed,
                            radius: 10,
                            child: Text(match.teamOne.split(' ').first[0].toUpperCase()+match.teamOne.split(' ').last[0],style:TextStyle(fontSize: 8,fontWeight: FontWeight.w600),),
                          ),
                          const SizedBox(width: kXSmall),
                          Text(truncateText(match.teamOne),style: context.textTheme.bodySmall,)
                        ],
                      ),
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.purpleColor,
                            radius: 10,
                            child: Text(match.teamTwo.split(' ').first[0].toUpperCase()+match.teamTwo.split(' ').last[0],style:TextStyle(fontSize: 8,fontWeight: FontWeight.w600),),

                          ),
                          const SizedBox(width: kXSmall),
                          Text(truncateText(match.teamTwo),style: context.textTheme.bodySmall,)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 102,
                    child: CustomisableFilledButton("Buy Ticket",true,48,12),
                  )
                ],
              )


            ],
          )
      ),
    );
  }
}
