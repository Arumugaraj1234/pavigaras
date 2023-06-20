// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'freezed_data_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RequestOtpObject {
  String get mobileNo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RequestOtpObjectCopyWith<RequestOtpObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestOtpObjectCopyWith<$Res> {
  factory $RequestOtpObjectCopyWith(
          RequestOtpObject value, $Res Function(RequestOtpObject) then) =
      _$RequestOtpObjectCopyWithImpl<$Res>;
  $Res call({String mobileNo});
}

/// @nodoc
class _$RequestOtpObjectCopyWithImpl<$Res>
    implements $RequestOtpObjectCopyWith<$Res> {
  _$RequestOtpObjectCopyWithImpl(this._value, this._then);

  final RequestOtpObject _value;
  // ignore: unused_field
  final $Res Function(RequestOtpObject) _then;

  @override
  $Res call({
    Object? mobileNo = freezed,
  }) {
    return _then(_value.copyWith(
      mobileNo: mobileNo == freezed
          ? _value.mobileNo
          : mobileNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_RequestOtpObjectCopyWith<$Res>
    implements $RequestOtpObjectCopyWith<$Res> {
  factory _$$_RequestOtpObjectCopyWith(
          _$_RequestOtpObject value, $Res Function(_$_RequestOtpObject) then) =
      __$$_RequestOtpObjectCopyWithImpl<$Res>;
  @override
  $Res call({String mobileNo});
}

/// @nodoc
class __$$_RequestOtpObjectCopyWithImpl<$Res>
    extends _$RequestOtpObjectCopyWithImpl<$Res>
    implements _$$_RequestOtpObjectCopyWith<$Res> {
  __$$_RequestOtpObjectCopyWithImpl(
      _$_RequestOtpObject _value, $Res Function(_$_RequestOtpObject) _then)
      : super(_value, (v) => _then(v as _$_RequestOtpObject));

  @override
  _$_RequestOtpObject get _value => super._value as _$_RequestOtpObject;

  @override
  $Res call({
    Object? mobileNo = freezed,
  }) {
    return _then(_$_RequestOtpObject(
      mobileNo == freezed
          ? _value.mobileNo
          : mobileNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RequestOtpObject implements _RequestOtpObject {
  _$_RequestOtpObject(this.mobileNo);

  @override
  final String mobileNo;

  @override
  String toString() {
    return 'RequestOtpObject(mobileNo: $mobileNo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestOtpObject &&
            const DeepCollectionEquality().equals(other.mobileNo, mobileNo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(mobileNo));

  @JsonKey(ignore: true)
  @override
  _$$_RequestOtpObjectCopyWith<_$_RequestOtpObject> get copyWith =>
      __$$_RequestOtpObjectCopyWithImpl<_$_RequestOtpObject>(this, _$identity);
}

abstract class _RequestOtpObject implements RequestOtpObject {
  factory _RequestOtpObject(final String mobileNo) = _$_RequestOtpObject;

  @override
  String get mobileNo;
  @override
  @JsonKey(ignore: true)
  _$$_RequestOtpObjectCopyWith<_$_RequestOtpObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VerifyOtpObject {
  RequestOtp? get requestOtp => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VerifyOtpObjectCopyWith<VerifyOtpObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpObjectCopyWith<$Res> {
  factory $VerifyOtpObjectCopyWith(
          VerifyOtpObject value, $Res Function(VerifyOtpObject) then) =
      _$VerifyOtpObjectCopyWithImpl<$Res>;
  $Res call({RequestOtp? requestOtp, String otp});
}

/// @nodoc
class _$VerifyOtpObjectCopyWithImpl<$Res>
    implements $VerifyOtpObjectCopyWith<$Res> {
  _$VerifyOtpObjectCopyWithImpl(this._value, this._then);

  final VerifyOtpObject _value;
  // ignore: unused_field
  final $Res Function(VerifyOtpObject) _then;

  @override
  $Res call({
    Object? requestOtp = freezed,
    Object? otp = freezed,
  }) {
    return _then(_value.copyWith(
      requestOtp: requestOtp == freezed
          ? _value.requestOtp
          : requestOtp // ignore: cast_nullable_to_non_nullable
              as RequestOtp?,
      otp: otp == freezed
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_VerifyOtpObjectCopyWith<$Res>
    implements $VerifyOtpObjectCopyWith<$Res> {
  factory _$$_VerifyOtpObjectCopyWith(
          _$_VerifyOtpObject value, $Res Function(_$_VerifyOtpObject) then) =
      __$$_VerifyOtpObjectCopyWithImpl<$Res>;
  @override
  $Res call({RequestOtp? requestOtp, String otp});
}

/// @nodoc
class __$$_VerifyOtpObjectCopyWithImpl<$Res>
    extends _$VerifyOtpObjectCopyWithImpl<$Res>
    implements _$$_VerifyOtpObjectCopyWith<$Res> {
  __$$_VerifyOtpObjectCopyWithImpl(
      _$_VerifyOtpObject _value, $Res Function(_$_VerifyOtpObject) _then)
      : super(_value, (v) => _then(v as _$_VerifyOtpObject));

  @override
  _$_VerifyOtpObject get _value => super._value as _$_VerifyOtpObject;

  @override
  $Res call({
    Object? requestOtp = freezed,
    Object? otp = freezed,
  }) {
    return _then(_$_VerifyOtpObject(
      requestOtp == freezed
          ? _value.requestOtp
          : requestOtp // ignore: cast_nullable_to_non_nullable
              as RequestOtp?,
      otp == freezed
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_VerifyOtpObject implements _VerifyOtpObject {
  _$_VerifyOtpObject(this.requestOtp, this.otp);

  @override
  final RequestOtp? requestOtp;
  @override
  final String otp;

  @override
  String toString() {
    return 'VerifyOtpObject(requestOtp: $requestOtp, otp: $otp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VerifyOtpObject &&
            const DeepCollectionEquality()
                .equals(other.requestOtp, requestOtp) &&
            const DeepCollectionEquality().equals(other.otp, otp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(requestOtp),
      const DeepCollectionEquality().hash(otp));

  @JsonKey(ignore: true)
  @override
  _$$_VerifyOtpObjectCopyWith<_$_VerifyOtpObject> get copyWith =>
      __$$_VerifyOtpObjectCopyWithImpl<_$_VerifyOtpObject>(this, _$identity);
}

abstract class _VerifyOtpObject implements VerifyOtpObject {
  factory _VerifyOtpObject(final RequestOtp? requestOtp, final String otp) =
      _$_VerifyOtpObject;

  @override
  RequestOtp? get requestOtp;
  @override
  String get otp;
  @override
  @JsonKey(ignore: true)
  _$$_VerifyOtpObjectCopyWith<_$_VerifyOtpObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SearchAddressObject {
  GoogleAddress? get googleAddress => throw _privateConstructorUsedError;
  String get houseNo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchAddressObjectCopyWith<SearchAddressObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchAddressObjectCopyWith<$Res> {
  factory $SearchAddressObjectCopyWith(
          SearchAddressObject value, $Res Function(SearchAddressObject) then) =
      _$SearchAddressObjectCopyWithImpl<$Res>;
  $Res call({GoogleAddress? googleAddress, String houseNo});
}

/// @nodoc
class _$SearchAddressObjectCopyWithImpl<$Res>
    implements $SearchAddressObjectCopyWith<$Res> {
  _$SearchAddressObjectCopyWithImpl(this._value, this._then);

  final SearchAddressObject _value;
  // ignore: unused_field
  final $Res Function(SearchAddressObject) _then;

  @override
  $Res call({
    Object? googleAddress = freezed,
    Object? houseNo = freezed,
  }) {
    return _then(_value.copyWith(
      googleAddress: googleAddress == freezed
          ? _value.googleAddress
          : googleAddress // ignore: cast_nullable_to_non_nullable
              as GoogleAddress?,
      houseNo: houseNo == freezed
          ? _value.houseNo
          : houseNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SearchAddressObjectCopyWith<$Res>
    implements $SearchAddressObjectCopyWith<$Res> {
  factory _$$_SearchAddressObjectCopyWith(_$_SearchAddressObject value,
          $Res Function(_$_SearchAddressObject) then) =
      __$$_SearchAddressObjectCopyWithImpl<$Res>;
  @override
  $Res call({GoogleAddress? googleAddress, String houseNo});
}

/// @nodoc
class __$$_SearchAddressObjectCopyWithImpl<$Res>
    extends _$SearchAddressObjectCopyWithImpl<$Res>
    implements _$$_SearchAddressObjectCopyWith<$Res> {
  __$$_SearchAddressObjectCopyWithImpl(_$_SearchAddressObject _value,
      $Res Function(_$_SearchAddressObject) _then)
      : super(_value, (v) => _then(v as _$_SearchAddressObject));

  @override
  _$_SearchAddressObject get _value => super._value as _$_SearchAddressObject;

  @override
  $Res call({
    Object? googleAddress = freezed,
    Object? houseNo = freezed,
  }) {
    return _then(_$_SearchAddressObject(
      googleAddress == freezed
          ? _value.googleAddress
          : googleAddress // ignore: cast_nullable_to_non_nullable
              as GoogleAddress?,
      houseNo == freezed
          ? _value.houseNo
          : houseNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SearchAddressObject implements _SearchAddressObject {
  _$_SearchAddressObject(this.googleAddress, this.houseNo);

  @override
  final GoogleAddress? googleAddress;
  @override
  final String houseNo;

  @override
  String toString() {
    return 'SearchAddressObject(googleAddress: $googleAddress, houseNo: $houseNo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchAddressObject &&
            const DeepCollectionEquality()
                .equals(other.googleAddress, googleAddress) &&
            const DeepCollectionEquality().equals(other.houseNo, houseNo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(googleAddress),
      const DeepCollectionEquality().hash(houseNo));

  @JsonKey(ignore: true)
  @override
  _$$_SearchAddressObjectCopyWith<_$_SearchAddressObject> get copyWith =>
      __$$_SearchAddressObjectCopyWithImpl<_$_SearchAddressObject>(
          this, _$identity);
}

abstract class _SearchAddressObject implements SearchAddressObject {
  factory _SearchAddressObject(
          final GoogleAddress? googleAddress, final String houseNo) =
      _$_SearchAddressObject;

  @override
  GoogleAddress? get googleAddress;
  @override
  String get houseNo;
  @override
  @JsonKey(ignore: true)
  _$$_SearchAddressObjectCopyWith<_$_SearchAddressObject> get copyWith =>
      throw _privateConstructorUsedError;
}
