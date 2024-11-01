import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/dimens.dart';
import '../../theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.defaultAppRed,AppColors.defaultAppPurple,],
            )
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all( kMedium),
          width: double.infinity,
          height: 536,
          child: Column(
            children: [
             LoginSignUpSwitch(context,true),
              SizedBox(height: kLarge,),
              Text("Welcome Back!",style: TextStyle(fontSize: kMedium,fontWeight: FontWeight.bold,color: Color(0xFF696565)),),
              SizedBox(height: kLarge,),
              Align(alignment: Alignment.centerLeft,child: Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF696565)))),
              SizedBox(height: 9,),
              CustomTextField(true,"jina@email.com"),
              SizedBox(height: 13,),
              Align(alignment: Alignment.centerLeft,child: Text("Password",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF696565)))),
              SizedBox(height: 9,),
              CustomTextField(false,"**********"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (onChanged){}),
                    Text('Remember Me',style: TextStyle(fontSize: kSMedium),)
                  ],
                ),
                  TextButton(onPressed: (){}, child: Text("Forgot Password",style: TextStyle(fontSize: kSMedium),))
              ],),
              SizedBox(height: kLarge,),
              GestureDetector(
                onTap: (){
                  context.go("/home");
                },
                child: CustomFilledButton('Sign In')
              ),
              SizedBox(height: kSMedium,),
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56),side: BorderSide(color: Color(0xFF414141)),shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMedium))),
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/googlelogo2.png",height: kLarge,),
                      SizedBox(width: kSMedium,),
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
CustomTextField( bool isEmail,String hintText){
  return TextField(
    obscureText: !isEmail,
    obscuringCharacter: "*",
    onTapOutside: (bool){
      FocusManager.instance.primaryFocus?.unfocus();
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(kMedium),borderSide: BorderSide(color:  Color(0xFFC6C6C6))),
      filled: false,
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 13,color: Color(0xFFC6C6C6)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(kMedium),borderSide: BorderSide(color: AppColors.primaryColor))
    ),
  );
}
//button with the app colors spanning entire width
CustomFilledButton(String buttonText){
  return Container(
    height: 56,
    width: double.infinity,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMedium),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.defaultAppRed,AppColors.defaultAppPurple,],
        )
    ),
    child: Center(child: Text(buttonText,style: TextStyle(color: AppColors.inputFillColor,fontSize: 18),)),
  );
}
LoginSignUpSwitch(BuildContext context,bool isSignInPage){
  return Container(
    padding: EdgeInsets.all(6 ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kLarge),
      color: Color(0xFFF0F0F0)
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: (){context.go('/signIn');},
          child: Container(
            alignment: Alignment.center,
            height: 32,
            width: 101,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kLarge),
                color:isSignInPage? Color(0xFF656060):Color(0xFFF0F0F0)
            ),
            child:Text("Login",style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,color: isSignInPage? AppColors.inputFillColor:Color(0xFF292323)),),
          ),
        ),
        GestureDetector(
          onTap: (){context.go('/signUp');},
          child: Container(
            alignment: Alignment.center,
            height: 34,
            width: 101,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kLarge),
                color: isSignInPage?Color(0xFFF0F0F0):Color(0xFF656060)
            ),
            child:Text("Sign Up",style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,color:isSignInPage?Color(0xFF292323):AppColors.inputFillColor),),
          ),
        )
      ],
    ),
  );
}