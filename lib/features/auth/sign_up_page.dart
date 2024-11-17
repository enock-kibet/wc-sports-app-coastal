import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/mixin/input_validation_mixin.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/auth/auth_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../common/dimens.dart';
import '../../theme/app_colors.dart';
import 'login_page2.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with InputValidationMixin {
  late AuthBloc authBloc;
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(text: kDebugMode ? 'codewithmbugua@gmail.com' : '');
  final TextEditingController _passwordController =
      TextEditingController(text: kDebugMode ? 'secretpassword123' : '');
  bool hidePassword = true;
  @override
  void initState() {
    authBloc = AuthBloc();
    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            service<Talker>().info('Login Success');
            //show success snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Register Successful'),
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
            context.go("/otp");
          }
          if (state.status == AuthStatus.failure) {
            service<Talker>().error('Register Failed');
            service<Talker>().error(state.failure!.error);
            //show snackbar
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
        builder: (context, state) {
          return AppBackground();
        },
      ),
      bottomSheet: SingleChildScrollView(
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(kMedium),
              width: double.infinity,
              child: Form(
                key: _registerFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoginSignUpSwitch(context, false),
                    const SizedBox(height: kLarge),
                    const Text(
                      "Welcome!",
                      style: TextStyle(
                          fontSize: kMedium,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF696565)),
                    ),
                    const SizedBox(height: kLarge),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("First Name",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF696565)))),
                            const SizedBox(height: 9),
                            CustomTextField(true, "Jina Langu",controller: _firstNameController,
                                      validator: combine([
                                        withMessage('Name is empty', isTextEmpty),
                                        
                                      ]),),
                          ],
                        )),
                        SizedBox(
                          width: kMedium,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            const Align(
                                alignment: Alignment.centerRight,
                                child: Text("Other Name",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF696565)))),
                            const SizedBox(
                              height: 9,
                            ),
                            CustomTextField(true, "",controller: _lastNameController,
                                      validator: combine([
                                        withMessage('Name is empty', isTextEmpty),
                                       
                                      ]),),
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Email",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF696565)))),
                    const SizedBox(
                      height: 9,
                    ),
                    CustomTextField(true, "jina@email.com",controller: _emailController,
                                      validator: combine([
                                        withMessage('Email is empty', isTextEmpty),
                                        withMessage('Email is invalid', isInvalidEmail)
                                      ]),),
                    const SizedBox(
                      height: 13,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF696565)))),
                    const SizedBox(
                      height: 9,
                    ),
                    CustomTextField(false, "**********",controller: _passwordController,
                                    validator: combine([
                                      withMessage('password is empty', isTextEmpty),
                                      withMessage(
                                          'password is invalid', isPasswordInvalid)
                                    ]),
                                    obscureText: hidePassword,
                                    obscuringCharacter: "*",),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (onChanged) {}),
                        const Text(
                          'Agree to Terms & Conditions',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kLarge,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (validateSaveLogin()) {
                                        if (state.status == AuthStatus.loading) {
                                        } else {
                                          String name = _firstNameController.text.trim() +
                                              " " +
                                              _lastNameController.text.trim();
                                          
                                          authBloc.add(AuthEvent.registering(
                                              request: {
                                            "name":name,
                                            "email": _emailController.text.trim(),
                                            "password": _passwordController.text.trim(),
                                        }
                                        ));
                                        }
                                      }
                        },
                        child: CustomFilledButton(state.status == AuthStatus.loading
                                            ? "Loading..."
                                            :'Sign Up')),
                    SizedBox(
                      height: 12,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            side: BorderSide(color: Color(0xFF414141)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kMedium))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/googlelogo2.png",
                              height: kLarge,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Sign In with Google',
                              style: TextStyle(
                                  color: Color(0xFF525252), fontSize: 13),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
   bool validateSaveLogin() {
    final form = _registerFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
