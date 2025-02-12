import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/theme/app_colors.dart';

class ProfilePicture extends StatelessWidget {
  final String? picture;

  const ProfilePicture({
    super.key,
    this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
            borderRadius: BorderRadius.circular(124),
            child: CachedNetworkImage(
              imageUrl: picture??"",
              errorWidget: (context, url, error) => Icon(Icons.person,size: 64,color: AppColors.blackColor),
              width: 124,
              height: 124,
              fit: BoxFit.cover,
            ),
          );
  }
}
