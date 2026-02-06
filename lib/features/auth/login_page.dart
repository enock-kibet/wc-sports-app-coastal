import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/mixin/input_validation_mixin.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/auth/auth_bloc.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';
import 'package:sports_app/main.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:upgrader/upgrader.dart';

import '../../common/dimens.dart';
import '../../theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with InputValidationMixin {
  final ValueNotifier<bool> _isHidden = ValueNotifier(true);
  late AuthBloc authBloc;
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: kDebugMode ? 'xtriimgamer3@gmail.com' : '');
  final TextEditingController _passwordController =
      TextEditingController(text: kDebugMode ? 'Qwerty123456' : '');
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
        listener: (context, state) async {
          if (state.status == AuthStatus.success) {
            context.read<UserBloc>().add(UpdateUser(state.data));
            //show success snackbar

            SnackbarService.show(
              'Login Successful',
              backgroundColor: AppColors.dangerColor,
            );
          }
          if (state.status == AuthStatus.failure) {
            service<Talker>().error('Login Failed');
            service<Talker>().error(state.failure!.error);
            await GoogleSignIn(scopes: ['profile', 'email']).signOut();
            //show snackbar
            SnackbarService.show(
              state.failure!.error,
              backgroundColor: AppColors.dangerColor,
              actionLabel: 'Dismiss',
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
                    CustomTextField(
                      true,
                      "jina@email.com",
                      controller: _emailController,
                      validator: combine([
                        withMessage('Email is empty', isTextEmpty),
                        withMessage('Email is invalid', isInvalidEmail)
                      ]),
                    ),
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
                    ValueListenableBuilder(
                        valueListenable: _isHidden,
                        builder: (context, value, child) {
                          return CustomTextField(false, "**********",
                              controller: _passwordController,
                              validator: combine([
                                withMessage('password is empty', isTextEmpty),
                                withMessage(
                                    'password is invalid', isPasswordInvalid)
                              ]),
                              obscureText: _isHidden.value,
                              obscuringCharacter: "*", toggleVisibility: () {
                            _isHidden.value = !_isHidden.value;
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Checkbox(value: false, onChanged: (onChanged) {}),
                            // const Text(
                            //   'Remember Me',
                            //   style: TextStyle(fontSize: kSMedium),
                            // )
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
                              authBloc.add(AuthEvent.login(request: {
                                "email": _emailController.text.trim(),
                                "password": _passwordController.text.trim(),
                                "clubid": '80e0e316-64a8-4708-9dd5-590f3b6bedff'
                              }));
                            }
                          }
                        },
                        child: CustomFilledButton(
                            state.status == AuthStatus.loading
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
                        onPressed: () async {
                          try {
                            // Initialize Google Sign-In
                            final GoogleSignIn googleSignIn =
                                GoogleSignIn(scopes: ['profile', 'email']);

                            // Trigger the Google Sign-In flow
                            final GoogleSignInAccount? googleUser =
                                await googleSignIn.signIn();

                            if (googleUser != null) {
                              authBloc.add(AuthEvent.googlelogin(request: {
                                "name": googleUser.displayName,
                                "email": googleUser.email,
                                "googleId": googleUser.id,
                                "picture": googleUser.photoUrl,
                                "clubid": '80e0e316-64a8-4708-9dd5-590f3b6bedff'
                              }));
                            } else {
                              print("Google Sign-In canceled by user.");
                              return null;
                            }
                          } catch (e) {
                            print("Error during Google Sign-In: $e");
                            return null;
                          }
                        },
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
                            Text(
                              state.status == AuthStatus.loading
                                  ? "Loading..."
                                  : 'Sign In with Google',
                              style: const TextStyle(
                                  color: Color(0xFF525252), fontSize: 13),
                            )
                          ],
                        )),
                    if (Platform.isIOS)
                      SignInWithAppleButton(
                        style: SignInWithAppleButtonStyle.black,
                        height: 56,
                        onPressed: state.status == AuthStatus.loading
                            ? null
                            : _signInWithApple,
                      ),
                    const SizedBox(
                      height: kSMedium * 5,
                    ),
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

  Future<void> _signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      authBloc.add(
        AuthEvent.appleLogin(request: {
          "appleId": credential.userIdentifier,
          "email": credential.email,
          "name": "${credential.givenName ?? ''} ${credential.familyName ?? ''}"
              .trim(),
          "identityToken": credential.identityToken,
          "clubid": '80e0e316-64a8-4708-9dd5-590f3b6bedff'
        }),
      );
    } catch (e) {
      SnackbarService.show(
        "Apple Sign-In cancelled or failed",
        backgroundColor: AppColors.dangerColor,
      );
    }
  }
}

CustomTextField(bool isEmail, String hintText,
    {final TextEditingController? controller,
    final String? Function(String?)? validator,
    bool obscureText = false,
    String? obscuringCharacter,
    VoidCallback? toggleVisibility}) {
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    validator: validator,
    keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    obscuringCharacter: "*",
    onTapOutside: (bool) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: kMedium, vertical: 14),
        suffixIcon: !isEmail
            ? IconButton(
                onPressed: () {
                  toggleVisibility!();
                  obscureText = !obscureText;
                },
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primaryColor,
                ),
              )
            : const SizedBox(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kMedium),
            borderSide: const BorderSide(color: Color(0xFFC6C6C6))),
        filled: false,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFC6C6C6)),
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
      style: TextStyle(
          color: AppColors.inputFillColor,
          fontSize: 18,
          fontWeight: FontWeight.w500),
    )),
  );
}

CustomisableFilledButton(
    String buttonText, bool? fullyRounded, double? height, double textSize) {
  return Container(
    height: height ?? 56,
    width: double.infinity,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(fullyRounded ?? false ? 72 : kMedium),
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
      style: TextStyle(color: AppColors.inputFillColor, fontSize: textSize),
    )),
  );
}

CustomOutlinedButton(String buttonText) {
  return Container(
    height: 56,
    width: double.infinity,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMedium), border: Border.all()),
    child: Center(
        child: Text(
      buttonText,
      style: TextStyle(color: AppColors.blackColor, fontSize: 18),
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
