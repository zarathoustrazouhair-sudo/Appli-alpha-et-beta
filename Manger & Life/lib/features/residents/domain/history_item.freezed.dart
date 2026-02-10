// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HistoryItem {
  double get amount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double amount, DateTime date) payment,
    required TResult Function(double amount, DateTime date, String label) due,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double amount, DateTime date)? payment,
    TResult? Function(double amount, DateTime date, String label)? due,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double amount, DateTime date)? payment,
    TResult Function(double amount, DateTime date, String label)? due,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentItem value) payment,
    required TResult Function(_DueItem value) due,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentItem value)? payment,
    TResult? Function(_DueItem value)? due,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentItem value)? payment,
    TResult Function(_DueItem value)? due,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryItemCopyWith<HistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryItemCopyWith<$Res> {
  factory $HistoryItemCopyWith(
          HistoryItem value, $Res Function(HistoryItem) then) =
      _$HistoryItemCopyWithImpl<$Res, HistoryItem>;
  @useResult
  $Res call({double amount, DateTime date});
}

/// @nodoc
class _$HistoryItemCopyWithImpl<$Res, $Val extends HistoryItem>
    implements $HistoryItemCopyWith<$Res> {
  _$HistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentItemImplCopyWith<$Res>
    implements $HistoryItemCopyWith<$Res> {
  factory _$$PaymentItemImplCopyWith(
          _$PaymentItemImpl value, $Res Function(_$PaymentItemImpl) then) =
      __$$PaymentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, double amount, DateTime date});
}

/// @nodoc
class __$$PaymentItemImplCopyWithImpl<$Res>
    extends _$HistoryItemCopyWithImpl<$Res, _$PaymentItemImpl>
    implements _$$PaymentItemImplCopyWith<$Res> {
  __$$PaymentItemImplCopyWithImpl(
      _$PaymentItemImpl _value, $Res Function(_$PaymentItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? date = null,
  }) {
    return _then(_$PaymentItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$PaymentItemImpl implements _PaymentItem {
  const _$PaymentItemImpl(
      {required this.id, required this.amount, required this.date});

  @override
  final int id;
  @override
  final double amount;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'HistoryItem.payment(id: $id, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, amount, date);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentItemImplCopyWith<_$PaymentItemImpl> get copyWith =>
      __$$PaymentItemImplCopyWithImpl<_$PaymentItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double amount, DateTime date) payment,
    required TResult Function(double amount, DateTime date, String label) due,
  }) {
    return payment(id, amount, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double amount, DateTime date)? payment,
    TResult? Function(double amount, DateTime date, String label)? due,
  }) {
    return payment?.call(id, amount, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double amount, DateTime date)? payment,
    TResult Function(double amount, DateTime date, String label)? due,
    required TResult orElse(),
  }) {
    if (payment != null) {
      return payment(id, amount, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentItem value) payment,
    required TResult Function(_DueItem value) due,
  }) {
    return payment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentItem value)? payment,
    TResult? Function(_DueItem value)? due,
  }) {
    return payment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentItem value)? payment,
    TResult Function(_DueItem value)? due,
    required TResult orElse(),
  }) {
    if (payment != null) {
      return payment(this);
    }
    return orElse();
  }
}

abstract class _PaymentItem implements HistoryItem {
  const factory _PaymentItem(
      {required final int id,
      required final double amount,
      required final DateTime date}) = _$PaymentItemImpl;

  int get id;
  @override
  double get amount;
  @override
  DateTime get date;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentItemImplCopyWith<_$PaymentItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DueItemImplCopyWith<$Res>
    implements $HistoryItemCopyWith<$Res> {
  factory _$$DueItemImplCopyWith(
          _$DueItemImpl value, $Res Function(_$DueItemImpl) then) =
      __$$DueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, DateTime date, String label});
}

/// @nodoc
class __$$DueItemImplCopyWithImpl<$Res>
    extends _$HistoryItemCopyWithImpl<$Res, _$DueItemImpl>
    implements _$$DueItemImplCopyWith<$Res> {
  __$$DueItemImplCopyWithImpl(
      _$DueItemImpl _value, $Res Function(_$DueItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? date = null,
    Object? label = null,
  }) {
    return _then(_$DueItemImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DueItemImpl implements _DueItem {
  const _$DueItemImpl(
      {required this.amount, required this.date, required this.label});

  @override
  final double amount;
  @override
  final DateTime date;
  @override
  final String label;

  @override
  String toString() {
    return 'HistoryItem.due(amount: $amount, date: $date, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DueItemImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, date, label);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DueItemImplCopyWith<_$DueItemImpl> get copyWith =>
      __$$DueItemImplCopyWithImpl<_$DueItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double amount, DateTime date) payment,
    required TResult Function(double amount, DateTime date, String label) due,
  }) {
    return due(amount, date, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double amount, DateTime date)? payment,
    TResult? Function(double amount, DateTime date, String label)? due,
  }) {
    return due?.call(amount, date, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double amount, DateTime date)? payment,
    TResult Function(double amount, DateTime date, String label)? due,
    required TResult orElse(),
  }) {
    if (due != null) {
      return due(amount, date, label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentItem value) payment,
    required TResult Function(_DueItem value) due,
  }) {
    return due(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentItem value)? payment,
    TResult? Function(_DueItem value)? due,
  }) {
    return due?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentItem value)? payment,
    TResult Function(_DueItem value)? due,
    required TResult orElse(),
  }) {
    if (due != null) {
      return due(this);
    }
    return orElse();
  }
}

abstract class _DueItem implements HistoryItem {
  const factory _DueItem(
      {required final double amount,
      required final DateTime date,
      required final String label}) = _$DueItemImpl;

  @override
  double get amount;
  @override
  DateTime get date;
  String get label;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DueItemImplCopyWith<_$DueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
