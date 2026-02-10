// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resident.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Resident _$ResidentFromJson(Map<String, dynamic> json) {
  return _Resident.fromJson(json);
}

/// @nodoc
mixin _$Resident {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get building => throw _privateConstructorUsedError;
  String get apartment => throw _privateConstructorUsedError;
  int? get floor => throw _privateConstructorUsedError;
  int get monthlyFee => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  String? get pinCode => throw _privateConstructorUsedError;

  /// Serializes this Resident to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Resident
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResidentCopyWith<Resident> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResidentCopyWith<$Res> {
  factory $ResidentCopyWith(Resident value, $Res Function(Resident) then) =
      _$ResidentCopyWithImpl<$Res, Resident>;
  @useResult
  $Res call(
      {int id,
      String name,
      String phone,
      String building,
      String apartment,
      int? floor,
      int monthlyFee,
      DateTime startDate,
      String? pinCode});
}

/// @nodoc
class _$ResidentCopyWithImpl<$Res, $Val extends Resident>
    implements $ResidentCopyWith<$Res> {
  _$ResidentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Resident
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? building = null,
    Object? apartment = null,
    Object? floor = freezed,
    Object? monthlyFee = null,
    Object? startDate = null,
    Object? pinCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      building: null == building
          ? _value.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
      apartment: null == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int?,
      monthlyFee: null == monthlyFee
          ? _value.monthlyFee
          : monthlyFee // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pinCode: freezed == pinCode
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResidentImplCopyWith<$Res>
    implements $ResidentCopyWith<$Res> {
  factory _$$ResidentImplCopyWith(
          _$ResidentImpl value, $Res Function(_$ResidentImpl) then) =
      __$$ResidentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String phone,
      String building,
      String apartment,
      int? floor,
      int monthlyFee,
      DateTime startDate,
      String? pinCode});
}

/// @nodoc
class __$$ResidentImplCopyWithImpl<$Res>
    extends _$ResidentCopyWithImpl<$Res, _$ResidentImpl>
    implements _$$ResidentImplCopyWith<$Res> {
  __$$ResidentImplCopyWithImpl(
      _$ResidentImpl _value, $Res Function(_$ResidentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Resident
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? building = null,
    Object? apartment = null,
    Object? floor = freezed,
    Object? monthlyFee = null,
    Object? startDate = null,
    Object? pinCode = freezed,
  }) {
    return _then(_$ResidentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      building: null == building
          ? _value.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
      apartment: null == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int?,
      monthlyFee: null == monthlyFee
          ? _value.monthlyFee
          : monthlyFee // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pinCode: freezed == pinCode
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResidentImpl implements _Resident {
  const _$ResidentImpl(
      {required this.id,
      required this.name,
      required this.phone,
      required this.building,
      required this.apartment,
      this.floor,
      this.monthlyFee = 250,
      required this.startDate,
      this.pinCode});

  factory _$ResidentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResidentImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String building;
  @override
  final String apartment;
  @override
  final int? floor;
  @override
  @JsonKey()
  final int monthlyFee;
  @override
  final DateTime startDate;
  @override
  final String? pinCode;

  @override
  String toString() {
    return 'Resident(id: $id, name: $name, phone: $phone, building: $building, apartment: $apartment, floor: $floor, monthlyFee: $monthlyFee, startDate: $startDate, pinCode: $pinCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResidentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.building, building) ||
                other.building == building) &&
            (identical(other.apartment, apartment) ||
                other.apartment == apartment) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.monthlyFee, monthlyFee) ||
                other.monthlyFee == monthlyFee) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.pinCode, pinCode) || other.pinCode == pinCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, building,
      apartment, floor, monthlyFee, startDate, pinCode);

  /// Create a copy of Resident
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResidentImplCopyWith<_$ResidentImpl> get copyWith =>
      __$$ResidentImplCopyWithImpl<_$ResidentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResidentImplToJson(
      this,
    );
  }
}

abstract class _Resident implements Resident {
  const factory _Resident(
      {required final int id,
      required final String name,
      required final String phone,
      required final String building,
      required final String apartment,
      final int? floor,
      final int monthlyFee,
      required final DateTime startDate,
      final String? pinCode}) = _$ResidentImpl;

  factory _Resident.fromJson(Map<String, dynamic> json) =
      _$ResidentImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get phone;
  @override
  String get building;
  @override
  String get apartment;
  @override
  int? get floor;
  @override
  int get monthlyFee;
  @override
  DateTime get startDate;
  @override
  String? get pinCode;

  /// Create a copy of Resident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResidentImplCopyWith<_$ResidentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
