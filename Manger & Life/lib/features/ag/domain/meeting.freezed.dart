// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Meeting _$MeetingFromJson(Map<String, dynamic> json) {
  return _Meeting.fromJson(json);
}

/// @nodoc
mixin _$Meeting {
  int get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get agenda => throw _privateConstructorUsedError;
  MeetingStatus get status => throw _privateConstructorUsedError;

  /// Serializes this Meeting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meeting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeetingCopyWith<Meeting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingCopyWith<$Res> {
  factory $MeetingCopyWith(Meeting value, $Res Function(Meeting) then) =
      _$MeetingCopyWithImpl<$Res, Meeting>;
  @useResult
  $Res call(
      {int id,
      DateTime date,
      String location,
      String agenda,
      MeetingStatus status});
}

/// @nodoc
class _$MeetingCopyWithImpl<$Res, $Val extends Meeting>
    implements $MeetingCopyWith<$Res> {
  _$MeetingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meeting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? location = null,
    Object? agenda = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      agenda: null == agenda
          ? _value.agenda
          : agenda // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MeetingStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeetingImplCopyWith<$Res> implements $MeetingCopyWith<$Res> {
  factory _$$MeetingImplCopyWith(
          _$MeetingImpl value, $Res Function(_$MeetingImpl) then) =
      __$$MeetingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime date,
      String location,
      String agenda,
      MeetingStatus status});
}

/// @nodoc
class __$$MeetingImplCopyWithImpl<$Res>
    extends _$MeetingCopyWithImpl<$Res, _$MeetingImpl>
    implements _$$MeetingImplCopyWith<$Res> {
  __$$MeetingImplCopyWithImpl(
      _$MeetingImpl _value, $Res Function(_$MeetingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Meeting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? location = null,
    Object? agenda = null,
    Object? status = null,
  }) {
    return _then(_$MeetingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      agenda: null == agenda
          ? _value.agenda
          : agenda // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MeetingStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetingImpl implements _Meeting {
  const _$MeetingImpl(
      {required this.id,
      required this.date,
      required this.location,
      required this.agenda,
      required this.status});

  factory _$MeetingImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime date;
  @override
  final String location;
  @override
  final String agenda;
  @override
  final MeetingStatus status;

  @override
  String toString() {
    return 'Meeting(id: $id, date: $date, location: $location, agenda: $agenda, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.agenda, agenda) || other.agenda == agenda) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, location, agenda, status);

  /// Create a copy of Meeting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingImplCopyWith<_$MeetingImpl> get copyWith =>
      __$$MeetingImplCopyWithImpl<_$MeetingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingImplToJson(
      this,
    );
  }
}

abstract class _Meeting implements Meeting {
  const factory _Meeting(
      {required final int id,
      required final DateTime date,
      required final String location,
      required final String agenda,
      required final MeetingStatus status}) = _$MeetingImpl;

  factory _Meeting.fromJson(Map<String, dynamic> json) = _$MeetingImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get date;
  @override
  String get location;
  @override
  String get agenda;
  @override
  MeetingStatus get status;

  /// Create a copy of Meeting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeetingImplCopyWith<_$MeetingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
