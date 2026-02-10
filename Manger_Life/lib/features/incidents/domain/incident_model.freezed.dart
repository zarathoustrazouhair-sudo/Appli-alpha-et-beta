// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incident_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IncidentModel _$IncidentModelFromJson(Map<String, dynamic> json) {
  return _IncidentModel.fromJson(json);
}

/// @nodoc
mixin _$IncidentModel {
  int get id =>
      throw _privateConstructorUsedError; // Supabase ID is int8 usually, or UUID string? Dashboard insert didn't return. Let's assume int for now or String. Repository used primaryKey: ['id'].
// Wait, drift uses Int for id. Supabase usually uses Int8 (bigint) or UUID.
// Let's use dynamic or int. Repository map uses `IncidentModel.fromJson(json)`.
// If Supabase `id` is big int, Dart `int` handles it (64-bit).
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_anonymous')
  bool get isAnonymous => throw _privateConstructorUsedError;
  @JsonKey(name: 'resident_phone')
  String get residentPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'apt_number')
  String get aptNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_urgent')
  bool get isUrgent => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_done')
  bool get isDone => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'resident_name')
  String? get residentName => throw _privateConstructorUsedError;

  /// Serializes this IncidentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncidentModelCopyWith<IncidentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentModelCopyWith<$Res> {
  factory $IncidentModelCopyWith(
          IncidentModel value, $Res Function(IncidentModel) then) =
      _$IncidentModelCopyWithImpl<$Res, IncidentModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      @JsonKey(name: 'is_anonymous') bool isAnonymous,
      @JsonKey(name: 'resident_phone') String residentPhone,
      @JsonKey(name: 'apt_number') String aptNumber,
      @JsonKey(name: 'is_urgent') bool isUrgent,
      @JsonKey(name: 'is_done') bool isDone,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'resident_name') String? residentName});
}

/// @nodoc
class _$IncidentModelCopyWithImpl<$Res, $Val extends IncidentModel>
    implements $IncidentModelCopyWith<$Res> {
  _$IncidentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isAnonymous = null,
    Object? residentPhone = null,
    Object? aptNumber = null,
    Object? isUrgent = null,
    Object? isDone = null,
    Object? createdAt = null,
    Object? residentName = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      residentPhone: null == residentPhone
          ? _value.residentPhone
          : residentPhone // ignore: cast_nullable_to_non_nullable
              as String,
      aptNumber: null == aptNumber
          ? _value.aptNumber
          : aptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      residentName: freezed == residentName
          ? _value.residentName
          : residentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncidentModelImplCopyWith<$Res>
    implements $IncidentModelCopyWith<$Res> {
  factory _$$IncidentModelImplCopyWith(
          _$IncidentModelImpl value, $Res Function(_$IncidentModelImpl) then) =
      __$$IncidentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      @JsonKey(name: 'is_anonymous') bool isAnonymous,
      @JsonKey(name: 'resident_phone') String residentPhone,
      @JsonKey(name: 'apt_number') String aptNumber,
      @JsonKey(name: 'is_urgent') bool isUrgent,
      @JsonKey(name: 'is_done') bool isDone,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'resident_name') String? residentName});
}

/// @nodoc
class __$$IncidentModelImplCopyWithImpl<$Res>
    extends _$IncidentModelCopyWithImpl<$Res, _$IncidentModelImpl>
    implements _$$IncidentModelImplCopyWith<$Res> {
  __$$IncidentModelImplCopyWithImpl(
      _$IncidentModelImpl _value, $Res Function(_$IncidentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isAnonymous = null,
    Object? residentPhone = null,
    Object? aptNumber = null,
    Object? isUrgent = null,
    Object? isDone = null,
    Object? createdAt = null,
    Object? residentName = freezed,
  }) {
    return _then(_$IncidentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      residentPhone: null == residentPhone
          ? _value.residentPhone
          : residentPhone // ignore: cast_nullable_to_non_nullable
              as String,
      aptNumber: null == aptNumber
          ? _value.aptNumber
          : aptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isUrgent: null == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      residentName: freezed == residentName
          ? _value.residentName
          : residentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentModelImpl extends _IncidentModel {
  const _$IncidentModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      @JsonKey(name: 'is_anonymous') required this.isAnonymous,
      @JsonKey(name: 'resident_phone') required this.residentPhone,
      @JsonKey(name: 'apt_number') required this.aptNumber,
      @JsonKey(name: 'is_urgent') this.isUrgent = false,
      @JsonKey(name: 'is_done') this.isDone = false,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'resident_name') this.residentName})
      : super._();

  factory _$IncidentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentModelImplFromJson(json);

  @override
  final int id;
// Supabase ID is int8 usually, or UUID string? Dashboard insert didn't return. Let's assume int for now or String. Repository used primaryKey: ['id'].
// Wait, drift uses Int for id. Supabase usually uses Int8 (bigint) or UUID.
// Let's use dynamic or int. Repository map uses `IncidentModel.fromJson(json)`.
// If Supabase `id` is big int, Dart `int` handles it (64-bit).
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'is_anonymous')
  final bool isAnonymous;
  @override
  @JsonKey(name: 'resident_phone')
  final String residentPhone;
  @override
  @JsonKey(name: 'apt_number')
  final String aptNumber;
  @override
  @JsonKey(name: 'is_urgent')
  final bool isUrgent;
  @override
  @JsonKey(name: 'is_done')
  final bool isDone;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'resident_name')
  final String? residentName;

  @override
  String toString() {
    return 'IncidentModel(id: $id, title: $title, description: $description, isAnonymous: $isAnonymous, residentPhone: $residentPhone, aptNumber: $aptNumber, isUrgent: $isUrgent, isDone: $isDone, createdAt: $createdAt, residentName: $residentName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.residentPhone, residentPhone) ||
                other.residentPhone == residentPhone) &&
            (identical(other.aptNumber, aptNumber) ||
                other.aptNumber == aptNumber) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.residentName, residentName) ||
                other.residentName == residentName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      isAnonymous,
      residentPhone,
      aptNumber,
      isUrgent,
      isDone,
      createdAt,
      residentName);

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentModelImplCopyWith<_$IncidentModelImpl> get copyWith =>
      __$$IncidentModelImplCopyWithImpl<_$IncidentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentModelImplToJson(
      this,
    );
  }
}

abstract class _IncidentModel extends IncidentModel {
  const factory _IncidentModel(
          {required final int id,
          required final String title,
          required final String description,
          @JsonKey(name: 'is_anonymous') required final bool isAnonymous,
          @JsonKey(name: 'resident_phone') required final String residentPhone,
          @JsonKey(name: 'apt_number') required final String aptNumber,
          @JsonKey(name: 'is_urgent') final bool isUrgent,
          @JsonKey(name: 'is_done') final bool isDone,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'resident_name') final String? residentName}) =
      _$IncidentModelImpl;
  const _IncidentModel._() : super._();

  factory _IncidentModel.fromJson(Map<String, dynamic> json) =
      _$IncidentModelImpl.fromJson;

  @override
  int get id; // Supabase ID is int8 usually, or UUID string? Dashboard insert didn't return. Let's assume int for now or String. Repository used primaryKey: ['id'].
// Wait, drift uses Int for id. Supabase usually uses Int8 (bigint) or UUID.
// Let's use dynamic or int. Repository map uses `IncidentModel.fromJson(json)`.
// If Supabase `id` is big int, Dart `int` handles it (64-bit).
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'is_anonymous')
  bool get isAnonymous;
  @override
  @JsonKey(name: 'resident_phone')
  String get residentPhone;
  @override
  @JsonKey(name: 'apt_number')
  String get aptNumber;
  @override
  @JsonKey(name: 'is_urgent')
  bool get isUrgent;
  @override
  @JsonKey(name: 'is_done')
  bool get isDone;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'resident_name')
  String? get residentName;

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncidentModelImplCopyWith<_$IncidentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
