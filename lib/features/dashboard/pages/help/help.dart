import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/huge_icon_button.dart';

import '../../../../theme/app_colors.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool showAccountSettings=false;
  bool showPasswordSettings=false;
  bool showSharingMedia=false;
  bool showSavingGames=false;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: AppBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(0).copyWith(top:MediaQuery.of(context).viewPadding.top+kSmall),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kXLarge),
                    topRight: Radius.circular(kXLarge)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kLarge,horizontal: kXLMedium),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        IconButton.filledTonal(
                            onPressed: ()=> context.pop(),
                            icon:  Icon(Icons.arrow_back,color: AppColors.inputFillColor,),
                          style: IconButton.styleFrom(backgroundColor: Color(0XFF999999),fixedSize: Size(48, 48)),
                        ),
                        Align(alignment: Alignment.center,child: Text("Help",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:AppColors.darkColor),))
                      ],
                    ),
                     const SizedBox(height: kXXXXLarge,),
                    Accordion(
                      state:showAccountSettings,
                      onTap: (){setState(() {showAccountSettings=!showAccountSettings;});},
                    ),
                    Accordion(
                        state:showPasswordSettings,
                        onTap: (){setState(() {showPasswordSettings=!showPasswordSettings;});},
                        title: "Help with changing my password"
                    ),
                    Accordion(
                        state:showSharingMedia,
                        onTap: (){setState(() {showSharingMedia=!showSharingMedia;});},
                        title: "Help with sharing media"
                    ),
                    Accordion(
                        state:showSavingGames,
                        onTap: (){setState(() {showSavingGames=!showSavingGames;});},
                        title: "Help with saving games?"
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Accordion({required bool state, required VoidCallback onTap, double? height,String? title}){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        onTap: ()=> onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title??'Help with setting up my Account',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:Color(0XFF585C60)),),
            Icon(state?Icons.keyboard_arrow_down:Icons.chevron_right)
          ],
        ),
      ),
      AnimatedContainer(
          padding: const EdgeInsets.only(top:kSmall),
          duration: const Duration(milliseconds: 400),
          height:state?96:0,
          child: const SingleChildScrollView(
            child: Column(
              children: [
                Text("Help with Setting up my account,Help with Setting up my account,Help with Setting up my account,Help with Setting up my account,Help with Setting up my account,Help with Setting up my account,Help with Setting up my account,Help with Setting up my account",style: TextStyle(fontSize: kSMedium,),),
              ],
            ),
          )
      ),
      Divider(color:Color(0xFFc4c4c4),endIndent: kSmall,),
      const SizedBox(height: 14,)
    ],
  );
}