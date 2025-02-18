part of 'team.dart';

class TeamStats extends StatelessWidget {
  const TeamStats({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 16,),
        TeamSummaryStats(),
        const SizedBox(height: kMedium,),

        const Align(alignment:Alignment.centerLeft ,child: Text("Team Stat Leaders",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14))),
        const SizedBox(height: kSmall,),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StatCard(),
                const SizedBox(height: kSmall,),
                StatCard(Category: "Assists"),
                const SizedBox(height: kSmall,),
                StatCard(Category: "Rebounds"),
                const SizedBox(height: kSmall,),
                StatCard(Category: "Freethrows"),
                const SizedBox(height: kSmall,),
                StatCard(Category: "TurnOvers"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
Widget CardComponent(int Position, String Category) {
  // Convert the Position into an ordinal string like "1st", "2nd", "3rd", etc.
  String position = switch (Position) {
    1 => "1st",
    2 => "2nd",
    3 => "3rd",
    _ => "$Position" + "th", // Default case for other numbers
  };

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // Use the position string dynamically here
      Text(position, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff0F0C2E))),
      SizedBox(height: 4),
      Text(Category, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)),
    ],
  );
}
Widget TeamStatValues({String Category="Points", String?name =null,String?details=null,bool? alternate=false}){
  return alternate?? true? Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(name??"2. Kenya Moja",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xff4d4d4d)),),
      SizedBox(height: kXXSmall,),
      Text((details??"16.7")+" $Category Per Game",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w400,color: Color(0xff4d4d4d)),)
    ],
  ): Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(name??"1. Jamal Kibet",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),),
      Text((details??"18.2")+" $Category Per Game",style: TextStyle(fontSize: 8,fontWeight: FontWeight.w400),)
    ],
  );
}
Widget PlayerImage({double? width= null,double? height= null,}){
  return ClipRRect(
      borderRadius:BorderRadius.circular(6),
      child:CachedNetworkImage(
        imageUrl: "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFECvXPwxg2DKTQP5rMpfbGiAYNsaRkeLdJv1Uw",
        errorWidget: (context, url, error) => Icon(Icons.person,size: 48,color: AppColors.whiteColor,),
        width: width??116,
        height: height??144,
        fit: BoxFit.cover,
      )

  );
}
Widget StatCard({String Category="Points"}){
  return Container(
    padding: const EdgeInsets.symmetric(vertical: kSmall,horizontal: kSMedium),
    decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.greyColor,
            width: 0.5
        ),
        borderRadius: BorderRadius.circular(kMedium)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Category,style: TextStyle(fontWeight:FontWeight.w600,fontSize: kSMedium)),
        const SizedBox(height: kSMedium,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height:144,
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TeamStatValues(Category: Category),
                  SizedBox(height: kSMedium,),
                  TeamStatValues(Category: Category,alternate: true),
                  SizedBox(height: kSMedium,),
                  TeamStatValues(Category: Category,alternate: true,name:"3. Ben Frank",details:"15.5" ),
                  SizedBox(height: kSMedium,),
                  TeamStatValues(Category: Category,alternate: true,name: "4. Elisha Oloo",details: "14.3")
                ],
              ),
            ),
            PlayerImage()
          ],
        ),
      ],
    ),
  );
}
Widget TeamSummaryStats(){
  return Card(
    margin: EdgeInsets.zero,
    color: const Color(0xfff2f2f2),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CardComponent(1, "Points"),
          CardComponent(2, "Assists"),
          CardComponent(1, "Rebounds"),
          CardComponent(3, "Freethrows"),
          CardComponent(1, "Turnovers")

        ],
      ),

    ),
  );
}
