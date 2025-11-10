import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool loading = false;
  bool uploading = false;

  Future<void> selectProfilePicture() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final file = File(result.files.single.path!);
      final croppedFile = await _cropImage(file);
      service<Talker>().info(croppedFile?.path);
      final formData = FormData.fromMap({
        'email': user.email,
        'image': await MultipartFile.fromFile(croppedFile!.path,
            filename: result.files.first.name),
      });
      _authBloc.add(AuthEvent.editProfile(request: formData));
      await file.delete();
    }
  }

  InputDecoration _themedInputDecoration(
    BuildContext context, {
    required String label,
    IconData? icon,
  }) {
    final theme = Theme.of(context);

    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: theme.colorScheme.surface, // ✅ adapts to light/dark
      labelStyle: TextStyle(color: theme.colorScheme.onSurface),
      hintStyle: TextStyle(color: theme.hintColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 1.5,
        ),
      ),
    );
  }

  Future<File?> _cropImage(File file) async {
    // Temporarily reset system UI mode for the native cropper
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    // Apply safe, visible system overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 700,
      maxHeight: 700,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Theme.of(context).colorScheme.primary,
          toolbarWidgetColor: Colors.white,
          statusBarColor: Colors.black,
          backgroundColor: Colors.black,
          lockAspectRatio: false,
          hideBottomControls: false, // show confirm/cancel buttons
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );

    // After closing the cropper, restore edge-to-edge mode
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Restore your app’s overlay theme
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

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

    _firstNameController =
        TextEditingController(text: user.name.split(' ').first);
    _emailController = TextEditingController(text: user.email);
    _lastNameController =
        TextEditingController(text: user.name.split(' ').last);
    _dobController = TextEditingController(text: user.dateOfBirth ?? '');
    picture = user.picture;

    _phoneNumberController =
        TextEditingController(text: user.phoneNumber ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
/*************  ✨ Windsurf Command ⭐  *************/
    /// Builds a BlocConsumer widget that displays the user's personal details.
    ///
    /// The widget displays the user's first name, last name, phone number, date of birth, and email.
    /// It also displays an update button that allows the user to edit their profile data.
    ///
    /// The widget listens to the [AuthBloc] and updates the UI accordingly.
    /// It shows a loading indicator when the [AuthBloc] is in the [AuthStatus.loading] state.
    /// It shows a success snackbar when the [AuthBloc] is in the [AuthStatus.success] state.
    /// It shows an error snackbar when the [AuthBloc] is in the [AuthStatus.failure] state.
    ///
    /// The widget also handles the user's profile photo.
    /// It allows the user to select a new profile photo.
    /// It shows a loading indicator when the [AuthBloc] is in the [AuthStatus.uploading] state.
    /// It shows a success snackbar when the [AuthBloc] is in the [AuthStatus.uploadSuccess] state.
/*******  21fc0be8-2532-4311-ab4f-620251b82ffd  *******/ service<Talker>()
        .info(picture);
    final theme = Theme.of(context).colorScheme;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context, state) {
        var children = [
          TextFormField(
            enabled: !(state.status == AuthStatus.loading),
            controller: _firstNameController,
            decoration: _themedInputDecoration(
              context,
              label: 'First Name',
              icon: Icons.person_outline,
            ),
          ),
          const SizedBox(height: kSmall * 2),
          TextFormField(
            enabled: !(state.status == AuthStatus.loading),
            controller: _lastNameController,
            decoration: _themedInputDecoration(
              context,
              label: 'Last Name',
              icon: Icons.person_outline,
            ),
          ),
          const SizedBox(height: kSmall * 2),
          TextFormField(
            enabled: !(state.status == AuthStatus.loading),
            controller: _phoneNumberController,
            decoration: _themedInputDecoration(
              context,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
            ),
          ),
          const SizedBox(height: kSmall * 2),
          GestureDetector(
            onTap: state.status == AuthStatus.loading
                ? null
                : () async {
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
                      _dobController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    }
                  },
            child: AbsorbPointer(
              child: TextFormField(
                controller: _dobController,
                decoration: _themedInputDecoration(
                  context,
                  label: 'Date of Birth',
                  icon: Icons.calendar_month_outlined,
                ),
              ),
            ),
          ),
          const SizedBox(height: kSmall * 2),
          TextFormField(
            enabled: !(state.status == AuthStatus.loading),
            controller: _emailController,
            decoration: _themedInputDecoration(
              context,
              label: 'Email',
              icon: Icons.email_outlined,
            ),
          ),
        ];
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HugeIconButton(
                  icon: HugeIcons.strokeRoundedArrowLeft01,
                  onPressed: state.status == AuthStatus.loading
                      ? null
                      : () {
                          context.goNamed(AppRoute.editProfile.name);
                        },
                ),
                Text(
                  "Personal Details",
                  style: TextStyle(fontSize: kXLMedium, color: theme.onSurface),
                ),
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
                    onTap: state.status == AuthStatus.uploading
                        ? null
                        : selectProfilePicture,
                    child: Stack(
                      children: [
                        ProfilePicture(
                          picture: state.status == AuthStatus.uploading
                              ? picture
                              : state.status == AuthStatus.uploadSuccess
                                  ? (state.data as User).picture
                                  : picture,
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
                    children: children,
                  ),
                ),
                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kMedium),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kSmall)),
                      minimumSize: Size(context.width, 50),
                    ),
                    onPressed: state.status == AuthStatus.loading
                        ? null
                        : () {
                            final payload = {
                              "firstName": _firstNameController.text.trim(),
                              "secondName": _lastNameController.text.trim(),
                              "email": _emailController.text.trim(),
                              "phoneNo": _phoneNumberController.text.trim(),
                              "dob": _dobController.text.trim(),
                              "picture": picture.toString(),
                            };

                            payload.removeWhere(
                                (key, value) => value == null || value.isEmpty);

                            _authBloc.add(
                                AuthEvent.editProfileData(request: payload));
                          },
                    child: Text(
                      state.status == AuthStatus.loading
                          ? 'Loading...'
                          : 'Update Profile',
                    ),
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.read<UserBloc>().add(UpdateUser(state.data));
          service<Talker>().info('Profile updated');
          //show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Profile updated'),
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
        if (state.status == AuthStatus.uploadSuccess) {
          context.read<UserBloc>().add(UpdateUser(state.data));
          service<Talker>().info('Profile updated');
          //show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Profile photo uploaded'),
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
          service<Talker>().error('Profile update failed');
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
          picture = state.data.picture;
          //show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Loading..."),
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
        if (state.status == AuthStatus.uploading) {
          service<Talker>().info('Loading');
          //show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Uploading..."),
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
    );
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, size: 22) : null,
      filled: true,
      fillColor: Colors.grey[100],
      labelStyle: const TextStyle(fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}
