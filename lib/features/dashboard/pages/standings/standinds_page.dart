// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/theme/app_colors.dart';

class StandingPage extends StatefulWidget {
  const StandingPage({super.key});

  @override
  State<StandingPage> createState() => _StandingPageState();
}

class _StandingPageState extends State<StandingPage> {
  int selectedIndex = 0;
  Set<String> _selected = {"Standings"};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: kXSmall),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  imageStack(context),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/shirt.png'),
                        ),
                        Text("Afro Pacers",
                            style: TextStyle(
                                fontSize: kLarge, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: kMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SegmentedButton(
                      showSelectedIcon: false,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.purpleColor;
                          }
                          return AppColors.greyColor.withOpacity(0.3);
                        }),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        foregroundColor:
                            WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.whiteColor;
                          }
                          return null;
                        }),
                        side: WidgetStateProperty.all<BorderSide>(
                          BorderSide(
                              color: AppColors.greyColor.withOpacity(0.3)),
                        ),
                      ),
                      segments: const [
                        ButtonSegment<String>(
                          value: "Standings",
                          label: Text("Standings"),
                        ),
                        ButtonSegment<String>(
                          value: "Roster",
                          label: Text("Roster"),
                        ),
                      ],
                      selected: _selected,
                      onSelectionChanged: (Set<String> newSelection) async {
                        setState(() {
                          _selected = newSelection;
                          print(_selected);
                        });
                        if (newSelection.contains("Standings")) {
                          setState(() {
                            selectedIndex = 0;
                          });
                        } else {
                          setState(() {
                            selectedIndex = 1;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: kMedium,
              ),
              if(selectedIndex == 0)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: kMedium),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      horizontalMargin: 10,
                      dividerThickness: 0.5,
                      columnSpacing: 20,
                      showBottomBorder: false,
                      border: const TableBorder(
                          // top: BorderSide(color: Colors.grey, width: 0.5),
                          // bottom: BorderSide(color: Colors.grey, width: 0.5),
                          // left: BorderSide(color: Colors.grey, width: 0.5),
                          // right: BorderSide(color: Colors.grey, width: 0.5),
                          // horizontalInside:
                          //     BorderSide(color: Colors.grey, width: 0.5),
                          // verticalInside:
                          //     BorderSide(color: Colors.grey, width: 0.5),
                          ),
                      columns: const [
                        DataColumn(
                            label: Text(
                          "Pos",
                        )),
                        DataColumn(
                            label: Text(
                          "Team",
                        )),
                        DataColumn(
                            label: Text(
                          "Won",
                        )),
                        DataColumn(
                            label: Text(
                          "Lost",
                        )),
                        DataColumn(
                            label: Text(
                          "Draw",
                        )),
                        DataColumn(
                            label: Text(
                          "Points",
                        )),
                      ],
                      rows: List.generate(
                          standingData.length,
                          (index) => productDataRow(
                              standingData[index], index, context))),
                ),
              ),
              if(selectedIndex == 1)

              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: kMedium),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      horizontalMargin: 10,
                      dividerThickness: 0.5,
                      columnSpacing: 20,
                      showBottomBorder: false,
                      border: const TableBorder(
                          // top: BorderSide(color: Colors.grey, width: 0.5),
                          // bottom: BorderSide(color: Colors.grey, width: 0.5),
                          // left: BorderSide(color: Colors.grey, width: 0.5),
                          // right: BorderSide(color: Colors.grey, width: 0.5),
                          // horizontalInside:
                          //     BorderSide(color: Colors.grey, width: 0.5),
                          // verticalInside:
                          //     BorderSide(color: Colors.grey, width: 0.5),
                          ),
                      columns: const [
                        DataColumn(
                            label: Text(
                          "Team",
                        )),
                        DataColumn(
                            label: Text(
                          "Position",
                        )),
                        DataColumn(
                            label: Text(
                          "Won",
                        )),
                        DataColumn(
                            label: Text(
                          "Lost",
                        )),
                        DataColumn(
                            label: Text(
                          "Draw",
                        )),
                        DataColumn(
                            label: Text(
                          "Points",
                        )),
                      ],
                      rows: List.generate(
                          standingData.length,
                          (index) => productDataRow(
                              standingData[index], index, context))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow productDataRow(
      StandingModel productData, index, BuildContext context) {
    return DataRow(selected: true, cells: [
      DataCell(Text(productData.position!)),
      DataCell(Text(productData.team!)),
      DataCell(Text(productData.won.toString())),
      DataCell(Text(productData.lost.toString())),
      DataCell(Text(productData.draw.toString())),
      DataCell(Text(productData.points!.toString())),
    ]);
  }

  Stack imageStack(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image.asset(
              "assets/images/Rectangle4.png",
              fit: BoxFit.cover,
              height: 200,
              width: context.width,
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
        Positioned(
          top: kSmall,
          left: kMedium,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                padding: const EdgeInsets.all(kSmall),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.3),
                    shape: BoxShape.circle),
                child: Icon(
                  LucideIcons.arrowLeft,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StandingModel {
  final String? position;
  final String? team;
  final int? won;
  final int? lost;
  final int? draw;
  final int? points;

  StandingModel(
      {required this.position,
      required this.team,
      required this.won,
      required this.lost,
      required this.draw,
      required this.points});
}

List<StandingModel> standingData = [
  StandingModel(
      position: "1", team: "AfroPacers", won: 6, lost: 1, draw: 0, points: 13),
  StandingModel(
      position: "2", team: "Mamluki", won: 4, lost: 2, draw: 0, points: 10),
  StandingModel(
      position: "3",
      team: "Kirinyaga Bulls",
      won: 4,
      lost: 0,
      draw: 0,
      points: 8),
  StandingModel(
      position: "4", team: "Ugwaro Nets", won: 4, lost: 0, draw: 0, points: 0),
  StandingModel(
      position: "5", team: "Kicks Kenya", won: 4, lost: 0, draw: 0, points: 0),
  StandingModel(
      position: "6", team: "Rongai Lions", won: 3, lost: 0, draw: 0, points: 0),
  StandingModel(
      position: "7",
      team: "Chamani Ballers",
      won: 2,
      lost: 0,
      draw: 0,
      points: 0),
  StandingModel(
      position: "8",
      team: "Kibera's Finest",
      won: 2,
      lost: 0,
      draw: 0,
      points: 0),
];
