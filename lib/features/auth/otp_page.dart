import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/features/auth/login_page2.dart';

import '../../common/dimens.dart';
import '../../theme/app_colors.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const AppBackground(),
      bottomSheet: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: kLarge,vertical: kMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('One Time Password Verification',style: TextStyle(fontSize: kMedium,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text('Enter the 5 Digit Code Sent to your Email & Phone Number',style: TextStyle(fontSize: kSMedium),),
              SizedBox(height: 20,),
              PinCodeTextField(appContext: context, length: 5,backgroundColor: AppColors.inputFillColor,pinTheme: PinTheme(shape: PinCodeFieldShape.box,borderRadius: BorderRadius.circular(12),fieldHeight: 48,fieldWidth: 48),),
              SizedBox(height: 56,),
              GestureDetector(
                onTap: (){context.go("/home");},
                child: CustomFilledButton('Verify OTP')
              )

            ],
          ),
        ),
      ),
    );
  }
}
