part of "player.dart";

class PlayerPage extends StatefulWidget {
  final PlayerProfileData player;
  const PlayerPage({super.key, required this.player});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}


class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin{
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
        childWidget: Stack(
          children: [
            SafeArea(child: RoundedtopContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 24,),
                    //Top navigation
                    TopNavigation(back: (){context.pop();},title: widget.player.name,),

                    const SizedBox(height: 16,),

                    //Player image
                    PlayerProfilePicture(player: widget.player,),

                    const SizedBox(height: 16,),

                    PlayerTab(tabController:tabController),

                    Expanded(
                      child: TabBarView(
                        controller:tabController,
                          children: [
                            PlayerStats(),
                            PlayerInfo(player: widget.player,),
                            PlayerMedia(),
                      
                          ]),
                    )

                  ],



                )))
          ],
        ),
      ),
    );
  }
}
