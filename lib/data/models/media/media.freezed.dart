// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MediaData _$MediaDataFromJson(Map<String, dynamic> json) {
  return _MediaData.fromJson(json);
}

/// @nodoc
mixin _$MediaData {
  List<Highlight> get recentHighlights => throw _privateConstructorUsedError;
  List<SeasonHighlight> get seasonHighlights =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaDataCopyWith<MediaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaDataCopyWith<$Res> {
  factory $MediaDataCopyWith(MediaData value, $Res Function(MediaData) then) =
      _$MediaDataCopyWithImpl<$Res, MediaData>;
  @useResult
  $Res call(
      {List<Highlight> recentHighlights,
      List<SeasonHighlight> seasonHighlights});
}

/// @nodoc
class _$MediaDataCopyWithImpl<$Res, $Val extends MediaData>
    implements $MediaDataCopyWith<$Res> {
  _$MediaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recentHighlights = null,
    Object? seasonHighlights = null,
  }) {
    return _then(_value.copyWith(
      recentHighlights: null == recentHighlights
          ? _value.recentHighlights
          : recentHighlights // ignore: cast_nullable_to_non_nullable
              as List<Highlight>,
      seasonHighlights: null == seasonHighlights
          ? _value.seasonHighlights
          : seasonHighlights // ignore: cast_nullable_to_non_nullable
              as List<SeasonHighlight>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaDataImplCopyWith<$Res>
    implements $MediaDataCopyWith<$Res> {
  factory _$$MediaDataImplCopyWith(
          _$MediaDataImpl value, $Res Function(_$MediaDataImpl) then) =
      __$$MediaDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Highlight> recentHighlights,
      List<SeasonHighlight> seasonHighlights});
}

/// @nodoc
class __$$MediaDataImplCopyWithImpl<$Res>
    extends _$MediaDataCopyWithImpl<$Res, _$MediaDataImpl>
    implements _$$MediaDataImplCopyWith<$Res> {
  __$$MediaDataImplCopyWithImpl(
      _$MediaDataImpl _value, $Res Function(_$MediaDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recentHighlights = null,
    Object? seasonHighlights = null,
  }) {
    return _then(_$MediaDataImpl(
      recentHighlights: null == recentHighlights
          ? _value._recentHighlights
          : recentHighlights // ignore: cast_nullable_to_non_nullable
              as List<Highlight>,
      seasonHighlights: null == seasonHighlights
          ? _value._seasonHighlights
          : seasonHighlights // ignore: cast_nullable_to_non_nullable
              as List<SeasonHighlight>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaDataImpl implements _MediaData {
  const _$MediaDataImpl(
      {required final List<Highlight> recentHighlights,
      required final List<SeasonHighlight> seasonHighlights})
      : _recentHighlights = recentHighlights,
        _seasonHighlights = seasonHighlights;

  factory _$MediaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaDataImplFromJson(json);

  final List<Highlight> _recentHighlights;
  @override
  List<Highlight> get recentHighlights {
    if (_recentHighlights is EqualUnmodifiableListView)
      return _recentHighlights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentHighlights);
  }

  final List<SeasonHighlight> _seasonHighlights;
  @override
  List<SeasonHighlight> get seasonHighlights {
    if (_seasonHighlights is EqualUnmodifiableListView)
      return _seasonHighlights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seasonHighlights);
  }

  @override
  String toString() {
    return 'MediaData(recentHighlights: $recentHighlights, seasonHighlights: $seasonHighlights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaDataImpl &&
            const DeepCollectionEquality()
                .equals(other._recentHighlights, _recentHighlights) &&
            const DeepCollectionEquality()
                .equals(other._seasonHighlights, _seasonHighlights));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recentHighlights),
      const DeepCollectionEquality().hash(_seasonHighlights));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaDataImplCopyWith<_$MediaDataImpl> get copyWith =>
      __$$MediaDataImplCopyWithImpl<_$MediaDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaDataImplToJson(
      this,
    );
  }
}

abstract class _MediaData implements MediaData {
  const factory _MediaData(
      {required final List<Highlight> recentHighlights,
      required final List<SeasonHighlight> seasonHighlights}) = _$MediaDataImpl;

  factory _MediaData.fromJson(Map<String, dynamic> json) =
      _$MediaDataImpl.fromJson;

  @override
  List<Highlight> get recentHighlights;
  @override
  List<SeasonHighlight> get seasonHighlights;
  @override
  @JsonKey(ignore: true)
  _$$MediaDataImplCopyWith<_$MediaDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Highlight _$HighlightFromJson(Map<String, dynamic> json) {
  return _Highlight.fromJson(json);
}

/// @nodoc
mixin _$Highlight {
  String get title => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HighlightCopyWith<Highlight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HighlightCopyWith<$Res> {
  factory $HighlightCopyWith(Highlight value, $Res Function(Highlight) then) =
      _$HighlightCopyWithImpl<$Res, Highlight>;
  @useResult
  $Res call({String title, String image});
}

/// @nodoc
class _$HighlightCopyWithImpl<$Res, $Val extends Highlight>
    implements $HighlightCopyWith<$Res> {
  _$HighlightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HighlightImplCopyWith<$Res>
    implements $HighlightCopyWith<$Res> {
  factory _$$HighlightImplCopyWith(
          _$HighlightImpl value, $Res Function(_$HighlightImpl) then) =
      __$$HighlightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String image});
}

/// @nodoc
class __$$HighlightImplCopyWithImpl<$Res>
    extends _$HighlightCopyWithImpl<$Res, _$HighlightImpl>
    implements _$$HighlightImplCopyWith<$Res> {
  __$$HighlightImplCopyWithImpl(
      _$HighlightImpl _value, $Res Function(_$HighlightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
  }) {
    return _then(_$HighlightImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HighlightImpl implements _Highlight {
  const _$HighlightImpl({required this.title, required this.image});

  factory _$HighlightImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighlightImplFromJson(json);

  @override
  final String title;
  @override
  final String image;

  @override
  String toString() {
    return 'Highlight(title: $title, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HighlightImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HighlightImplCopyWith<_$HighlightImpl> get copyWith =>
      __$$HighlightImplCopyWithImpl<_$HighlightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HighlightImplToJson(
      this,
    );
  }
}

abstract class _Highlight implements Highlight {
  const factory _Highlight(
      {required final String title,
      required final String image}) = _$HighlightImpl;

  factory _Highlight.fromJson(Map<String, dynamic> json) =
      _$HighlightImpl.fromJson;

  @override
  String get title;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$HighlightImplCopyWith<_$HighlightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeasonHighlight _$SeasonHighlightFromJson(Map<String, dynamic> json) {
  return _SeasonHighlight.fromJson(json);
}

/// @nodoc
mixin _$SeasonHighlight {
  String get title => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeasonHighlightCopyWith<SeasonHighlight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonHighlightCopyWith<$Res> {
  factory $SeasonHighlightCopyWith(
          SeasonHighlight value, $Res Function(SeasonHighlight) then) =
      _$SeasonHighlightCopyWithImpl<$Res, SeasonHighlight>;
  @useResult
  $Res call({String title, String image, String time, String date});
}

/// @nodoc
class _$SeasonHighlightCopyWithImpl<$Res, $Val extends SeasonHighlight>
    implements $SeasonHighlightCopyWith<$Res> {
  _$SeasonHighlightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
    Object? time = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeasonHighlightImplCopyWith<$Res>
    implements $SeasonHighlightCopyWith<$Res> {
  factory _$$SeasonHighlightImplCopyWith(_$SeasonHighlightImpl value,
          $Res Function(_$SeasonHighlightImpl) then) =
      __$$SeasonHighlightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String image, String time, String date});
}

/// @nodoc
class __$$SeasonHighlightImplCopyWithImpl<$Res>
    extends _$SeasonHighlightCopyWithImpl<$Res, _$SeasonHighlightImpl>
    implements _$$SeasonHighlightImplCopyWith<$Res> {
  __$$SeasonHighlightImplCopyWithImpl(
      _$SeasonHighlightImpl _value, $Res Function(_$SeasonHighlightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
    Object? time = null,
    Object? date = null,
  }) {
    return _then(_$SeasonHighlightImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonHighlightImpl implements _SeasonHighlight {
  const _$SeasonHighlightImpl(
      {required this.title,
      required this.image,
      required this.time,
      required this.date});

  factory _$SeasonHighlightImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonHighlightImplFromJson(json);

  @override
  final String title;
  @override
  final String image;
  @override
  final String time;
  @override
  final String date;

  @override
  String toString() {
    return 'SeasonHighlight(title: $title, image: $image, time: $time, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonHighlightImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, image, time, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonHighlightImplCopyWith<_$SeasonHighlightImpl> get copyWith =>
      __$$SeasonHighlightImplCopyWithImpl<_$SeasonHighlightImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonHighlightImplToJson(
      this,
    );
  }
}

abstract class _SeasonHighlight implements SeasonHighlight {
  const factory _SeasonHighlight(
      {required final String title,
      required final String image,
      required final String time,
      required final String date}) = _$SeasonHighlightImpl;

  factory _SeasonHighlight.fromJson(Map<String, dynamic> json) =
      _$SeasonHighlightImpl.fromJson;

  @override
  String get title;
  @override
  String get image;
  @override
  String get time;
  @override
  String get date;
  @override
  @JsonKey(ignore: true)
  _$$SeasonHighlightImplCopyWith<_$SeasonHighlightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
