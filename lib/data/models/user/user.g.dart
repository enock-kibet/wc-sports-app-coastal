// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name']??json["username"]as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      picture: addDomain(json['picture']) as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'picture': instance.picture,
    };
