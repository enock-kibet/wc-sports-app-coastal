export './home_page.dart';
// return SingleChildScrollView(
// child: Column(
// children: [
// reveal?Container(): Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "Schedule",
// style: context.textTheme.headlineLarge?.copyWith(fontSize: 18,color: AppColors.whiteColor)),
// TextButton(
// onPressed: () {},
// child: Text("See All",
// style: TextStyle(
// color: AppColors.whiteColor)))
// ],
// ),
// reveal?Container():const SizedBox(height: kSMedium),
// //TODO! Add schedules
//reveal?Container():schedules(matches: state.matches),
// const SizedBox(height: kMedium),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "Upcoming Matches",
// style: TextStyle(
// fontSize: kMedium,
// fontWeight: FontWeight.w700,
// color: AppColors.whiteColor),
// ),
// TextButton(
// onPressed: () {},
// child: Text("See All",
// style: TextStyle(
// color: AppColors.whiteColor)))
// ],
// ),
// const SizedBox(height: kMedium),
// //TODO! Add upcoming matches
// AutoHeightGridView(
// itemCount:!reveal? state.matches.length:state.searchedMatches.length,
// crossAxisCount: context.isTablet ? 3 : 2,
// mainAxisSpacing: kSmall,
// crossAxisSpacing: kSmall,
// physics: const BouncingScrollPhysics(),
// padding: EdgeInsets.zero,
// shrinkWrap: true,
// builder: (context, index) {
//
// final match =!reveal? state.matches[index]:state.searchedMatches[index];
// return ProductCard(match: match);
// },
// ),
// ],
// ),
// )