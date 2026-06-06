// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Notifications _$NotificationsFromJson(Map<String, dynamic> json) {
  return _Notifications.fromJson(json);
}

/// @nodoc
mixin _$Notifications {
  @JsonKey(defaultValue: 0)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get userId => throw _privateConstructorUsedError;
  String? get cartId => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get notificationType => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get channel => throw _privateConstructorUsedError;
  String? get campaignId => throw _privateConstructorUsedError;
  String? get attributionWindow => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get notificationKey => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get createdUtc => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get updatedUtc => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get notificationText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsCopyWith<Notifications> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsCopyWith<$Res> {
  factory $NotificationsCopyWith(
          Notifications value, $Res Function(Notifications) then) =
      _$NotificationsCopyWithImpl<$Res, Notifications>;
  @useResult
  $Res call(
      {@JsonKey(defaultValue: 0) int id,
      @JsonKey(defaultValue: '') String userId,
      String? cartId,
      @JsonKey(defaultValue: '') String notificationType,
      @JsonKey(defaultValue: '') String channel,
      String? campaignId,
      String? attributionWindow,
      @JsonKey(defaultValue: '') String notificationKey,
      @JsonKey(defaultValue: '') String createdUtc,
      @JsonKey(defaultValue: '') String updatedUtc,
      @JsonKey(defaultValue: '') String notificationText});
}

/// @nodoc
class _$NotificationsCopyWithImpl<$Res, $Val extends Notifications>
    implements $NotificationsCopyWith<$Res> {
  _$NotificationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cartId = freezed,
    Object? notificationType = null,
    Object? channel = null,
    Object? campaignId = freezed,
    Object? attributionWindow = freezed,
    Object? notificationKey = null,
    Object? createdUtc = null,
    Object? updatedUtc = null,
    Object? notificationText = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cartId: freezed == cartId
          ? _value.cartId
          : cartId // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: null == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      campaignId: freezed == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String?,
      attributionWindow: freezed == attributionWindow
          ? _value.attributionWindow
          : attributionWindow // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationKey: null == notificationKey
          ? _value.notificationKey
          : notificationKey // ignore: cast_nullable_to_non_nullable
              as String,
      createdUtc: null == createdUtc
          ? _value.createdUtc
          : createdUtc // ignore: cast_nullable_to_non_nullable
              as String,
      updatedUtc: null == updatedUtc
          ? _value.updatedUtc
          : updatedUtc // ignore: cast_nullable_to_non_nullable
              as String,
      notificationText: null == notificationText
          ? _value.notificationText
          : notificationText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationsImplCopyWith<$Res>
    implements $NotificationsCopyWith<$Res> {
  factory _$$NotificationsImplCopyWith(
          _$NotificationsImpl value, $Res Function(_$NotificationsImpl) then) =
      __$$NotificationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: 0) int id,
      @JsonKey(defaultValue: '') String userId,
      String? cartId,
      @JsonKey(defaultValue: '') String notificationType,
      @JsonKey(defaultValue: '') String channel,
      String? campaignId,
      String? attributionWindow,
      @JsonKey(defaultValue: '') String notificationKey,
      @JsonKey(defaultValue: '') String createdUtc,
      @JsonKey(defaultValue: '') String updatedUtc,
      @JsonKey(defaultValue: '') String notificationText});
}

/// @nodoc
class __$$NotificationsImplCopyWithImpl<$Res>
    extends _$NotificationsCopyWithImpl<$Res, _$NotificationsImpl>
    implements _$$NotificationsImplCopyWith<$Res> {
  __$$NotificationsImplCopyWithImpl(
      _$NotificationsImpl _value, $Res Function(_$NotificationsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cartId = freezed,
    Object? notificationType = null,
    Object? channel = null,
    Object? campaignId = freezed,
    Object? attributionWindow = freezed,
    Object? notificationKey = null,
    Object? createdUtc = null,
    Object? updatedUtc = null,
    Object? notificationText = null,
  }) {
    return _then(_$NotificationsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cartId: freezed == cartId
          ? _value.cartId
          : cartId // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: null == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      campaignId: freezed == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String?,
      attributionWindow: freezed == attributionWindow
          ? _value.attributionWindow
          : attributionWindow // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationKey: null == notificationKey
          ? _value.notificationKey
          : notificationKey // ignore: cast_nullable_to_non_nullable
              as String,
      createdUtc: null == createdUtc
          ? _value.createdUtc
          : createdUtc // ignore: cast_nullable_to_non_nullable
              as String,
      updatedUtc: null == updatedUtc
          ? _value.updatedUtc
          : updatedUtc // ignore: cast_nullable_to_non_nullable
              as String,
      notificationText: null == notificationText
          ? _value.notificationText
          : notificationText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsImpl implements _Notifications {
  const _$NotificationsImpl(
      {@JsonKey(defaultValue: 0) required this.id,
      @JsonKey(defaultValue: '') required this.userId,
      this.cartId,
      @JsonKey(defaultValue: '') required this.notificationType,
      @JsonKey(defaultValue: '') required this.channel,
      this.campaignId,
      this.attributionWindow,
      @JsonKey(defaultValue: '') required this.notificationKey,
      @JsonKey(defaultValue: '') required this.createdUtc,
      @JsonKey(defaultValue: '') required this.updatedUtc,
      @JsonKey(defaultValue: '') required this.notificationText});

  factory _$NotificationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsImplFromJson(json);

  @override
  @JsonKey(defaultValue: 0)
  final int id;
  @override
  @JsonKey(defaultValue: '')
  final String userId;
  @override
  final String? cartId;
  @override
  @JsonKey(defaultValue: '')
  final String notificationType;
  @override
  @JsonKey(defaultValue: '')
  final String channel;
  @override
  final String? campaignId;
  @override
  final String? attributionWindow;
  @override
  @JsonKey(defaultValue: '')
  final String notificationKey;
  @override
  @JsonKey(defaultValue: '')
  final String createdUtc;
  @override
  @JsonKey(defaultValue: '')
  final String updatedUtc;
  @override
  @JsonKey(defaultValue: '')
  final String notificationText;

  @override
  String toString() {
    return 'Notifications(id: $id, userId: $userId, cartId: $cartId, notificationType: $notificationType, channel: $channel, campaignId: $campaignId, attributionWindow: $attributionWindow, notificationKey: $notificationKey, createdUtc: $createdUtc, updatedUtc: $updatedUtc, notificationText: $notificationText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cartId, cartId) || other.cartId == cartId) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.attributionWindow, attributionWindow) ||
                other.attributionWindow == attributionWindow) &&
            (identical(other.notificationKey, notificationKey) ||
                other.notificationKey == notificationKey) &&
            (identical(other.createdUtc, createdUtc) ||
                other.createdUtc == createdUtc) &&
            (identical(other.updatedUtc, updatedUtc) ||
                other.updatedUtc == updatedUtc) &&
            (identical(other.notificationText, notificationText) ||
                other.notificationText == notificationText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      cartId,
      notificationType,
      channel,
      campaignId,
      attributionWindow,
      notificationKey,
      createdUtc,
      updatedUtc,
      notificationText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsImplCopyWith<_$NotificationsImpl> get copyWith =>
      __$$NotificationsImplCopyWithImpl<_$NotificationsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsImplToJson(
      this,
    );
  }
}

abstract class _Notifications implements Notifications {
  const factory _Notifications(
          {@JsonKey(defaultValue: 0) required final int id,
          @JsonKey(defaultValue: '') required final String userId,
          final String? cartId,
          @JsonKey(defaultValue: '') required final String notificationType,
          @JsonKey(defaultValue: '') required final String channel,
          final String? campaignId,
          final String? attributionWindow,
          @JsonKey(defaultValue: '') required final String notificationKey,
          @JsonKey(defaultValue: '') required final String createdUtc,
          @JsonKey(defaultValue: '') required final String updatedUtc,
          @JsonKey(defaultValue: '') required final String notificationText}) =
      _$NotificationsImpl;

  factory _Notifications.fromJson(Map<String, dynamic> json) =
      _$NotificationsImpl.fromJson;

  @override
  @JsonKey(defaultValue: 0)
  int get id;
  @override
  @JsonKey(defaultValue: '')
  String get userId;
  @override
  String? get cartId;
  @override
  @JsonKey(defaultValue: '')
  String get notificationType;
  @override
  @JsonKey(defaultValue: '')
  String get channel;
  @override
  String? get campaignId;
  @override
  String? get attributionWindow;
  @override
  @JsonKey(defaultValue: '')
  String get notificationKey;
  @override
  @JsonKey(defaultValue: '')
  String get createdUtc;
  @override
  @JsonKey(defaultValue: '')
  String get updatedUtc;
  @override
  @JsonKey(defaultValue: '')
  String get notificationText;
  @override
  @JsonKey(ignore: true)
  _$$NotificationsImplCopyWith<_$NotificationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
