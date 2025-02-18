part of "team.dart";

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController=TabController(initialIndex:1,length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        childWidget: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: kSMedium),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              )
            ),
            child: Column(
              children: [
                const SizedBox(height: 39,),
                Text("Team",style: context.textTheme.headlineLarge?.copyWith(fontSize: 16),),
                const SizedBox(height: 20,),
                TabBar(
                  dividerColor: AppColors.greyColor,
                  unselectedLabelStyle: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w500,fontSize: 10,color: AppColors.greyColor,letterSpacing: 1),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4,color: AppColors.blackColor),
                    borderRadius: const BorderRadius.only(
                      topLeft:Radius.circular(3),
                      topRight: Radius.circular(3)
                    )
                  ),
                  labelStyle: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w700,fontSize: 10,color: AppColors.darkColor,letterSpacing: 1),

                  controller: tabController,
                    tabs: [
                  Tab(text: 'ROSTER',),
                  Tab(text: 'STATS',),
                  Tab(text: 'STANDINGS'),
                ]),
                Expanded(child: TabBarView(
                    controller: tabController,
                    children: [
                      TeamRoster(),
                      TeamStats(),
                      TeamStandings(),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}