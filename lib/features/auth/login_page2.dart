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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>with InputValidationMixin  {
  late AuthBloc authBloc;
  final _loginFormKey = GlobalKey<FormState>();
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
                content: const Text('Login Success'),
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
            service<Talker>().error('Login Failed');
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
          return const AppBackground();
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
                    key: _loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoginSignUpSwitch(context, true),
                        const SizedBox(
                          height: kLarge,
                        ),
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: kMedium,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF696565)),
                        ),
                        const SizedBox(
                          height: kLarge,
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
                                    obscuringCharacter: "*",
                                   ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (onChanged) {}),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(fontSize: kSMedium),
                                )
                              ],
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(fontSize: kSMedium),
                                ))
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
                                          authBloc.add(AuthEvent.login(
                                              request: {
                                            "email": _emailController.text.trim(),
                                            "password": _passwordController.text.trim(),
                                        }));
                                        }
                                      }
                            },
                            child: CustomFilledButton(state.status == AuthStatus.loading
                                            ? "Loading..."
                                            : 'Sign In')),
                        const SizedBox(
                          height: kSMedium,
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
                                const SizedBox(
                                  width: kSMedium,
                                ),
                                const Text(
                                  'Sign In with Google',
                                  style:
                                      TextStyle(color: Color(0xFF525252), fontSize: 13),
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
    final form = _loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}

CustomTextField(bool isEmail, String hintText,{final TextEditingController? controller,final String? Function(String?)? validator,bool obscureText = false,String? obscuringCharacter}) {
  return TextFormField(
    obscureText: !isEmail,
    controller: controller,
    validator: validator,
    keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    obscuringCharacter: "*",
    onTapOutside: (bool) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    decoration: InputDecoration(
      suffixIcon: !isEmail? IconButton(
                                  onPressed: () {
                                   
                                      obscureText = !obscureText;
                                   
                                  },
                                  icon: Icon(
                                    obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.primaryColor,
                                  ),
                                ):SizedBox(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kMedium),
            borderSide: BorderSide(color: Color(0xFFC6C6C6))),
        filled: false,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 13, color: Color(0xFFC6C6C6)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kMedium),
            borderSide: BorderSide(color: AppColors.primaryColor))),
  );
}

//button with the app colors spanning entire width
CustomFilledButton(String buttonText) {
  return Container(
    height: 56,
    width: double.infinity,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMedium),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.defaultAppRed,
            AppColors.defaultAppPurple,
          ],
        )),
    child: Center(
        child: Text(
      buttonText,
      style: TextStyle(color: AppColors.inputFillColor, fontSize: 18),
    )),
  );
}

LoginSignUpSwitch(BuildContext context, bool isSignInPage) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kLarge), color: Color(0xFFF0F0F0)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            context.go('/signIn');
          },
          child: Container(
            alignment: Alignment.center,
            height: 32,
            width: 101,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kLarge),
                color: isSignInPage ? Color(0xFF656060) : Color(0xFFF0F0F0)),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: isSignInPage
                      ? AppColors.inputFillColor
                      : Color(0xFF292323)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.go('/signUp');
          },
          child: Container(
            alignment: Alignment.center,
            height: 34,
            width: 101,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kLarge),
                color: isSignInPage ? Color(0xFFF0F0F0) : Color(0xFF656060)),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: isSignInPage
                      ? Color(0xFF292323)
                      : AppColors.inputFillColor),
            ),
          ),
        )
      ],
    ),
  );
}
