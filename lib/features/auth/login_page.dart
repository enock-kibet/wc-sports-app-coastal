// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import 'package:talker_flutter/talker_flutter.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with InputValidationMixin {
//   bool rememberMe = true;
//   bool usePhone = true;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _passwordController;

//   String? completeNumber;
//   bool showPassword=true;

//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
  
//     _emailController = TextEditingController();
//     _phoneController = TextEditingController();
//     _passwordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _userBloc.close();
//     _authBloc.close();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     return Scaffold(
//       backgroundColor: theme.surface,
//       body: BlocConsumer<AuthBloc, AuthState>(
//         bloc: _authBloc,
//         listener: (context, state) {
//           switch (state.status) {
//             case AuthStatus.failure:
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Center(
//                       child: Text(state.failure!.error.toString(),
//                           style: TextStyle(color: theme.inverseSurface))),
//                   backgroundColor: theme.error,
//                   behavior: SnackBarBehavior.floating,
//                 ),
//               );
//               break;
//             case AuthStatus.success:
//               _authBloc.add(
//                 AuthEvent.sendOtp(
//                   id: user!.id,
//                   channel: "sms",
//                 ),
//               );
//               context.pushNamed(AppRoute.otpVerify.name, extra: user);
//               break;
//             default:
//               break;
//           }
//         },
//         builder: (context, state) {
//           return BlocListener<UserBloc, UserState>(
//             bloc: _userBloc,
//             listener: (context, state) {
//               switch (state.status) {
//                 case UserStatus.failure:
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Center(
//                           child: Text(state.failure!.error.toString(),
//                               style: TextStyle(color: theme.surface))),
//                       backgroundColor: theme.error,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                   break;
//                 case UserStatus.success:
//                   service<Talker>().info(state.user);

//                   _authBloc.add(
//                     AuthEvent.phoneLogin(
//                       id: state.user!.id,
//                       password: _passwordController.text.trim(),
//                     ),
//                   );
//                   setState(() {
//                     user = state.user;
//                   });
//                   break;
//                 default:
//                   break;
//               }
//             },
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: kMedium),
//                 child: Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: kLarge,
//                         ),
//                         Center(
//                             child: Image.asset(
//                           "assets/logo.png",
//                           width: (280 * (2 / 3)),
//                         )),
//                         const SizedBox(
//                           height: kXXLarge,
//                         ),
//                         const Text(
//                           "Welcome back!",
//                           style: TextStyle(
//                             fontSize: kXLMedium,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         const Text(
//                           "Enter your country and phone number to access your account.",
//                           style: TextStyle(
//                             fontSize: kMedium,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         Text(
//                           usePhone ? "Primary Phone Number" : "Email Address",
//                           style: const TextStyle(
//                             fontSize: kMedium,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: kSmall,
//                         ),
//                         if (usePhone)
//                           IntlPhoneField(
//                             initialCountryCode: "KE",
//                             disableLengthCheck: true,
//                             showCountryFlag: false,
//                             controller: _phoneController,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             dropdownIconPosition: IconPosition.trailing,
//                             dropdownDecoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                             ),
//                             enabled: state.status != AuthStatus.loading,
//                             flagsButtonPadding: const EdgeInsets.only(
//                               left: kMedium,
//                               right: kSmall,
//                             ),
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                               // LengthLimitingTextInputFormatter(9),
//                             ],
//                             validator: (value) {
//                               if (value!.number.isEmpty) {
//                                 return "Phone number is required";
//                               }
//                               if (value.number.length < 9) {
//                                 return "Phone number is too short";
//                               }

//                               return null;
//                             },
//                             dropdownIcon: Icon(
//                               CupertinoIcons.chevron_down,
//                               color: theme.inverseSurface,
//                               size: kMedium,
//                             ),
//                             pickerDialogStyle: PickerDialogStyle(
//                                 backgroundColor: theme.surface,
//                                 countryCodeStyle:
//                                     TextStyle(color: theme.inverseSurface)),
//                             decoration: InputDecoration(
//                               filled: true,
//                               enabled: state.status == AuthStatus.loading,
//                               hintText: "7123456789",
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: kMedium,
//                                 vertical: kMedium,
//                               ),
//                             ),
//                             onChanged: (newPhone) {
//                               completeNumber = newPhone.completeNumber;
//                               // setState(() {});
//                             },
//                             onCountryChanged: (country) {
//                               print('Country changed to: ${country.name}');
//                             },
//                           ),
//                         if (!usePhone)
//                           TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             validator: combine([
//                               withMessage('Email is empty', isTextEmpty),
//                               withMessage('Email is invalid', isInvalidEmail),
//                             ]),
//                             enabled: state.status != AuthStatus.loading,
//                             controller:
//                                 usePhone ? _phoneController : _emailController,
//                             decoration: const InputDecoration(
//                               border: OutlineInputBorder(),
//                               hintText: 'Enter your email',
//                             ),
//                           ),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         const Text(
//                           "Password",
//                           style: TextStyle(
//                             fontSize: kMedium,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: kSmall,
//                         ),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscuringCharacter: "*",
//                           obscureText: showPassword,
//                           enabled: state.status != AuthStatus.loading,
//                           validator: combine([
//                             withMessage('Password is empty', isTextEmpty),
//                           ]),
//                           decoration:  InputDecoration(
//                             suffixIcon: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   showPassword = !showPassword;
//                                 });
//                               },
//                               child: Icon(
//                                 showPassword
//                                     ? Icons.visibility_outlined
//                                     : Icons.visibility_off_outlined,
//                               ),
//                             ),
//                             hintText: '**********',
//                           ),
//                         ),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 //Reduce the size of flutter switch
//                                 //https://github.com/flutter/flutter/issues/84093
//                                 Transform.scale(
//                                   scale: 0.7,
//                                   child: Switch(
//                                       value: rememberMe,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           rememberMe = !rememberMe;
//                                         });
//                                       }),
//                                 ),
//                                 Text(
//                                   "Remember Me",
//                                   style: TextStyle(color: theme.inverseSurface),
//                                 )
//                               ],
//                             ),
//                             TextButton(
//                                 onPressed: () {},
//                                 child: Text(
//                                   "Forgot Password?",
//                                   style: TextStyle(color: theme.inverseSurface),
//                                 )),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         FilledButton(
//                             style: FilledButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(kSmall)),
//                                 minimumSize: Size(context.width, 60)),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate() &&
//                                   state.status != AuthStatus.loading) {
//                                 if (!usePhone) {
//                                   _authBloc.add(AuthEvent.login(
//                                       request: LoginRequest(
//                                     email: _emailController.text.trim(),
//                                     password: _passwordController.text.trim(),
//                                     remember: rememberMe,
//                                   )));
//                                 } else {
//                                   _userBloc.add(UserEvent.userPhone(
//                                     phone: completeNumber!,
//                                   ));
//                                 }
//                               }
//                               // context.pushNamed(AppRoute.otpVerify.name);
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 if (state.status == AuthStatus.loading)
//                                   Container(
//                                       margin:
//                                           const EdgeInsets.only(right: kMedium),
//                                       height: kXLMedium,
//                                       width: kXLMedium,
//                                       child: CircularProgressIndicator(
//                                           color: theme.surface)),
//                                 const Text("Continue",
//                                     style: TextStyle(fontSize: kMedium)),
//                               ],
//                             )),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         const Row(
//                           children: [
//                             Expanded(child: Divider()),
//                             Padding(
//                               padding:
//                                   EdgeInsets.symmetric(horizontal: kMedium),
//                               child: Text(" OR "),
//                             ),
//                             Expanded(child: Divider()),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(kSmall)),
//                                 minimumSize: Size(context.width, 60)),
//                             onPressed: () {
//                               setState(() {
//                                 usePhone = !usePhone;
//                               });
//                             },
//                             child: Text(
//                               usePhone
//                                   ? "Login with Email"
//                                   : "Login with Phone",
//                               style: TextStyle(
//                                   color: theme.inverseSurface,
//                                   fontSize: kMedium),
//                             )),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                         FilledButton(
//                             style: FilledButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(kSmall)),
//                               backgroundColor: theme.inverseSurface,
//                               minimumSize: Size(
//                                 context.width,
//                                 60,
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 if (usePhone) {}
//                               }
//                             },
//                             child: Text(
//                               "Login with Medlyne Card",
//                               style: TextStyle(
//                                   color: theme.surface, fontSize: kMedium),
//                             )),
//                         const SizedBox(
//                           height: kXLarge,
//                         ),
//                         RichText(
//                             text: TextSpan(
//                                 style: TextStyle(color: theme.inverseSurface),
//                                 text: "Dont have an account? ",
//                                 children: [
//                               TextSpan(
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       context.pushNamed(AppRoute.signup.name);
//                                     },
//                                   style: TextStyle(color: theme.primary),
//                                   text: "Sign up")
//                             ])),
//                         const SizedBox(
//                           height: kMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
