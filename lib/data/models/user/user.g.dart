// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      picture: json['picture'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      userID: json['userID'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'picture': instance.picture,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'userID': instance.userID,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
    };
