part of 'team.dart';

class TeamRoster extends StatelessWidget {
  const TeamRoster({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  Padding(
      padding: const EdgeInsets.only(top: kMedium),
      child: SingleChildScrollView(
        child: Column(
          children: [
            PlayerProfile(name: "Mike Ligare"),
            PlayerProfile(name: "Cedric Omondi",height: "6'2"),
            PlayerProfile(name: "Taylor Okari"),
            PlayerProfile(name: "Alpha Ochoko"),
            PlayerProfile(name: "Rueben Muraya",height: "5'10"),
            PlayerProfile(name: "Obanda James"),
            PlayerProfile(name: "Michael Otieno"),
            PlayerProfile(name: "Isaac Muraya"),
            PlayerProfile(name: "Brian Kapten"),
            PlayerProfile(name: "Wence Simiyu"),
            PlayerProfile(name: "Laban Prog"),
            PlayerProfile(name: "Kisaka Bomboo"),
          ],
        ),
      ),
    );
  }
}
Widget PlayerProfile({String name="Jamal Kibet",String?height="5'11",String weight="78",String jerseyNumber="12"}){
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.greyColor
        ),
        borderRadius: BorderRadius.circular(kMedium)
    ),
    margin: EdgeInsets.only(bottom: 5),
    padding: EdgeInsets.symmetric(vertical:10 ,horizontal: 13),
    child: Row(
      children: [
        PlayerImage(height: 40,width: 40),
        SizedBox(width: 6,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),
            Text("#$jerseyNumber     $height     ${weight}KGS",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 8))
          ],
        )
      ],
    ),
  );
}