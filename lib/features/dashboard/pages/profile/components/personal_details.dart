import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';

import 'package:mime/mime.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/common/extension/extension.dart';
import 'package:sports_app/common/huge_icon_button.dart';
import 'package:sports_app/features/dashboard/pages/profile/widgets/profile_picture.dart';


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
  num? roleId;
  String? profilePicture;
  String? picture;

  Future<void> selectProfilePicture() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final file = File(result.files.single.path!);
      final croppedFile = await _cropImage(file);

      if (croppedFile != null) {
        final base64String = await _encodeImage(croppedFile);
        setState(() {
          profilePicture = base64String;
        });
      }
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
    super.didChangeDependencies();
    const user = null;
    _firstNameController = TextEditingController(text: user?.firstname ?? '');
    _usernameController = TextEditingController(text: user?.username ?? '');
    _lastNameController = TextEditingController(text: user?.lastname ?? '');
    _dobController = TextEditingController(text: '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneNumberController = TextEditingController(text: user?.phone ?? '');

    picture = user?.picture ?? '';
    roleId = user?.roleId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HugeIconButton(icon: HugeIcons.strokeRoundedArrowLeft01,onPressed: (){
                  context.pop();
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
                onTap: selectProfilePicture,
                child: Stack(
                  
                  children: [
                    ProfilePicture(
                      picture: picture,
                      profilePicture: profilePicture,
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
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                  ),
                  const SizedBox(height: kSmall),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'Middle Name',
                    ),
                  ),
                  const SizedBox(height: kSmall),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                  ),
                  const SizedBox(height: kSmall),
                  GestureDetector(
                    onTap: () async {
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
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: kSmall),
                  TextFormField(
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
                  onPressed: () {
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
  }
}
