import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:sports_app/features/app/blocs/user_profile/user_bloc.dart';
import 'package:mime/mime.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/common/huge_icon_button.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/features/app/blocs/auth/auth_bloc.dart';
import 'package:sports_app/features/dashboard/pages/profile/widgets/profile_picture.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:sports_app/router/router.dart';
import 'package:sports_app/theme/app_colors.dart';
import 'package:talker_flutter/talker_flutter.dart';


class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _dobController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneNumberController;
  late final AuthBloc _authBloc;
  num? roleId;
  String? profilePicture;
  String? picture;
  late User user;
  bool loading=false;

  Future<void> selectProfilePicture() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final file = File(result.files.single.path!);
      final croppedFile = await _cropImage(file);
      service<Talker>().info(croppedFile?.path);
      final formData = FormData.fromMap({
        'email': user.email,
        'image': await MultipartFile.fromFile(croppedFile!.path, filename: result.files.first.name),
      });
      _authBloc.add(AuthEvent.editProfile(request: formData));
      await file.delete();
      // await croppedFile.delete();

      // if (croppedFile != null) {
      //   final base64String = await _encodeImage(croppedFile);
      //   setState(() {
      //     profilePicture = base64String;
      //   });
      // }
    }
  }

  Future<File?> _cropImage(File file) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.blue,
            toolbarTitle: "Crop Image",
            statusBarColor: Colors.blue.shade900,
            backgroundColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ]);

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  Future<String> _encodeImage(File file) async {
    final bytes = await file.readAsBytes();
    final mimeType = lookupMimeType(file.path);
    return 'data:$mimeType;base64,${base64Encode(bytes)}';
  }

  @override
  void initState() {
    _authBloc = AuthBloc();
    user = service<AppPreferencesManager>().currentUserValue!;

    _firstNameController = TextEditingController(text: user.name.split(' ').first);
    _emailController = TextEditingController(text: user.email);
    _lastNameController = TextEditingController(text: user.name.split(' ').last);
    _dobController = TextEditingController(text: '');
    picture = user.picture;
    
    _phoneNumberController = TextEditingController(text:'');


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    service<Talker>().info(picture);
    final theme= Theme.of(context).colorScheme;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HugeIconButton(icon: HugeIcons.strokeRoundedArrowLeft01,onPressed:state.status==AuthStatus.loading?null: (){
                      context.goNamed(AppRoute.editProfile.name);
                    },),
                     Text("Personal Details",style: TextStyle(fontSize: kXLMedium,color: theme.onSurface),),
                    const SizedBox(),
                  ],
                ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    onTap:state.status==AuthStatus.loading?null:
                    selectProfilePicture,
                    child: Stack(

                      children: [
                        ProfilePicture(
                          picture: state.status==AuthStatus.loading?  null:state.status==AuthStatus.success?(state.data as User).picture:picture,
                        ),
                        Positioned(
                          bottom: kSmall,
                          right: kSmall,
                          child: Icon(
                          HugeIcons.strokeRoundedCameraAdd02,
                          size: 32,
                          color: Colors.grey[500],
                        ))

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kMedium),
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: !(state.status==AuthStatus.loading),
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                      const SizedBox(height: kSmall),
                      TextFormField(
                        enabled: !(state.status==AuthStatus.loading),
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                      const SizedBox(height: kSmall),
                      GestureDetector(
                        onTap:state.status==AuthStatus.loading?null:() async {
                          // Use the current date as the initial date if the field is empty
                          final initialDate = _dobController.text.isEmpty
                              ? DateTime.now()
                              : DateTime.parse(_dobController.text);
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            // Format the date and update the text field
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            _dobController.text = formattedDate;
                          }
                        },
                        child: AbsorbPointer(
                          // Prevents the keyboard from showing
                          child: TextFormField(
                            controller: _dobController,
                            decoration: const InputDecoration(
                              labelText: 'Date of Birth',
                              suffixIcon: Icon(
                                  HugeIcons.strokeRoundedCalendar01), // Calendar icon as suffix
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: kSmall),
                      TextFormField(
                        enabled: !(state.status==AuthStatus.loading),
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: kSmall),
                      TextFormField(
                        enabled: !(state.status==AuthStatus.loading),
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kMedium),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(kSmall)),
                                    minimumSize: Size(context.width, 50)),
                      onPressed: state.status==AuthStatus.loading?null:() {
                        // final userProfile = UserProfile(
                        //     firstname: _firstNameController.text,
                        //     lastname: _lastNameController.text,
                        //     email: _emailController.text,
                        //     username: _usernameController.text,
                        //     roleId: roleId,
                        //     phone: _phoneNumberController.text,
                        //     picture: profilePicture);

                        // log('User Profile: $userProfile');
                        // ref.read(profileNotifierProvider.notifier).updateUserProfile(
                        //     ref.read(userProvider)!.user!.id, userProfile);
                      },
                      child: const Text('Update Profile')),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        );
      },
      listener: (context,state) {
        if (state.status == AuthStatus.success) {
          context.read<UserBloc>().add(UpdateUser(state.data));
          service<Talker>().info('Profile picture updated');
          //show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Profile picture updated'),
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
          service<Talker>().error('Profile picture update failed');
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
        if (state.status == AuthStatus.loading) {
          service<Talker>().info('Loading');
          //show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Loading..."),
              backgroundColor: AppColors.dangerColor,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 5),
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
    );
  }
}
