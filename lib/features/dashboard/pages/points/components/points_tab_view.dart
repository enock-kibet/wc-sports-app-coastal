part of '../points_page.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;
  final List<PointsData> pointsHistoryList;
  final String balance;

  const CustomTabBarView(
      {super.key,
      required this.tabController,
      required this.pointsHistoryList,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: [
      ListView(
          children: pointsHistoryList
              .map((data) => PointsCard(pointsCardData: data))
              .toList()),
      SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PointsDistributionBreakDown(
                title: 'Point Gain Breakdown',
                breakdown: [
                  ['Follow social media page', '2', 'Points'],
                  ['Buy a game ticket', '2', 'Points per ticket'],
                  ['Share team media', '2', 'Points']
                ]),
            const PointsDistributionBreakDown(
                title: 'Point Redeeming',
                breakdown: [
                  ['For merchandize:', '250', 'Minimum'],
                  ['For game ticket:', '100', 'Minimum'],
                ]),
            const PointsDistributionBreakDown(
                title: 'Point Transfer',
                breakdown: [
                  ['To Friends', '100', 'Minimum'],
                ]),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: GradientFilledButton(
                  text: "Transfer",
                  onPressed: () {
                    showTransferPointsBottomSheet(context, balance);
                  },
                  radius: 18,
                ))
              ],
            ),
          ],
        ),
      )
    ]);
  }
}

class PointsCard extends StatelessWidget {
  final PointsData pointsCardData;

  const PointsCard({super.key, required this.pointsCardData});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
        margin: EdgeInsets.only(bottom: 12),
        height: 60,
        radius: 16,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        backgroundColor: Theme.of(context).colorScheme.surface,
        showBorder: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PointCardIcon(type: PointCardType.SHARED_TICKET),
            PointCardTexts(
              type: PointCardType.SHARED_TICKET,
              points: pointsCardData,
              date: pointsCardData.pointtimestamp.toString(),
              values: {
                "points": pointsCardData.actualpoint,
                "txType": pointsCardData.txType
              },
            )
          ],
        ));
  }
}

enum PointCardType {
  SHARED_TICKET("Tickets Bought", ["Type: {txType}", "Points: {points}"]),
  redeem("Redeemed Points", ["Points: {points}", "Prize: {prize}"]),
  SHARED_IG_ACCOUNT("Shared IG Account", ["Points: +{points}"]),
  followed("Followed IG Account", ["Points: +{points}"]);

  final String title;
  final List<String> subtitle;

  /// Method to replace placeholders in subtitles
  List<String> formattedSubtitles(Map<String, dynamic> values) {
    return subtitle.map((text) {
      values.forEach((key, value) {
        text = text.replaceAll('{$key}', value.toString());
      });
      return text;
    }).toList();
  }

  const PointCardType(this.title, this.subtitle);
}

class PointCardIcon extends StatelessWidget {
  final PointCardType type;
  final Color bgColor;
  const PointCardIcon(
      {super.key,
      this.type = PointCardType.SHARED_TICKET,
      this.bgColor = const Color(0xffefebf7)});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 48,
      width: 48,
      isCircle: true,
      backgroundColor:
          type == PointCardType.redeem ? Color(0xfff9dce2) : bgColor,
      child: Center(
          child: SvgPicture.asset(
        "assets/icons/ticket.svg",
        height: 24,
      )),
    );
  }
}

class PointCardTexts extends StatelessWidget {
  final PointCardType type;
  final PointsData points;
  final Map<String, dynamic> values; // Dynamic values for subtitles
  PointCardTexts(
      {super.key,
      this.type = PointCardType.followed,
      required this.points,
      this.values = const {"ticketCount": 2, "amount": 500, "points": 10},
      String? date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: SizedBox(
        height: 36,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              points.action == "SHARED_TICKET"
                  ? "Shared Ticket"
                  : points.action == "SHARED_IG_ACCOUNT"
                      ? "Shared IG Account"
                      : points.action,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(type.formattedSubtitles(values).join(" | "),
                style: TextStyle(fontSize: 11))
            // Row(
            //
            //    children: type.formattedSubtitles(values).map((element)=>Text('$element ',style: TextStyle(fontSize: 11),)).toList()
            //
            // )
          ],
        ),
      ),
    );
  }
}

class RowOfText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final int number;
  const RowOfText(
      {super.key,
      this.firstText = "Follow social media page",
      this.secondText = "points",
      this.number = 2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text(
            firstText,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
          ),
          Spacer(),
          SizedBox(
            width: 120,
            child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface),
                    text: "+$number ",
                    children: [
                  TextSpan(
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).colorScheme.onSurface),
                      text: secondText)
                ])),
          )
        ],
      ),
    );
  }
}

class PointsDistributionBreakDown extends StatelessWidget {
  final String title;
  final List<List<String>> breakdown;
  const PointsDistributionBreakDown(
      {super.key, required this.title, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        ...breakdown.map((breakdown) => RowOfText(
              key: ValueKey(breakdown[0]),
              firstText: breakdown[0],
              number: int.parse(breakdown[1]),
              secondText: breakdown[2],
            )),
        const SizedBox(
          height: 16,
        ),
        const Divider(
          color: Color(0xFFc4c4c4),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}

String formatDate(DateTime date) {
  // Get the day and determine the suffix (st, nd, rd, th)
  int day = date.day;
  String suffix = getDaySuffix(day);

  // Format the month abbreviation
  String month = _monthAbbreviation(date.month);

  // Return formatted date
  return "$day$suffix $month ${date.year}";
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "th"; // Special case for 11th, 12th, 13th
  }
  switch (day % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}

String _monthAbbreviation(int month) {
  const List<String> months = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[month];
}
