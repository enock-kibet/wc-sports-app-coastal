part of '../points_page.dart';

class TotalpointsCard extends StatelessWidget {
  final int totalpoints;
  const TotalpointsCard({super.key, required this.totalpoints});

  @override
  Widget build(BuildContext context) {
    return  RoundedContainer(
        height: 72,
        radius: 16,
        backgroundColor: Color(0xfff2f2f2),
        child: Center(
      child:Column(
        children: [
          Text(totalpoints.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
          Text("Total Points",style: TextStyle(fontSize: 12,color: Color(0xff191919)),),

        ],
      )
    ));
  }
}
