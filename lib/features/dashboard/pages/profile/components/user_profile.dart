// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:sports_app/data/repository/auth_repository.dart';
// import 'package:sports_app/router/router.dart';

// import '../widgets/profile_list_item.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   int maxRetry = 3;

//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Are you sure?'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Are you sure you want to leave this app?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Yes, close app'),
//               onPressed: () {
//                 SystemNavigator.pop();
//               },
//             ),
//             TextButton(
//               child: const Text('No, stay here'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _logoutDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext dialogcontext) {
//         return AlertDialog(
//           title: const Text('Are you sure?'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('You are about to logout!!'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.red,
//               ),
//               child: const Text('Yes, logout'),
//               onPressed: () {
//                 // SharedPrefsUtil.remove("USER");
//                 // ref.read(userProvider.notifier).signOut();
//                 // Navigator.of(dialogcontext).pop();
//                 // context.goNamed('job-home');
//                 AuthRepository.instance.logout();
//                // context.read<UserCubit>().logout();
//                 context.goNamed(AppRoute.login.name);
//               },
//             ),
//             TextButton(
//               child: const Text('No, stay loggedIn'),
//               onPressed: () {
//                 Navigator.of(dialogcontext).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _changeTheme() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Change App Theme'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 BlocBuilder<ThemeBloc, bool>(
//                   builder: (context, state) {
//                     return Switch(
//                         value: state,
//                         onChanged: (bool val) {
//                           context.read<ThemeBloc>().add(ChangeTheme());
//                           dialogContext.pop();
//                         });
//                   },
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = context.watch<UserCubit>().state;
//     if (user == null) {
//       return UnauthenticatedUserWidget(
//         onLoginPressed: () => context.pushNamed('login'),
//       );
//     }
//     // ignore: unnecessary_null_comparison
//     if (user != null &&
//         context.watch<UserBloc>().state.failure != null &&
//         maxRetry <= 3) {
//       context.read<UserBloc>().add(const UserEvent.patientDetails());
//     }
//     final theme = Theme.of(context).colorScheme;
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (onPop) async {
//         return _showMyDialog();
//       },
//       child: SafeArea(
//         child: Scaffold(
//             appBar: PreferredSize(
//               preferredSize: const Size.fromHeight(140),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: kMedium),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Account",
//                           style: TextStyle(
//                               fontSize: kXLMedium, color: theme.onSurface),
//                         ),
//                         const HugeIconButton(
//                             icon: HugeIcons.strokeRoundedNotification01)
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         top: 12, left: kMedium, right: kMedium),
//                     child: Stack(
//                       children: [
//                         Center(
//                           child: ProfileWithCounter(
//                             user: user,

//                             // onEditPressed: () {
//                             //   context.pushNamed('edit-profile');
//                             // },
//                           ),
//                         ),
//                         Positioned(
//                           top: kXLMedium,
//                           right: kXSmall,
//                           bottom: kXLMedium,
//                           child: HugeIconButton(
//                             tooltip: "Switch profiles",
//                             icon: HugeIcons.strokeRoundedUserSwitch,
//                             onPressed: () {},
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: buildUserProfile(context)),
//       ),
//     );
//   }

//   Widget buildUserProfile(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     return Column(
//       children: [
//         const SizedBox(height: kMedium),
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: theme.surface,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(32),
//                 topRight: Radius.circular(32),
//               ),
//             ),
//             height: MediaQuery.of(context).size.height * 0.6,
//             child: ListView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               padding: const EdgeInsets.symmetric(
//                   horizontal: kMedium, vertical: kSmall),
//               children: [
//                 ProfileListItem(
//                   title: 'Edit Profile',
//                   iconData: HugeIcons.strokeRoundedUserEdit01,
//                   onTap: () {
//                     // Navigate to the edit profile page
//                     context.pushNamed(AppRoute.editProfile.name);
//                   },
//                 ),
//                 ProfileListItem(
//                     title: 'My Documents',
//                     iconData: HugeIcons.strokeRoundedLegalDocument01,
//                     onTap: () {
//                       context.pushNamed('my-documents');
//                     }),
//                 ProfileListItem(
//                     title: 'Medical History',
//                     iconData: HugeIcons.strokeRoundedWorkHistory,
//                     onTap: () {}),
//                 ProfileListItem(
//                     title: 'Change Theme',
//                     iconData: HugeIcons.strokeRoundedHelpCircle,
//                     onTap: () {
//                       _changeTheme();
//                     }),
//                 ProfileListItem(
//                     title: 'Help Center',
//                     iconData: HugeIcons.strokeRoundedHelpCircle,
//                     onTap: () {}),
//                 ProfileListItem(
//                     title: 'Privacy Policy',
//                     iconData: HugeIcons.strokeRoundedLockKey,
//                     onTap: () {}),
//                 const Divider(
//                   color: Colors.black12,
//                 ),
//                 ProfileListItem(
//                     title: 'Log Out',
//                     color: theme.errorContainer,
//                     iconData: HugeIcons.strokeRoundedLogout01,
//                     onTap: () {
//                       _logoutDialog();
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
