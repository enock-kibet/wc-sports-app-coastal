import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'match.freezed.dart';
part 'match.g.dart';

@freezed
class MatchType with _$MatchType {
  const factory MatchType({
    required String matchId,
    required String teamOne,
    required String teamTwo,
    required String matchName,
    required String matchDescription,
    required DateTime matchDate,
    required String matchVenue,
    required String matchLocation,
    required double matchPrice
  }) = _MatchType;
  factory MatchType.fromJson(Map<String,Object?> json)
  =>_$MatchTypeFromJson(json);
}
int getRandomMultipleOf50() {
  Random random = Random();
  int min = 400;
  int max = 1000;

  // Generate a random index from 8 to 20 (because (400/50) = 8, (1000/50) = 20)
  int randomIndex = random.nextInt((max ~/ 50) - (min ~/ 50) + 1) + (min ~/ 50);

  return randomIndex * 50; // Convert back to a multiple of 50
}

String getStringDate(DateTime date,{bool withoutWeekday = false}){
  const weekDayMap={
    7:"Sunday",
    1:"Monday",
    2:"Tuesday",
    3:"Wednesday",
    4:"Thursday",
    5:"Friday",
    6:"Saturday"
  };
  const monthMap ={
    1:"January",
    2:"February",
    3:"March",
    4:"April",
    5:"May",
    6:"June",
    7:"July",
    8:"August",
    9:"September",
    10:"October",
    11:"November",
    12:"December"
  };

  return withoutWeekday?"${date.day} ${monthMap[date.month]} ${date.year}":"${weekDayMap[date.weekday]},${date.day} ${monthMap[date.month]} ${date.year}";
}
const listOfImageUrls=[
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEMO1n0PJzwIpKtOcFxk9NAnBQ2lrmWf6hEb4u",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEFXOpUtBCTXwaW0LUB6jPE8NQ9IVsoZfG3KMh",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEeEqxVC65dcszXVnI1bTiSy9tAFfD8oKMBPa3",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEMyEMN6zwIpKtOcFxk9NAnBQ2lrmWf6hEb4uU",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEgukbhZ4X6HlP1cbB2p4EGCv9TJRWqzgIuf3k",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEfBCScuEsNXf5ecod9q8taORQ2AnYu30BErkJ",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEsxiS43vz0tYqVlxs73OUwoEeFyAWBPvR6gD9",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFENd4e6tjicMNa8GrjoPCQ6JlFw5XfmAYndyDV",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEHWRThuFwrgTP3v7M2exmFBC9AWqDGknItNZ1",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEqwNWAD3MXzlQamCjBo7pevHuRES2TNZrsFIJ",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEpuPe4hQd48iekELmqVsw0HJjY1DKpgxu3WQZ",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEvsSKleWOGDepnWTk257ytLoZHB4j8Y1Mu3aS",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEZCdbIKihcQenV5zqlkG2ryHPTiIjNBtdYD4b",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEjTLabLgmxugFUr7RAv6qzCJEnHQ5Y9e1MTZa",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEnf2d3lZ91JXbastMAxiE4v6SecZdj32nhKlW",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEc0muy8iqsWCJRYDlwh2HL6nTGPSyF9du7A8f",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEIen4mzfb4VJoGHZi69nWThmweMCr2Y8RzudF",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFE58xGKBYpGSBN1KMaRYQ2mLfX07csAhjZlqHC",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFE4puvo4C2cHkNtG0UMoxD9LmVqj5l6EvBXYAa",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEBkZMpkI5p7wvr6z239JuObHKZF0QXtfRSngV",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFE03R5XkSM2KI9bQUHEP1Np6kz4ORam7SvJZgx",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFE3NvSGRM01Mtrkouge2pV8WSa7GJDOlXcQ0Iw",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEpsvcCIzQd48iekELmqVsw0HJjY1DKpgxu3WQ",
  "https://y2tsq5l02b.ufs.sh/f/m2LAP0R1sVFEqn24ZD3MXzlQamCjBo7pevHuRES2TNZrsFIJ",
  // "",
  // "",
  // "",
  // "",
  // "",
  // "",
  // "",
];
String RandomImageUrl(){
  int randomValue = Random().nextInt(listOfImageUrls.length);
  return listOfImageUrls[randomValue];
}
bool onTheSameDay({required DateTime? requiredDate, required DateTime dateToCompare}){
  DateTime date = requiredDate??DateTime.now();
  return date.year == dateToCompare.year && date.month == dateToCompare.month && date.day == dateToCompare.day;
}
