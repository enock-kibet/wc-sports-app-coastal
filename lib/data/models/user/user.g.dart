// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      otherNames: (json['otherNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      otp: json['otp'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'otherNames': instance.otherNames,
      'phone': instance.phone,
      'email': instance.email,
      'isPhoneVerified': instance.isPhoneVerified,
      'isEmailVerified': instance.isEmailVerified,
      'isActive': instance.isActive,
      'otp': instance.otp,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };
