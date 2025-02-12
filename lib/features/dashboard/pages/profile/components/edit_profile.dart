import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sports_app/common/custom_text_form_field.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/huge_icon_button.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';
import 'package:sports_app/features/dashboard/pages/profile/widgets/profile_list_item.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';

class EditProfileMain extends StatefulWidget {
  const EditProfileMain({super.key});

  @override
  State createState() => _EditProfileMainState();
}

class _EditProfileMainState extends State<EditProfileMain> {
  final formKey = GlobalKey<FormState>();
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmNewPassword = TextEditingController();

  Future<bool> _onBackPressed()async{
    context.goNamed(AppRoute.profile.name);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final user = null;
    //context.watch<UserCubit>().state;
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HugeIconButton(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                onPressed: () {
                  context.goNamed(AppRoute.profile.name);
                },
              ),
              Text(
                "Edit profile",
                style: TextStyle(fontSize: kXLMedium, color: theme.onSurface),
              ),
              const SizedBox(),
            ],
          ),
        ),
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 24, right: 24),
                child: Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(48),
                      child: BlocBuilder<UserBloc,User?>(
                      builder: (context,user) {
                        return CachedNetworkImage(
                          imageUrl: user?.picture??"",
                          errorWidget: (context, url, error) => Icon(Icons.person,size: 48,color: AppColors.greyColor,),
                          width: 120,
                          height: 120,
                          fit: BoxFit.fitHeight,
                        );
                      }
                  ),
                ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  children: [
                    ProfileListItem(
                      title: 'Personal Details',
                      iconData: HugeIcons.strokeRoundedUserAccount,
                      onTap: () {
                        // Navigate to the personal details page
                        context.pushNamed(AppRoute.profileDetails.name);
                      },
                    ),
                    ProfileListItem(
                        title: 'Change Password',
                        iconData: HugeIcons.strokeRoundedLockPassword,
                        onTap: () {
                          _showChangePasswordBottomSheet(context, "user.id");
                        }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _showChangePasswordBottomSheet(BuildContext context, String userId) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('Change Password',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: 'Old Password',
                    obscureText: true,
                    controller: _oldPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'New Password',
                    obscureText: true,
                    controller: _newPassword,
                    validator: (value) {
                      if (value == _oldPassword.text) {
                        return 'New password cannot be the same as the old password';
                      }
                      return null;
                      //Validator.validatePassword(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Confirm New Password',
                    obscureText: true,
                    controller: _confirmNewPassword,
                    validator: (value) {
                      if (value != _newPassword.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: () async {
                        // Handle password change
                        // if (formKey.currentState!.validate()) {
                        //   log('Old Password: ${_oldPassword.text}');
                        //   final wasSuccessful = await ref
                        //       .read(changePasswordNotifierProvider.notifier)
                        //       .changePassword(
                        //         userId,
                        //         _oldPassword.text,
                        //         _newPassword.text,
                        //       );
                        //   if (wasSuccessful) {
                        //     Navigator.of(context).pop();
                        //     context.pushNamed('login');
                        //   }
                        // }
                      },
                      child: const Text('Change Password'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      _oldPassword.clear();
      _newPassword.clear();
      _confirmNewPassword.clear();
    });
  }
}
