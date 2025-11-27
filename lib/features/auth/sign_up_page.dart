import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/mixin/input_validation_mixin.dart';
import 'package:sports_app/core/snackbar_service.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/auth/auth_bloc.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/dimens.dart';
import '../../theme/app_colors.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with InputValidationMixin {
  late AuthBloc authBloc;
  final ValueNotifier<bool> _isChecked = ValueNotifier(false);
  final ValueNotifier<bool> _isHidden = ValueNotifier(true);
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
        listener: (context, state) async {
          if (state.status == AuthStatus.success) {
            context.read<UserBloc>().add(UpdateUser(state.data));
            service<Talker>().info('Login Success');
            //show success snackbar
            SnackbarService.show(
              'Registration Successful',
              backgroundColor: AppColors.blackColor,
            );
          }
          if (state.status == AuthStatus.failure) {
            service<Talker>().error('Register Failed');
            service<Talker>().error(state.failure!.error);
            await GoogleSignIn(scopes: ['profile', 'email']).signOut();
            //show snackbar
            SnackbarService.show(
              state.failure!.error,
              backgroundColor: AppColors.dangerColor,
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
                            CustomTextField(
                              true,
                              "Jina Langu",
                              controller: _firstNameController,
                              validator: combine([
                                withMessage('Name is empty', isTextEmpty),
                              ]),
                            ),
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
                            CustomTextField(
                              true,
                              "",
                              controller: _lastNameController,
                              validator: combine([
                                withMessage('Name is empty', isTextEmpty),
                              ]),
                            ),
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
                    ValueListenableBuilder<bool>(
                        valueListenable: _isChecked,
                        builder: (context, value, child) {
                          return FormField<bool>(
                              initialValue: value,
                              validator: (val) {
                                if (!(val ?? false)) {
                                  return "Accept terms to proceed.";
                                }
                                return null;
                              },
                              builder: (state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: state.value,
                                            onChanged: (onChanged) {
                                              //_isChecked.value = onChanged??false;
                                              state.didChange(onChanged);
                                            }),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Agree to ',
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: 'Terms & Conditions',
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        launchURL(
                                                            "https://wencetechnologies.com/SportsApp/Terms%26Conditions.html"); // Call your URL launcher function
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (state.hasError)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          state.errorText ?? '',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: kSMedium),
                                        ),
                                      ),
                                  ],
                                );
                              });
                        }),
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

                              authBloc.add(AuthEvent.registering(request: {
                                "name": name,
                                "email": _emailController.text.trim(),
                                "password": _passwordController.text.trim(),
                                "confirmpassword":
                                    _passwordController.text.trim()
                              }));
                            }
                          }
                        },
                        child: CustomFilledButton(
                            state.status == AuthStatus.loading
                                ? "Loading..."
                                : 'Sign Up')),
                    SizedBox(
                      height: 12,
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
                                "picture": googleUser.photoUrl
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
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Sign In with Google',
                              style: TextStyle(
                                  color: Color(0xFF525252), fontSize: 13),
                            )
                          ],
                        )),
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
    final form = _registerFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}

void launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
