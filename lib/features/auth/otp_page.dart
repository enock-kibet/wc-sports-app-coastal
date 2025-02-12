import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/auth/auth_bloc.dart';
import 'package:sports_app/features/auth/login_page.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../common/dimens.dart';
import '../../theme/app_colors.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}


class _OtpPageState extends State<OtpPage> {
  late AuthBloc _authBloc;
  late TextEditingController _otpController;

  @override
  void initState() {
    _authBloc = AuthBloc();
    _otpController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _authBloc.close();
    _otpController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocConsumer<AuthBloc,AuthState>(
        bloc: _authBloc,
        listener: (context,state){
          if (state.status == AuthStatus.success) {
            String message;
            if(state.data is User){
              message = "Otp verified successfully";
            }else{
              message = state.data;
            }
            service<Talker>().info(message);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: AppColors.whiteColor,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );

          }
          if (state.status == AuthStatus.failure) {
            service<Talker>().error(state.failure!.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure!.error),
                backgroundColor: AppColors.dangerColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: AppColors.whiteColor,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }
        },
        builder: (context,state) {
          return const AppBackground();
        }
      ),
      bottomSheet: BlocBuilder<AuthBloc,AuthState>(
        bloc: _authBloc,
        builder: (context,state) {
          return SingleChildScrollView(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: kLarge,vertical: kMedium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('One Time Password Verification',style: TextStyle(fontSize: kMedium,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text('Kindly enter the 5 Digit OTP Code Sent to your Email Address',style: TextStyle(fontSize: kSMedium),),
                  SizedBox(height: 20,),
                  PinCodeTextField(controller: _otpController,appContext: context, length: 6,backgroundColor: AppColors.inputFillColor,pinTheme: PinTheme(shape: PinCodeFieldShape.box,borderRadius: BorderRadius.circular(12),fieldHeight: 48,fieldWidth: 48),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: state.status == AuthStatus.loading? null: (){
                            _authBloc.add(AuthEvent.resendOtp(request: {
                              "email":service<AppPreferencesManager>().currentUserValue?.email
                            }));
                          },
                          child: Text("Resend Code ?",))//style: TextStyle(fontSize: kSMedium,fontWeight: FontWeight.bold)))
                    ],
                  ),
                  SizedBox(height: 24,),
                  GestureDetector(
                    onTap: state.status == AuthStatus.loading?null:
                        (){
                            _authBloc.add(AuthEvent.verifyOtp(request: {
                              "otp":_otpController.text.trim(),
                              "email":service<AppPreferencesManager>().currentUserValue?.email
                            }));
                        },
                    child: CustomFilledButton(state.status == AuthStatus.loading?"Processing...":'Verify OTP')
                  ),
                  SizedBox(height: 20,),
                  Stack(
                      alignment: Alignment.center,
                      children: [
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Divider(color: AppColors.greyColor,thickness: .4,),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            color: Theme.of(context).colorScheme.surface,
                            child:Text("or",
                              style: TextStyle(fontSize: kSMedium,color: AppColors.greyColor),)

                        )
                      ]),

                  const SizedBox(height: 24),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.defaultAppRed,
                        minimumSize: const Size.fromHeight(48),
                        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.blackColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(kMedium))
                        ),
                        side: BorderSide(width: 0.6,color: AppColors.defaultAppRed)


                  ),onPressed: ()async {
                        service<AppPreferencesManager>().logOut();
                  }, child: Text("Change Email")),

                  //CustomOutlinedButton("Change Email"),


                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
