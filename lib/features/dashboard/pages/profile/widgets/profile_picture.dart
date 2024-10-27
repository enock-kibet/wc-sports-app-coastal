import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? picture;
  final String? profilePicture;

  const ProfilePicture({
    super.key,
    this.picture,
    this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return picture == "" || picture == null || picture!.isEmpty
        ? profilePicture == "" ||
                profilePicture == null ||
                profilePicture!.isEmpty
            ? Icon(
                CupertinoIcons.person_alt_circle,
                size: 124,
                color: Colors.grey[300],
              )
            : CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(
                  base64Decode(profilePicture!.split(',').last),
                ),
              )
        : ClipRRect(
            borderRadius: BorderRadius.circular(124),
            child: CachedNetworkImage(
              imageUrl: picture!,
              width: 124,
              height: 124,
              fit: BoxFit.cover,
            ),
          );
  }
}
