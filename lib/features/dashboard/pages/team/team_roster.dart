part of 'team.dart';

class TeamRoster extends StatelessWidget {
  const TeamRoster({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  Padding(
      padding: const EdgeInsets.only(top: kMedium),
      child: SingleChildScrollView(
        child: Column(
          children:
            playerProfiles.map((player)=>
                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: PlayerProfile(
                      player: player,
                      context: context,
                  ),
                )
            ).toList()
        ),
      ),
    );
  }
}
Widget PlayerProfile({required BuildContext context,  required PlayerProfileData player}){
  return Material(
    color:Colors.transparent,
    clipBehavior: Clip.hardEdge,
    borderRadius: BorderRadius.circular(kMedium),
    child: InkResponse(
      onTap: (){
        context.pushNamed(AppRoute.playerProfile.name,extra: player );
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.greyColor
            ),
            borderRadius: BorderRadius.circular(kMedium)
        ),
        padding: EdgeInsets.symmetric(vertical:10 ,horizontal: 13),
        child: Row(
          children: [
            PlayerImage(image:player.imageUrl,height: 48,width: 48),
            SizedBox(width: 6,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(player.name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),
                Text("#${player.jerseyNumber}     ${player.height}     ${player.weight} KGS",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10,color: Color(0xff4d4d4d)))
              ],
            )
          ],
        ),
      ),
    ),
  );
}
final List<Map<String, String>> playersData = [
  {
    'name': 'Joel Embiid',
    'age': '30',
    'position': 'Center',
    'height': "7'0",
    'weight': '127.0',
    'experience': '10 Yrs',
    'jerseyNumber': '21',
    'homeTown': 'Philadelphia',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFE0jz6Nj4SM2KI9bQUHEP1Np6kz4ORam7SvJZg',
  },
  {
    'name': 'Pascal Siakam',
    'age': '29',
    'position': 'Forward',
    'height': "6'9",
    'weight': '104.3',
    'experience': '7 Yrs',
    'jerseyNumber': '43',
    'homeTown': 'Douala, Cameroon',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFESyeaGcNMaVkg8LcEnhb7ierIQs0y2WpUDqdw',
  },
  {
    'name': 'Serge Ibaka',
    'age': '34',
    'position': 'Forward-Center',
    'height': "6'9",
    'weight': '107.0',
    'experience': '14 Yrs',
    'jerseyNumber': '9',
    'homeTown': 'Brazzaville, Congo',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEU6wOq7y5imEGzL0FtXKbZDYkxp1aNBvfAjus',
  },
  {
    'name': 'Bismack Biyombo',
    'age': '31',
    'position': 'Center',
    'height': "6'9",
    'weight': '115.0',
    'experience': '12 Yrs',
    'jerseyNumber': '8',
    'homeTown': 'Lubumbashi, DR Congo',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEHIEg4OMFwrgTP3v7M2exmFBC9AWqDGknItNZ',
  },
  {
    'name': 'Giannis Antetokounmpo',
    'age': '29',
    'position': 'Forward',
    'height': "6'11",
    'weight': '110.0',
    'experience': '11 Yrs',
    'jerseyNumber': '34',
    'homeTown': 'Athens, Greece',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFE3DT9QC01Mtrkouge2pV8WSa7GJDOlXcQ0Iw5',
  },
  {
    'name': 'Shai Gilgeous-Alexander',
    'age': '25',
    'position': 'Guard',
    'height': "6'6",
    'weight': '91.0',
    'experience': '6 Yrs',
    'jerseyNumber': '2',
    'homeTown': 'Toronto, Canada',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEwSu6v5nvyUTf8EC3Y2JPhuRAMwa4mz6Sl90x',
  },
  {
    'name': 'Bol Bol',
    'age': '24',
    'position': 'Center',
    'height': "7'3",
    'weight': '130.0',
    'experience': '5 Yrs',
    'jerseyNumber': '11',
    'homeTown': 'Khartoum, Sudan',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEBTRsyhI5p7wvr6z239JuObHKZF0QXtfRSngV',
  },
  {
    'name': 'Al-Farouq Aminu',
    'age': '33',
    'position': 'Forward',
    'height': "6'8",
    'weight': '102.1',
    'experience': '11 Yrs',
    'jerseyNumber': '8',
    'homeTown': 'Atlanta, Georgia',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEPAeXs0UIhsMHlXT1uySwVkaomgnGxq2Ubptj',
  },
  {
    'name': 'Clifford Rozier',
    'age': '45',
    'position': 'Forward',
    'height': "6'10",
    'weight': '116.0',
    'experience': '5 Yrs',
    'jerseyNumber': '54',
    'homeTown': 'Bradenton, Florida',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEwiRjdGnvyUTf8EC3Y2JPhuRAMwa4mz6Sl90x',
  },
  {
    'name': 'Mo Bamba',
    'age': '26',
    'position': 'Center',
    'height': "7'2",
    'weight': '104.0',
    'experience': '6 Yrs',
    'jerseyNumber': '5',
    'homeTown': 'Harlem, New York',
    'imageUrl': 'https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEnObUjiZ91JXbastMAxiE4v6SecZdj32nhKlW',
  },
];
final List<PlayerProfileData> playerProfiles = playersData
    .map((data) => PlayerProfileData.fromJson(data))
    .toList();
