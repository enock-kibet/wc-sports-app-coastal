import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/utils/dotted.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    required String email,
    required bool emailVerified,
    required String? picture,
    required String? token,
    required String? refreshToken,
    required String? userID,
    required String? phoneNumber,
    required String? dateOfBirth,
  }) = _User;
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
// _$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
//   name: json['name']??json["username"]as String,
//   email: json['email'] as String,
//   emailVerified: json['emailVerified']??false as bool,
//   picture: addDomain(json['picture']??"") as String?,
// );
//
// Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
//     <String, dynamic>{
//       'name': instance.name,
//       'email': instance.email,
//       'emailVerified': instance.emailVerified,
//       'picture': instance.picture,
//     };
