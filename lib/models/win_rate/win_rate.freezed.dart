// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'win_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WinRate _$WinRateFromJson(Map<String, dynamic> json) {
  return _WinRate.fromJson(json);
}

/// @nodoc
mixin _$WinRate {
  String? get id => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WinRateCopyWith<WinRate> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WinRateCopyWith<$Res> {
  factory $WinRateCopyWith(WinRate value, $Res Function(WinRate) then) =
      _$WinRateCopyWithImpl<$Res, WinRate>;
  @useResult
  $Res call({String? id, int value});
}

/// @nodoc
class _$WinRateCopyWithImpl<$Res, $Val extends WinRate>
    implements $WinRateCopyWith<$Res> {
  _$WinRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WinRateCopyWith<$Res> implements $WinRateCopyWith<$Res> {
  factory _$$_WinRateCopyWith(
          _$_WinRate value, $Res Function(_$_WinRate) then) =
      __$$_WinRateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, int value});
}

/// @nodoc
class __$$_WinRateCopyWithImpl<$Res>
    extends _$WinRateCopyWithImpl<$Res, _$_WinRate>
    implements _$$_WinRateCopyWith<$Res> {
  __$$_WinRateCopyWithImpl(_$_WinRate _value, $Res Function(_$_WinRate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? value = null,
  }) {
    return _then(_$_WinRate(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WinRate extends _WinRate with DiagnosticableTreeMixin {
  const _$_WinRate({this.id, required this.value}) : super._();

  factory _$_WinRate.fromJson(Map<String, dynamic> json) =>
      _$$_WinRateFromJson(json);

  @override
  final String? id;
  @override
  final int value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WinRate(id: $id, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WinRate'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WinRate &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WinRateCopyWith<_$_WinRate> get copyWith =>
      __$$_WinRateCopyWithImpl<_$_WinRate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WinRateToJson(
      this,
    );
  }
}

abstract class _WinRate extends WinRate {
  const factory _WinRate({final String? id, required final int value}) =
      _$_WinRate;
  const _WinRate._() : super._();

  factory _WinRate.fromJson(Map<String, dynamic> json) = _$_WinRate.fromJson;

  @override
  String? get id;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$_WinRateCopyWith<_$_WinRate> get copyWith =>
      throw _privateConstructorUsedError;
}
