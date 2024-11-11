import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';

import '../../common/dimens.dart';
import '../../theme/app_colors.dart';
import 'login_page2.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AppBackground(),
      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all( kMedium),
          width: double.infinity,
          height: 634,
          child: Column(
            children: [
              LoginSignUpSwitch(context, false),
              SizedBox(height: kLarge,),
              Text("Welcome!",style: TextStyle(fontSize: kMedium,fontWeight: FontWeight.bold,color: Color(0xFF696565)),),
              SizedBox(height: kLarge,),
              Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Align(alignment: Alignment.centerLeft,child: Text("First Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF696565)))),
                      SizedBox(height: 9,),
                      CustomTextField(true,"Jina Langu"),
                    ],
                  )),
                  SizedBox(width: kMedium,),
                  Expanded(child: Column(
                    children: [
                      Align(alignment: Alignment.centerRight,child: Text("Other Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF696565)))),
                      SizedBox(height: 9,),
                      CustomTextField(true,""),
                    ],
                  ))
                ],
              ),

              SizedBox(height: 9,),
              Align(alignment: Alignment.centerLeft,child: Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF696565)))),
              SizedBox(height: 9,),
              CustomTextField(true,"jina@email.com"),
              SizedBox(height: 13,),
              Align(alignment: Alignment.centerLeft,child: Text("Password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF696565)))),
              SizedBox(height: 9,),
              CustomTextField(false,"**********"),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (onChanged){}),
                  Text('Agree to Terms & Conditions',style: TextStyle(fontSize: 12),)
                ],
              ),
              SizedBox(height: kLarge,),
              GestureDetector(
                  onTap: (){
                    context.go("/otp");
                  },
                  child: CustomFilledButton('Sign Up')
              ),
              SizedBox(height: 12,),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56),side: BorderSide(color: Color(0xFF414141)),shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMedium))),
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/googlelogo2.png",height: kLarge,),
                      SizedBox(width: 12,),
                      Text('Sign In with Google',style: TextStyle(color: Color(0xFF525252),fontSize: 13),)
                    ],
                  ))
            ],
          ),
        ),
      ),

    );
  }
}
