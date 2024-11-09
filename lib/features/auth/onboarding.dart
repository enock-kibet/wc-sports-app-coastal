import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool showNext = true;

  @override
  Widget build(BuildContext context) {
   final  viewPadding = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(top:viewPadding),
        child: SingleChildScrollView(
          child:Padding(
        padding:  EdgeInsets.symmetric(vertical:0,horizontal: kSmall),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  showNext= !showNext;
                });
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(kLarge)),
                    child: Image.asset(showNext?"assets/images/onboardingImage1.png":"assets/images/onboardingImage2.png",fit:BoxFit.fitWidth),
                  ),
                  SizedBox(height:kXXLarge),
                  SizedBox(
                    width: 320,
                      child: Column(
                        children: [
                          Text(showNext?"Follow Your Favourite Sports Teams":"Get Merchandise & Support Players Their Teams",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: kMedium,),
                          Text(showNext?'Follow and support your favourite sports teams, get updates on matches and performance':"Browse teams’ marketplace to find jerseys and other team associated merch",
                            style: TextStyle(fontSize:kSMedium,color: AppColors.hintTextColor ),
                          ),
                          SizedBox(height: kMedium,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 22,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    showNext?SmallRectangle():SmallCircle(),
                                    showNext?SmallCircle():SmallRectangle()
                                  ],
                                ),
                              ),
              
                              GestureDetector(
                                onTap: (){
                                  context.go("/signIn");
                                },
                                child: Container(
                                  height: kXXXLarge,
                                  width: kXXXLarge,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(kSMedium),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [AppColors.defaultAppRed,AppColors.defaultAppPurple,],
                                    )
                                  ),
                                  child: Icon(Icons.chevron_right,color:AppColors.inputFillColor,size: kXLarge,),
                                  ),
                              )
                            ],
                          )
                        ],
                      ))
              
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
SmallRectangle(){
  return Container(
    height:5,
    width: 15,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: AppColors.darkColor),
  );
}
SmallCircle(){
  return Container(
    height:5,
    width: 5,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: Color(0xFFD9D9D9)),
  );
}