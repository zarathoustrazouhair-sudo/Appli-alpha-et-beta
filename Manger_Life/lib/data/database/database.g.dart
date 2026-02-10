// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ResidentsTable extends Residents
    with TableInfo<$ResidentsTable, Resident> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResidentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _buildingMeta =
      const VerificationMeta('building');
  @override
  late final GeneratedColumn<String> building = GeneratedColumn<String>(
      'building', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('B'));
  static const VerificationMeta _apartmentMeta =
      const VerificationMeta('apartment');
  @override
  late final GeneratedColumn<String> apartment = GeneratedColumn<String>(
      'apartment', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('0'));
  static const VerificationMeta _floorMeta = const VerificationMeta('floor');
  @override
  late final GeneratedColumn<int> floor = GeneratedColumn<int>(
      'floor', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _monthlyFeeMeta =
      const VerificationMeta('monthlyFee');
  @override
  late final GeneratedColumn<int> monthlyFee = GeneratedColumn<int>(
      'monthly_fee', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(250));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  static const VerificationMeta _pinCodeMeta =
      const VerificationMeta('pinCode');
  @override
  late final GeneratedColumn<String> pinCode = GeneratedColumn<String>(
      'pin_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phone,
        building,
        apartment,
        floor,
        monthlyFee,
        startDate,
        pinCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'residents';
  @override
  VerificationContext validateIntegrity(Insertable<Resident> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('building')) {
      context.handle(_buildingMeta,
          building.isAcceptableOrUnknown(data['building']!, _buildingMeta));
    }
    if (data.containsKey('apartment')) {
      context.handle(_apartmentMeta,
          apartment.isAcceptableOrUnknown(data['apartment']!, _apartmentMeta));
    }
    if (data.containsKey('floor')) {
      context.handle(
          _floorMeta, floor.isAcceptableOrUnknown(data['floor']!, _floorMeta));
    }
    if (data.containsKey('monthly_fee')) {
      context.handle(
          _monthlyFeeMeta,
          monthlyFee.isAcceptableOrUnknown(
              data['monthly_fee']!, _monthlyFeeMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('pin_code')) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableOrUnknown(data['pin_code']!, _pinCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Resident map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Resident(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      building: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}building'])!,
      apartment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apartment'])!,
      floor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}floor']),
      monthlyFee: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}monthly_fee'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      pinCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin_code']),
    );
  }

  @override
  $ResidentsTable createAlias(String alias) {
    return $ResidentsTable(attachedDatabase, alias);
  }
}

class Resident extends DataClass implements Insertable<Resident> {
  final int id;
  final String name;
  final String phone;
  final String building;
  final String apartment;
  final int? floor;
  final int monthlyFee;
  final DateTime startDate;
  final String? pinCode;
  const Resident(
      {required this.id,
      required this.name,
      required this.phone,
      required this.building,
      required this.apartment,
      this.floor,
      required this.monthlyFee,
      required this.startDate,
      this.pinCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['building'] = Variable<String>(building);
    map['apartment'] = Variable<String>(apartment);
    if (!nullToAbsent || floor != null) {
      map['floor'] = Variable<int>(floor);
    }
    map['monthly_fee'] = Variable<int>(monthlyFee);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || pinCode != null) {
      map['pin_code'] = Variable<String>(pinCode);
    }
    return map;
  }

  ResidentsCompanion toCompanion(bool nullToAbsent) {
    return ResidentsCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      building: Value(building),
      apartment: Value(apartment),
      floor:
          floor == null && nullToAbsent ? const Value.absent() : Value(floor),
      monthlyFee: Value(monthlyFee),
      startDate: Value(startDate),
      pinCode: pinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pinCode),
    );
  }

  factory Resident.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Resident(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      building: serializer.fromJson<String>(json['building']),
      apartment: serializer.fromJson<String>(json['apartment']),
      floor: serializer.fromJson<int?>(json['floor']),
      monthlyFee: serializer.fromJson<int>(json['monthlyFee']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      pinCode: serializer.fromJson<String?>(json['pinCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'building': serializer.toJson<String>(building),
      'apartment': serializer.toJson<String>(apartment),
      'floor': serializer.toJson<int?>(floor),
      'monthlyFee': serializer.toJson<int>(monthlyFee),
      'startDate': serializer.toJson<DateTime>(startDate),
      'pinCode': serializer.toJson<String?>(pinCode),
    };
  }

  Resident copyWith(
          {int? id,
          String? name,
          String? phone,
          String? building,
          String? apartment,
          Value<int?> floor = const Value.absent(),
          int? monthlyFee,
          DateTime? startDate,
          Value<String?> pinCode = const Value.absent()}) =>
      Resident(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        building: building ?? this.building,
        apartment: apartment ?? this.apartment,
        floor: floor.present ? floor.value : this.floor,
        monthlyFee: monthlyFee ?? this.monthlyFee,
        startDate: startDate ?? this.startDate,
        pinCode: pinCode.present ? pinCode.value : this.pinCode,
      );
  Resident copyWithCompanion(ResidentsCompanion data) {
    return Resident(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      building: data.building.present ? data.building.value : this.building,
      apartment: data.apartment.present ? data.apartment.value : this.apartment,
      floor: data.floor.present ? data.floor.value : this.floor,
      monthlyFee:
          data.monthlyFee.present ? data.monthlyFee.value : this.monthlyFee,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      pinCode: data.pinCode.present ? data.pinCode.value : this.pinCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Resident(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('building: $building, ')
          ..write('apartment: $apartment, ')
          ..write('floor: $floor, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('startDate: $startDate, ')
          ..write('pinCode: $pinCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, building, apartment, floor,
      monthlyFee, startDate, pinCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Resident &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.building == this.building &&
          other.apartment == this.apartment &&
          other.floor == this.floor &&
          other.monthlyFee == this.monthlyFee &&
          other.startDate == this.startDate &&
          other.pinCode == this.pinCode);
}

class ResidentsCompanion extends UpdateCompanion<Resident> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> building;
  final Value<String> apartment;
  final Value<int?> floor;
  final Value<int> monthlyFee;
  final Value<DateTime> startDate;
  final Value<String?> pinCode;
  const ResidentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.building = const Value.absent(),
    this.apartment = const Value.absent(),
    this.floor = const Value.absent(),
    this.monthlyFee = const Value.absent(),
    this.startDate = const Value.absent(),
    this.pinCode = const Value.absent(),
  });
  ResidentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.building = const Value.absent(),
    this.apartment = const Value.absent(),
    this.floor = const Value.absent(),
    this.monthlyFee = const Value.absent(),
    this.startDate = const Value.absent(),
    this.pinCode = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Resident> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? building,
    Expression<String>? apartment,
    Expression<int>? floor,
    Expression<int>? monthlyFee,
    Expression<DateTime>? startDate,
    Expression<String>? pinCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (building != null) 'building': building,
      if (apartment != null) 'apartment': apartment,
      if (floor != null) 'floor': floor,
      if (monthlyFee != null) 'monthly_fee': monthlyFee,
      if (startDate != null) 'start_date': startDate,
      if (pinCode != null) 'pin_code': pinCode,
    });
  }

  ResidentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? phone,
      Value<String>? building,
      Value<String>? apartment,
      Value<int?>? floor,
      Value<int>? monthlyFee,
      Value<DateTime>? startDate,
      Value<String?>? pinCode}) {
    return ResidentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      building: building ?? this.building,
      apartment: apartment ?? this.apartment,
      floor: floor ?? this.floor,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      startDate: startDate ?? this.startDate,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (building.present) {
      map['building'] = Variable<String>(building.value);
    }
    if (apartment.present) {
      map['apartment'] = Variable<String>(apartment.value);
    }
    if (floor.present) {
      map['floor'] = Variable<int>(floor.value);
    }
    if (monthlyFee.present) {
      map['monthly_fee'] = Variable<int>(monthlyFee.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (pinCode.present) {
      map['pin_code'] = Variable<String>(pinCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResidentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('building: $building, ')
          ..write('apartment: $apartment, ')
          ..write('floor: $floor, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('startDate: $startDate, ')
          ..write('pinCode: $pinCode')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _residentIdMeta =
      const VerificationMeta('residentId');
  @override
  late final GeneratedColumn<int> residentId = GeneratedColumn<int>(
      'resident_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES residents (id) ON DELETE RESTRICT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, residentId, amount, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('resident_id')) {
      context.handle(
          _residentIdMeta,
          residentId.isAcceptableOrUnknown(
              data['resident_id']!, _residentIdMeta));
    } else if (isInserting) {
      context.missing(_residentIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      residentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}resident_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int residentId;
  final double amount;
  final DateTime date;
  const Payment(
      {required this.id,
      required this.residentId,
      required this.amount,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['resident_id'] = Variable<int>(residentId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      residentId: Value(residentId),
      amount: Value(amount),
      date: Value(date),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      residentId: serializer.fromJson<int>(json['residentId']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'residentId': serializer.toJson<int>(residentId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Payment copyWith(
          {int? id, int? residentId, double? amount, DateTime? date}) =>
      Payment(
        id: id ?? this.id,
        residentId: residentId ?? this.residentId,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      residentId:
          data.residentId.present ? data.residentId.value : this.residentId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('residentId: $residentId, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, residentId, amount, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.residentId == this.residentId &&
          other.amount == this.amount &&
          other.date == this.date);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> residentId;
  final Value<double> amount;
  final Value<DateTime> date;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.residentId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int residentId,
    required double amount,
    required DateTime date,
  })  : residentId = Value(residentId),
        amount = Value(amount),
        date = Value(date);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? residentId,
    Expression<double>? amount,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (residentId != null) 'resident_id': residentId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
    });
  }

  PaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? residentId,
      Value<double>? amount,
      Value<DateTime>? date}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      residentId: residentId ?? this.residentId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (residentId.present) {
      map['resident_id'] = Variable<int>(residentId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('residentId: $residentId, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $ProvidersTable extends Providers
    with TableInfo<$ProvidersTable, Provider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jobTypeMeta =
      const VerificationMeta('jobType');
  @override
  late final GeneratedColumn<String> jobType = GeneratedColumn<String>(
      'job_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, jobType, phone];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'providers';
  @override
  VerificationContext validateIntegrity(Insertable<Provider> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('job_type')) {
      context.handle(_jobTypeMeta,
          jobType.isAcceptableOrUnknown(data['job_type']!, _jobTypeMeta));
    } else if (isInserting) {
      context.missing(_jobTypeMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Provider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Provider(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      jobType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_type'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
    );
  }

  @override
  $ProvidersTable createAlias(String alias) {
    return $ProvidersTable(attachedDatabase, alias);
  }
}

class Provider extends DataClass implements Insertable<Provider> {
  final int id;
  final String name;
  final String jobType;
  final String phone;
  const Provider(
      {required this.id,
      required this.name,
      required this.jobType,
      required this.phone});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['job_type'] = Variable<String>(jobType);
    map['phone'] = Variable<String>(phone);
    return map;
  }

  ProvidersCompanion toCompanion(bool nullToAbsent) {
    return ProvidersCompanion(
      id: Value(id),
      name: Value(name),
      jobType: Value(jobType),
      phone: Value(phone),
    );
  }

  factory Provider.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Provider(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      jobType: serializer.fromJson<String>(json['jobType']),
      phone: serializer.fromJson<String>(json['phone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'jobType': serializer.toJson<String>(jobType),
      'phone': serializer.toJson<String>(phone),
    };
  }

  Provider copyWith({int? id, String? name, String? jobType, String? phone}) =>
      Provider(
        id: id ?? this.id,
        name: name ?? this.name,
        jobType: jobType ?? this.jobType,
        phone: phone ?? this.phone,
      );
  Provider copyWithCompanion(ProvidersCompanion data) {
    return Provider(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      jobType: data.jobType.present ? data.jobType.value : this.jobType,
      phone: data.phone.present ? data.phone.value : this.phone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Provider(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobType: $jobType, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, jobType, phone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Provider &&
          other.id == this.id &&
          other.name == this.name &&
          other.jobType == this.jobType &&
          other.phone == this.phone);
}

class ProvidersCompanion extends UpdateCompanion<Provider> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> jobType;
  final Value<String> phone;
  const ProvidersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.jobType = const Value.absent(),
    this.phone = const Value.absent(),
  });
  ProvidersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String jobType,
    required String phone,
  })  : name = Value(name),
        jobType = Value(jobType),
        phone = Value(phone);
  static Insertable<Provider> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? jobType,
    Expression<String>? phone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (jobType != null) 'job_type': jobType,
      if (phone != null) 'phone': phone,
    });
  }

  ProvidersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? jobType,
      Value<String>? phone}) {
    return ProvidersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      jobType: jobType ?? this.jobType,
      phone: phone ?? this.phone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (jobType.present) {
      map['job_type'] = Variable<String>(jobType.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProvidersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobType: $jobType, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Autre'));
  static const VerificationMeta _proofImagePathMeta =
      const VerificationMeta('proofImagePath');
  @override
  late final GeneratedColumn<String> proofImagePath = GeneratedColumn<String>(
      'proof_image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _providerNameMeta =
      const VerificationMeta('providerName');
  @override
  late final GeneratedColumn<String> providerName = GeneratedColumn<String>(
      'provider_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _providerIdMeta =
      const VerificationMeta('providerId');
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
      'provider_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES providers (id) ON DELETE SET NULL'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        amount,
        category,
        proofImagePath,
        date,
        providerName,
        providerId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('proof_image_path')) {
      context.handle(
          _proofImagePathMeta,
          proofImagePath.isAcceptableOrUnknown(
              data['proof_image_path']!, _proofImagePathMeta));
    } else if (isInserting) {
      context.missing(_proofImagePathMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('provider_name')) {
      context.handle(
          _providerNameMeta,
          providerName.isAcceptableOrUnknown(
              data['provider_name']!, _providerNameMeta));
    }
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id']!, _providerIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      proofImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}proof_image_path'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      providerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_name']),
      providerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}provider_id']),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final String title;
  final double amount;
  final String category;
  final String proofImagePath;
  final DateTime date;
  final String? providerName;
  final int? providerId;
  const Expense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.category,
      required this.proofImagePath,
      required this.date,
      this.providerName,
      this.providerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    map['proof_image_path'] = Variable<String>(proofImagePath);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || providerName != null) {
      map['provider_name'] = Variable<String>(providerName);
    }
    if (!nullToAbsent || providerId != null) {
      map['provider_id'] = Variable<int>(providerId);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      category: Value(category),
      proofImagePath: Value(proofImagePath),
      date: Value(date),
      providerName: providerName == null && nullToAbsent
          ? const Value.absent()
          : Value(providerName),
      providerId: providerId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerId),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      proofImagePath: serializer.fromJson<String>(json['proofImagePath']),
      date: serializer.fromJson<DateTime>(json['date']),
      providerName: serializer.fromJson<String?>(json['providerName']),
      providerId: serializer.fromJson<int?>(json['providerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'proofImagePath': serializer.toJson<String>(proofImagePath),
      'date': serializer.toJson<DateTime>(date),
      'providerName': serializer.toJson<String?>(providerName),
      'providerId': serializer.toJson<int?>(providerId),
    };
  }

  Expense copyWith(
          {int? id,
          String? title,
          double? amount,
          String? category,
          String? proofImagePath,
          DateTime? date,
          Value<String?> providerName = const Value.absent(),
          Value<int?> providerId = const Value.absent()}) =>
      Expense(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        proofImagePath: proofImagePath ?? this.proofImagePath,
        date: date ?? this.date,
        providerName:
            providerName.present ? providerName.value : this.providerName,
        providerId: providerId.present ? providerId.value : this.providerId,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      proofImagePath: data.proofImagePath.present
          ? data.proofImagePath.value
          : this.proofImagePath,
      date: data.date.present ? data.date.value : this.date,
      providerName: data.providerName.present
          ? data.providerName.value
          : this.providerName,
      providerId:
          data.providerId.present ? data.providerId.value : this.providerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('proofImagePath: $proofImagePath, ')
          ..write('date: $date, ')
          ..write('providerName: $providerName, ')
          ..write('providerId: $providerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, amount, category, proofImagePath,
      date, providerName, providerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.proofImagePath == this.proofImagePath &&
          other.date == this.date &&
          other.providerName == this.providerName &&
          other.providerId == this.providerId);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> category;
  final Value<String> proofImagePath;
  final Value<DateTime> date;
  final Value<String?> providerName;
  final Value<int?> providerId;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.proofImagePath = const Value.absent(),
    this.date = const Value.absent(),
    this.providerName = const Value.absent(),
    this.providerId = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required double amount,
    this.category = const Value.absent(),
    required String proofImagePath,
    required DateTime date,
    this.providerName = const Value.absent(),
    this.providerId = const Value.absent(),
  })  : title = Value(title),
        amount = Value(amount),
        proofImagePath = Value(proofImagePath),
        date = Value(date);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? proofImagePath,
    Expression<DateTime>? date,
    Expression<String>? providerName,
    Expression<int>? providerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (proofImagePath != null) 'proof_image_path': proofImagePath,
      if (date != null) 'date': date,
      if (providerName != null) 'provider_name': providerName,
      if (providerId != null) 'provider_id': providerId,
    });
  }

  ExpensesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<double>? amount,
      Value<String>? category,
      Value<String>? proofImagePath,
      Value<DateTime>? date,
      Value<String?>? providerName,
      Value<int?>? providerId}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      proofImagePath: proofImagePath ?? this.proofImagePath,
      date: date ?? this.date,
      providerName: providerName ?? this.providerName,
      providerId: providerId ?? this.providerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (proofImagePath.present) {
      map['proof_image_path'] = Variable<String>(proofImagePath.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (providerName.present) {
      map['provider_name'] = Variable<String>(providerName.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('proofImagePath: $proofImagePath, ')
          ..write('date: $date, ')
          ..write('providerName: $providerName, ')
          ..write('providerId: $providerId')
          ..write(')'))
        .toString();
  }
}

class $AppConfigsTable extends AppConfigs
    with TableInfo<$AppConfigsTable, AppConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_configs';
  @override
  VerificationContext validateIntegrity(Insertable<AppConfig> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppConfig(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AppConfigsTable createAlias(String alias) {
    return $AppConfigsTable(attachedDatabase, alias);
  }
}

class AppConfig extends DataClass implements Insertable<AppConfig> {
  final String key;
  final String value;
  const AppConfig({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppConfigsCompanion toCompanion(bool nullToAbsent) {
    return AppConfigsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory AppConfig.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppConfig(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppConfig copyWith({String? key, String? value}) => AppConfig(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  AppConfig copyWithCompanion(AppConfigsCompanion data) {
    return AppConfig(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppConfig(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppConfig &&
          other.key == this.key &&
          other.value == this.value);
}

class AppConfigsCompanion extends UpdateCompanion<AppConfig> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppConfigsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppConfigsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<AppConfig> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppConfigsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return AppConfigsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppConfigsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeetingsTable extends Meetings with TableInfo<$MeetingsTable, Meeting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _agendaMeta = const VerificationMeta('agenda');
  @override
  late final GeneratedColumn<String> agenda = GeneratedColumn<String>(
      'agenda', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, date, location, agenda, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meetings';
  @override
  VerificationContext validateIntegrity(Insertable<Meeting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('agenda')) {
      context.handle(_agendaMeta,
          agenda.isAcceptableOrUnknown(data['agenda']!, _agendaMeta));
    } else if (isInserting) {
      context.missing(_agendaMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meeting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meeting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      agenda: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agenda'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $MeetingsTable createAlias(String alias) {
    return $MeetingsTable(attachedDatabase, alias);
  }
}

class Meeting extends DataClass implements Insertable<Meeting> {
  final int id;
  final DateTime date;
  final String location;
  final String agenda;
  final int status;
  const Meeting(
      {required this.id,
      required this.date,
      required this.location,
      required this.agenda,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['location'] = Variable<String>(location);
    map['agenda'] = Variable<String>(agenda);
    map['status'] = Variable<int>(status);
    return map;
  }

  MeetingsCompanion toCompanion(bool nullToAbsent) {
    return MeetingsCompanion(
      id: Value(id),
      date: Value(date),
      location: Value(location),
      agenda: Value(agenda),
      status: Value(status),
    );
  }

  factory Meeting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meeting(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      location: serializer.fromJson<String>(json['location']),
      agenda: serializer.fromJson<String>(json['agenda']),
      status: serializer.fromJson<int>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'location': serializer.toJson<String>(location),
      'agenda': serializer.toJson<String>(agenda),
      'status': serializer.toJson<int>(status),
    };
  }

  Meeting copyWith(
          {int? id,
          DateTime? date,
          String? location,
          String? agenda,
          int? status}) =>
      Meeting(
        id: id ?? this.id,
        date: date ?? this.date,
        location: location ?? this.location,
        agenda: agenda ?? this.agenda,
        status: status ?? this.status,
      );
  Meeting copyWithCompanion(MeetingsCompanion data) {
    return Meeting(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      location: data.location.present ? data.location.value : this.location,
      agenda: data.agenda.present ? data.agenda.value : this.agenda,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meeting(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('location: $location, ')
          ..write('agenda: $agenda, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, location, agenda, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meeting &&
          other.id == this.id &&
          other.date == this.date &&
          other.location == this.location &&
          other.agenda == this.agenda &&
          other.status == this.status);
}

class MeetingsCompanion extends UpdateCompanion<Meeting> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> location;
  final Value<String> agenda;
  final Value<int> status;
  const MeetingsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.location = const Value.absent(),
    this.agenda = const Value.absent(),
    this.status = const Value.absent(),
  });
  MeetingsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String location,
    required String agenda,
    this.status = const Value.absent(),
  })  : date = Value(date),
        location = Value(location),
        agenda = Value(agenda);
  static Insertable<Meeting> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? location,
    Expression<String>? agenda,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (location != null) 'location': location,
      if (agenda != null) 'agenda': agenda,
      if (status != null) 'status': status,
    });
  }

  MeetingsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? location,
      Value<String>? agenda,
      Value<int>? status}) {
    return MeetingsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      location: location ?? this.location,
      agenda: agenda ?? this.agenda,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (agenda.present) {
      map['agenda'] = Variable<String>(agenda.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('location: $location, ')
          ..write('agenda: $agenda, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $MeetingAttendanceTable extends MeetingAttendance
    with TableInfo<$MeetingAttendanceTable, MeetingAttendanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingAttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _meetingIdMeta =
      const VerificationMeta('meetingId');
  @override
  late final GeneratedColumn<int> meetingId = GeneratedColumn<int>(
      'meeting_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES meetings (id) ON DELETE CASCADE'));
  static const VerificationMeta _residentIdMeta =
      const VerificationMeta('residentId');
  @override
  late final GeneratedColumn<int> residentId = GeneratedColumn<int>(
      'resident_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES residents (id) ON DELETE CASCADE'));
  static const VerificationMeta _isPresentMeta =
      const VerificationMeta('isPresent');
  @override
  late final GeneratedColumn<bool> isPresent = GeneratedColumn<bool>(
      'is_present', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_present" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [meetingId, residentId, isPresent];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meeting_attendance';
  @override
  VerificationContext validateIntegrity(
      Insertable<MeetingAttendanceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('meeting_id')) {
      context.handle(_meetingIdMeta,
          meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta));
    } else if (isInserting) {
      context.missing(_meetingIdMeta);
    }
    if (data.containsKey('resident_id')) {
      context.handle(
          _residentIdMeta,
          residentId.isAcceptableOrUnknown(
              data['resident_id']!, _residentIdMeta));
    } else if (isInserting) {
      context.missing(_residentIdMeta);
    }
    if (data.containsKey('is_present')) {
      context.handle(_isPresentMeta,
          isPresent.isAcceptableOrUnknown(data['is_present']!, _isPresentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {meetingId, residentId};
  @override
  MeetingAttendanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetingAttendanceData(
      meetingId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meeting_id'])!,
      residentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}resident_id'])!,
      isPresent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_present'])!,
    );
  }

  @override
  $MeetingAttendanceTable createAlias(String alias) {
    return $MeetingAttendanceTable(attachedDatabase, alias);
  }
}

class MeetingAttendanceData extends DataClass
    implements Insertable<MeetingAttendanceData> {
  final int meetingId;
  final int residentId;
  final bool isPresent;
  const MeetingAttendanceData(
      {required this.meetingId,
      required this.residentId,
      required this.isPresent});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['meeting_id'] = Variable<int>(meetingId);
    map['resident_id'] = Variable<int>(residentId);
    map['is_present'] = Variable<bool>(isPresent);
    return map;
  }

  MeetingAttendanceCompanion toCompanion(bool nullToAbsent) {
    return MeetingAttendanceCompanion(
      meetingId: Value(meetingId),
      residentId: Value(residentId),
      isPresent: Value(isPresent),
    );
  }

  factory MeetingAttendanceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetingAttendanceData(
      meetingId: serializer.fromJson<int>(json['meetingId']),
      residentId: serializer.fromJson<int>(json['residentId']),
      isPresent: serializer.fromJson<bool>(json['isPresent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'meetingId': serializer.toJson<int>(meetingId),
      'residentId': serializer.toJson<int>(residentId),
      'isPresent': serializer.toJson<bool>(isPresent),
    };
  }

  MeetingAttendanceData copyWith(
          {int? meetingId, int? residentId, bool? isPresent}) =>
      MeetingAttendanceData(
        meetingId: meetingId ?? this.meetingId,
        residentId: residentId ?? this.residentId,
        isPresent: isPresent ?? this.isPresent,
      );
  MeetingAttendanceData copyWithCompanion(MeetingAttendanceCompanion data) {
    return MeetingAttendanceData(
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      residentId:
          data.residentId.present ? data.residentId.value : this.residentId,
      isPresent: data.isPresent.present ? data.isPresent.value : this.isPresent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetingAttendanceData(')
          ..write('meetingId: $meetingId, ')
          ..write('residentId: $residentId, ')
          ..write('isPresent: $isPresent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(meetingId, residentId, isPresent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetingAttendanceData &&
          other.meetingId == this.meetingId &&
          other.residentId == this.residentId &&
          other.isPresent == this.isPresent);
}

class MeetingAttendanceCompanion
    extends UpdateCompanion<MeetingAttendanceData> {
  final Value<int> meetingId;
  final Value<int> residentId;
  final Value<bool> isPresent;
  final Value<int> rowid;
  const MeetingAttendanceCompanion({
    this.meetingId = const Value.absent(),
    this.residentId = const Value.absent(),
    this.isPresent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeetingAttendanceCompanion.insert({
    required int meetingId,
    required int residentId,
    this.isPresent = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : meetingId = Value(meetingId),
        residentId = Value(residentId);
  static Insertable<MeetingAttendanceData> custom({
    Expression<int>? meetingId,
    Expression<int>? residentId,
    Expression<bool>? isPresent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (meetingId != null) 'meeting_id': meetingId,
      if (residentId != null) 'resident_id': residentId,
      if (isPresent != null) 'is_present': isPresent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeetingAttendanceCompanion copyWith(
      {Value<int>? meetingId,
      Value<int>? residentId,
      Value<bool>? isPresent,
      Value<int>? rowid}) {
    return MeetingAttendanceCompanion(
      meetingId: meetingId ?? this.meetingId,
      residentId: residentId ?? this.residentId,
      isPresent: isPresent ?? this.isPresent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (meetingId.present) {
      map['meeting_id'] = Variable<int>(meetingId.value);
    }
    if (residentId.present) {
      map['resident_id'] = Variable<int>(residentId.value);
    }
    if (isPresent.present) {
      map['is_present'] = Variable<bool>(isPresent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingAttendanceCompanion(')
          ..write('meetingId: $meetingId, ')
          ..write('residentId: $residentId, ')
          ..write('isPresent: $isPresent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncidentsTable extends Incidents
    with TableInfo<$IncidentsTable, Incident> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncidentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _assignedProviderIdMeta =
      const VerificationMeta('assignedProviderId');
  @override
  late final GeneratedColumn<int> assignedProviderId = GeneratedColumn<int>(
      'assigned_provider_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES providers (id) ON DELETE SET NULL'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, isDone, date, assignedProviderId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incidents';
  @override
  VerificationContext validateIntegrity(Insertable<Incident> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('assigned_provider_id')) {
      context.handle(
          _assignedProviderIdMeta,
          assignedProviderId.isAcceptableOrUnknown(
              data['assigned_provider_id']!, _assignedProviderIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Incident map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Incident(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      assignedProviderId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}assigned_provider_id']),
    );
  }

  @override
  $IncidentsTable createAlias(String alias) {
    return $IncidentsTable(attachedDatabase, alias);
  }
}

class Incident extends DataClass implements Insertable<Incident> {
  final int id;
  final String title;
  final String? description;
  final bool isDone;
  final DateTime date;
  final int? assignedProviderId;
  const Incident(
      {required this.id,
      required this.title,
      this.description,
      required this.isDone,
      required this.date,
      this.assignedProviderId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_done'] = Variable<bool>(isDone);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || assignedProviderId != null) {
      map['assigned_provider_id'] = Variable<int>(assignedProviderId);
    }
    return map;
  }

  IncidentsCompanion toCompanion(bool nullToAbsent) {
    return IncidentsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isDone: Value(isDone),
      date: Value(date),
      assignedProviderId: assignedProviderId == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedProviderId),
    );
  }

  factory Incident.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Incident(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      date: serializer.fromJson<DateTime>(json['date']),
      assignedProviderId: serializer.fromJson<int?>(json['assignedProviderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'isDone': serializer.toJson<bool>(isDone),
      'date': serializer.toJson<DateTime>(date),
      'assignedProviderId': serializer.toJson<int?>(assignedProviderId),
    };
  }

  Incident copyWith(
          {int? id,
          String? title,
          Value<String?> description = const Value.absent(),
          bool? isDone,
          DateTime? date,
          Value<int?> assignedProviderId = const Value.absent()}) =>
      Incident(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        isDone: isDone ?? this.isDone,
        date: date ?? this.date,
        assignedProviderId: assignedProviderId.present
            ? assignedProviderId.value
            : this.assignedProviderId,
      );
  Incident copyWithCompanion(IncidentsCompanion data) {
    return Incident(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      date: data.date.present ? data.date.value : this.date,
      assignedProviderId: data.assignedProviderId.present
          ? data.assignedProviderId.value
          : this.assignedProviderId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Incident(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isDone: $isDone, ')
          ..write('date: $date, ')
          ..write('assignedProviderId: $assignedProviderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, isDone, date, assignedProviderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Incident &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.isDone == this.isDone &&
          other.date == this.date &&
          other.assignedProviderId == this.assignedProviderId);
}

class IncidentsCompanion extends UpdateCompanion<Incident> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<bool> isDone;
  final Value<DateTime> date;
  final Value<int?> assignedProviderId;
  const IncidentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.isDone = const Value.absent(),
    this.date = const Value.absent(),
    this.assignedProviderId = const Value.absent(),
  });
  IncidentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.isDone = const Value.absent(),
    required DateTime date,
    this.assignedProviderId = const Value.absent(),
  })  : title = Value(title),
        date = Value(date);
  static Insertable<Incident> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? isDone,
    Expression<DateTime>? date,
    Expression<int>? assignedProviderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (isDone != null) 'is_done': isDone,
      if (date != null) 'date': date,
      if (assignedProviderId != null)
        'assigned_provider_id': assignedProviderId,
    });
  }

  IncidentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<bool>? isDone,
      Value<DateTime>? date,
      Value<int?>? assignedProviderId}) {
    return IncidentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
      assignedProviderId: assignedProviderId ?? this.assignedProviderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (assignedProviderId.present) {
      map['assigned_provider_id'] = Variable<int>(assignedProviderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncidentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isDone: $isDone, ')
          ..write('date: $date, ')
          ..write('assignedProviderId: $assignedProviderId')
          ..write(')'))
        .toString();
  }
}

class $LotsTable extends Lots with TableInfo<$LotsTable, Lot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _residentIdMeta =
      const VerificationMeta('residentId');
  @override
  late final GeneratedColumn<int> residentId = GeneratedColumn<int>(
      'resident_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES residents (id) ON DELETE CASCADE'));
  static const VerificationMeta _tantiemesMeta =
      const VerificationMeta('tantiemes');
  @override
  late final GeneratedColumn<int> tantiemes = GeneratedColumn<int>(
      'tantiemes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Appartement'));
  @override
  List<GeneratedColumn> get $columns => [id, residentId, tantiemes, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lots';
  @override
  VerificationContext validateIntegrity(Insertable<Lot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('resident_id')) {
      context.handle(
          _residentIdMeta,
          residentId.isAcceptableOrUnknown(
              data['resident_id']!, _residentIdMeta));
    } else if (isInserting) {
      context.missing(_residentIdMeta);
    }
    if (data.containsKey('tantiemes')) {
      context.handle(_tantiemesMeta,
          tantiemes.isAcceptableOrUnknown(data['tantiemes']!, _tantiemesMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      residentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}resident_id'])!,
      tantiemes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tantiemes'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $LotsTable createAlias(String alias) {
    return $LotsTable(attachedDatabase, alias);
  }
}

class Lot extends DataClass implements Insertable<Lot> {
  final int id;
  final int residentId;
  final int tantiemes;
  final String type;
  const Lot(
      {required this.id,
      required this.residentId,
      required this.tantiemes,
      required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['resident_id'] = Variable<int>(residentId);
    map['tantiemes'] = Variable<int>(tantiemes);
    map['type'] = Variable<String>(type);
    return map;
  }

  LotsCompanion toCompanion(bool nullToAbsent) {
    return LotsCompanion(
      id: Value(id),
      residentId: Value(residentId),
      tantiemes: Value(tantiemes),
      type: Value(type),
    );
  }

  factory Lot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lot(
      id: serializer.fromJson<int>(json['id']),
      residentId: serializer.fromJson<int>(json['residentId']),
      tantiemes: serializer.fromJson<int>(json['tantiemes']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'residentId': serializer.toJson<int>(residentId),
      'tantiemes': serializer.toJson<int>(tantiemes),
      'type': serializer.toJson<String>(type),
    };
  }

  Lot copyWith({int? id, int? residentId, int? tantiemes, String? type}) => Lot(
        id: id ?? this.id,
        residentId: residentId ?? this.residentId,
        tantiemes: tantiemes ?? this.tantiemes,
        type: type ?? this.type,
      );
  Lot copyWithCompanion(LotsCompanion data) {
    return Lot(
      id: data.id.present ? data.id.value : this.id,
      residentId:
          data.residentId.present ? data.residentId.value : this.residentId,
      tantiemes: data.tantiemes.present ? data.tantiemes.value : this.tantiemes,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lot(')
          ..write('id: $id, ')
          ..write('residentId: $residentId, ')
          ..write('tantiemes: $tantiemes, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, residentId, tantiemes, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lot &&
          other.id == this.id &&
          other.residentId == this.residentId &&
          other.tantiemes == this.tantiemes &&
          other.type == this.type);
}

class LotsCompanion extends UpdateCompanion<Lot> {
  final Value<int> id;
  final Value<int> residentId;
  final Value<int> tantiemes;
  final Value<String> type;
  const LotsCompanion({
    this.id = const Value.absent(),
    this.residentId = const Value.absent(),
    this.tantiemes = const Value.absent(),
    this.type = const Value.absent(),
  });
  LotsCompanion.insert({
    this.id = const Value.absent(),
    required int residentId,
    this.tantiemes = const Value.absent(),
    this.type = const Value.absent(),
  }) : residentId = Value(residentId);
  static Insertable<Lot> custom({
    Expression<int>? id,
    Expression<int>? residentId,
    Expression<int>? tantiemes,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (residentId != null) 'resident_id': residentId,
      if (tantiemes != null) 'tantiemes': tantiemes,
      if (type != null) 'type': type,
    });
  }

  LotsCompanion copyWith(
      {Value<int>? id,
      Value<int>? residentId,
      Value<int>? tantiemes,
      Value<String>? type}) {
    return LotsCompanion(
      id: id ?? this.id,
      residentId: residentId ?? this.residentId,
      tantiemes: tantiemes ?? this.tantiemes,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (residentId.present) {
      map['resident_id'] = Variable<int>(residentId.value);
    }
    if (tantiemes.present) {
      map['tantiemes'] = Variable<int>(tantiemes.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotsCompanion(')
          ..write('id: $id, ')
          ..write('residentId: $residentId, ')
          ..write('tantiemes: $tantiemes, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _classCodeMeta =
      const VerificationMeta('classCode');
  @override
  late final GeneratedColumn<int> classCode = GeneratedColumn<int>(
      'class_code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _balanceCentsMeta =
      const VerificationMeta('balanceCents');
  @override
  late final GeneratedColumn<int> balanceCents = GeneratedColumn<int>(
      'balance_cents', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, classCode, name, balanceCents];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_code')) {
      context.handle(_classCodeMeta,
          classCode.isAcceptableOrUnknown(data['class_code']!, _classCodeMeta));
    } else if (isInserting) {
      context.missing(_classCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('balance_cents')) {
      context.handle(
          _balanceCentsMeta,
          balanceCents.isAcceptableOrUnknown(
              data['balance_cents']!, _balanceCentsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      classCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}class_code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      balanceCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}balance_cents'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final int classCode;
  final String name;
  final int balanceCents;
  const Account(
      {required this.id,
      required this.classCode,
      required this.name,
      required this.balanceCents});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['class_code'] = Variable<int>(classCode);
    map['name'] = Variable<String>(name);
    map['balance_cents'] = Variable<int>(balanceCents);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      classCode: Value(classCode),
      name: Value(name),
      balanceCents: Value(balanceCents),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      classCode: serializer.fromJson<int>(json['classCode']),
      name: serializer.fromJson<String>(json['name']),
      balanceCents: serializer.fromJson<int>(json['balanceCents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classCode': serializer.toJson<int>(classCode),
      'name': serializer.toJson<String>(name),
      'balanceCents': serializer.toJson<int>(balanceCents),
    };
  }

  Account copyWith(
          {int? id, int? classCode, String? name, int? balanceCents}) =>
      Account(
        id: id ?? this.id,
        classCode: classCode ?? this.classCode,
        name: name ?? this.name,
        balanceCents: balanceCents ?? this.balanceCents,
      );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      classCode: data.classCode.present ? data.classCode.value : this.classCode,
      name: data.name.present ? data.name.value : this.name,
      balanceCents: data.balanceCents.present
          ? data.balanceCents.value
          : this.balanceCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('classCode: $classCode, ')
          ..write('name: $name, ')
          ..write('balanceCents: $balanceCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, classCode, name, balanceCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.classCode == this.classCode &&
          other.name == this.name &&
          other.balanceCents == this.balanceCents);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<int> classCode;
  final Value<String> name;
  final Value<int> balanceCents;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.classCode = const Value.absent(),
    this.name = const Value.absent(),
    this.balanceCents = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required int classCode,
    required String name,
    this.balanceCents = const Value.absent(),
  })  : classCode = Value(classCode),
        name = Value(name);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<int>? classCode,
    Expression<String>? name,
    Expression<int>? balanceCents,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classCode != null) 'class_code': classCode,
      if (name != null) 'name': name,
      if (balanceCents != null) 'balance_cents': balanceCents,
    });
  }

  AccountsCompanion copyWith(
      {Value<int>? id,
      Value<int>? classCode,
      Value<String>? name,
      Value<int>? balanceCents}) {
    return AccountsCompanion(
      id: id ?? this.id,
      classCode: classCode ?? this.classCode,
      name: name ?? this.name,
      balanceCents: balanceCents ?? this.balanceCents,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classCode.present) {
      map['class_code'] = Variable<int>(classCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (balanceCents.present) {
      map['balance_cents'] = Variable<int>(balanceCents.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('classCode: $classCode, ')
          ..write('name: $name, ')
          ..write('balanceCents: $balanceCents')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _debitAccountIdMeta =
      const VerificationMeta('debitAccountId');
  @override
  late final GeneratedColumn<int> debitAccountId = GeneratedColumn<int>(
      'debit_account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts (id)'));
  static const VerificationMeta _creditAccountIdMeta =
      const VerificationMeta('creditAccountId');
  @override
  late final GeneratedColumn<int> creditAccountId = GeneratedColumn<int>(
      'credit_account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts (id)'));
  static const VerificationMeta _amountCentsMeta =
      const VerificationMeta('amountCents');
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
      'amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _proofHashMeta =
      const VerificationMeta('proofHash');
  @override
  late final GeneratedColumn<String> proofHash = GeneratedColumn<String>(
      'proof_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        debitAccountId,
        creditAccountId,
        amountCents,
        date,
        description,
        proofHash
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('debit_account_id')) {
      context.handle(
          _debitAccountIdMeta,
          debitAccountId.isAcceptableOrUnknown(
              data['debit_account_id']!, _debitAccountIdMeta));
    } else if (isInserting) {
      context.missing(_debitAccountIdMeta);
    }
    if (data.containsKey('credit_account_id')) {
      context.handle(
          _creditAccountIdMeta,
          creditAccountId.isAcceptableOrUnknown(
              data['credit_account_id']!, _creditAccountIdMeta));
    } else if (isInserting) {
      context.missing(_creditAccountIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
          _amountCentsMeta,
          amountCents.isAcceptableOrUnknown(
              data['amount_cents']!, _amountCentsMeta));
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('proof_hash')) {
      context.handle(_proofHashMeta,
          proofHash.isAcceptableOrUnknown(data['proof_hash']!, _proofHashMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      debitAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}debit_account_id'])!,
      creditAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}credit_account_id'])!,
      amountCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_cents'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      proofHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}proof_hash']),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int debitAccountId;
  final int creditAccountId;
  final int amountCents;
  final DateTime date;
  final String description;
  final String? proofHash;
  const Transaction(
      {required this.id,
      required this.debitAccountId,
      required this.creditAccountId,
      required this.amountCents,
      required this.date,
      required this.description,
      this.proofHash});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['debit_account_id'] = Variable<int>(debitAccountId);
    map['credit_account_id'] = Variable<int>(creditAccountId);
    map['amount_cents'] = Variable<int>(amountCents);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || proofHash != null) {
      map['proof_hash'] = Variable<String>(proofHash);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      debitAccountId: Value(debitAccountId),
      creditAccountId: Value(creditAccountId),
      amountCents: Value(amountCents),
      date: Value(date),
      description: Value(description),
      proofHash: proofHash == null && nullToAbsent
          ? const Value.absent()
          : Value(proofHash),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      debitAccountId: serializer.fromJson<int>(json['debitAccountId']),
      creditAccountId: serializer.fromJson<int>(json['creditAccountId']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      proofHash: serializer.fromJson<String?>(json['proofHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'debitAccountId': serializer.toJson<int>(debitAccountId),
      'creditAccountId': serializer.toJson<int>(creditAccountId),
      'amountCents': serializer.toJson<int>(amountCents),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'proofHash': serializer.toJson<String?>(proofHash),
    };
  }

  Transaction copyWith(
          {int? id,
          int? debitAccountId,
          int? creditAccountId,
          int? amountCents,
          DateTime? date,
          String? description,
          Value<String?> proofHash = const Value.absent()}) =>
      Transaction(
        id: id ?? this.id,
        debitAccountId: debitAccountId ?? this.debitAccountId,
        creditAccountId: creditAccountId ?? this.creditAccountId,
        amountCents: amountCents ?? this.amountCents,
        date: date ?? this.date,
        description: description ?? this.description,
        proofHash: proofHash.present ? proofHash.value : this.proofHash,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      debitAccountId: data.debitAccountId.present
          ? data.debitAccountId.value
          : this.debitAccountId,
      creditAccountId: data.creditAccountId.present
          ? data.creditAccountId.value
          : this.creditAccountId,
      amountCents:
          data.amountCents.present ? data.amountCents.value : this.amountCents,
      date: data.date.present ? data.date.value : this.date,
      description:
          data.description.present ? data.description.value : this.description,
      proofHash: data.proofHash.present ? data.proofHash.value : this.proofHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('debitAccountId: $debitAccountId, ')
          ..write('creditAccountId: $creditAccountId, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('proofHash: $proofHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, debitAccountId, creditAccountId,
      amountCents, date, description, proofHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.debitAccountId == this.debitAccountId &&
          other.creditAccountId == this.creditAccountId &&
          other.amountCents == this.amountCents &&
          other.date == this.date &&
          other.description == this.description &&
          other.proofHash == this.proofHash);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> debitAccountId;
  final Value<int> creditAccountId;
  final Value<int> amountCents;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<String?> proofHash;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.debitAccountId = const Value.absent(),
    this.creditAccountId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.proofHash = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int debitAccountId,
    required int creditAccountId,
    required int amountCents,
    required DateTime date,
    required String description,
    this.proofHash = const Value.absent(),
  })  : debitAccountId = Value(debitAccountId),
        creditAccountId = Value(creditAccountId),
        amountCents = Value(amountCents),
        date = Value(date),
        description = Value(description);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? debitAccountId,
    Expression<int>? creditAccountId,
    Expression<int>? amountCents,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<String>? proofHash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (debitAccountId != null) 'debit_account_id': debitAccountId,
      if (creditAccountId != null) 'credit_account_id': creditAccountId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (proofHash != null) 'proof_hash': proofHash,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? debitAccountId,
      Value<int>? creditAccountId,
      Value<int>? amountCents,
      Value<DateTime>? date,
      Value<String>? description,
      Value<String?>? proofHash}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      debitAccountId: debitAccountId ?? this.debitAccountId,
      creditAccountId: creditAccountId ?? this.creditAccountId,
      amountCents: amountCents ?? this.amountCents,
      date: date ?? this.date,
      description: description ?? this.description,
      proofHash: proofHash ?? this.proofHash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (debitAccountId.present) {
      map['debit_account_id'] = Variable<int>(debitAccountId.value);
    }
    if (creditAccountId.present) {
      map['credit_account_id'] = Variable<int>(creditAccountId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (proofHash.present) {
      map['proof_hash'] = Variable<String>(proofHash.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('debitAccountId: $debitAccountId, ')
          ..write('creditAccountId: $creditAccountId, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('proofHash: $proofHash')
          ..write(')'))
        .toString();
  }
}

class $LegalDocsTable extends LegalDocs
    with TableInfo<$LegalDocsTable, LegalDoc> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LegalDocsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recipientNameMeta =
      const VerificationMeta('recipientName');
  @override
  late final GeneratedColumn<String> recipientName = GeneratedColumn<String>(
      'recipient_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentTextMeta =
      const VerificationMeta('contentText');
  @override
  late final GeneratedColumn<String> contentText = GeneratedColumn<String>(
      'content_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _generatedDateMeta =
      const VerificationMeta('generatedDate');
  @override
  late final GeneratedColumn<DateTime> generatedDate =
      GeneratedColumn<DateTime>('generated_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fileHashMeta =
      const VerificationMeta('fileHash');
  @override
  late final GeneratedColumn<String> fileHash = GeneratedColumn<String>(
      'file_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, recipientName, contentText, generatedDate, fileHash];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'legal_docs';
  @override
  VerificationContext validateIntegrity(Insertable<LegalDoc> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('recipient_name')) {
      context.handle(
          _recipientNameMeta,
          recipientName.isAcceptableOrUnknown(
              data['recipient_name']!, _recipientNameMeta));
    } else if (isInserting) {
      context.missing(_recipientNameMeta);
    }
    if (data.containsKey('content_text')) {
      context.handle(
          _contentTextMeta,
          contentText.isAcceptableOrUnknown(
              data['content_text']!, _contentTextMeta));
    } else if (isInserting) {
      context.missing(_contentTextMeta);
    }
    if (data.containsKey('generated_date')) {
      context.handle(
          _generatedDateMeta,
          generatedDate.isAcceptableOrUnknown(
              data['generated_date']!, _generatedDateMeta));
    } else if (isInserting) {
      context.missing(_generatedDateMeta);
    }
    if (data.containsKey('file_hash')) {
      context.handle(_fileHashMeta,
          fileHash.isAcceptableOrUnknown(data['file_hash']!, _fileHashMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LegalDoc map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LegalDoc(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      recipientName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recipient_name'])!,
      contentText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_text'])!,
      generatedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}generated_date'])!,
      fileHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_hash']),
    );
  }

  @override
  $LegalDocsTable createAlias(String alias) {
    return $LegalDocsTable(attachedDatabase, alias);
  }
}

class LegalDoc extends DataClass implements Insertable<LegalDoc> {
  final int id;
  final String type;
  final String recipientName;
  final String contentText;
  final DateTime generatedDate;
  final String? fileHash;
  const LegalDoc(
      {required this.id,
      required this.type,
      required this.recipientName,
      required this.contentText,
      required this.generatedDate,
      this.fileHash});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['recipient_name'] = Variable<String>(recipientName);
    map['content_text'] = Variable<String>(contentText);
    map['generated_date'] = Variable<DateTime>(generatedDate);
    if (!nullToAbsent || fileHash != null) {
      map['file_hash'] = Variable<String>(fileHash);
    }
    return map;
  }

  LegalDocsCompanion toCompanion(bool nullToAbsent) {
    return LegalDocsCompanion(
      id: Value(id),
      type: Value(type),
      recipientName: Value(recipientName),
      contentText: Value(contentText),
      generatedDate: Value(generatedDate),
      fileHash: fileHash == null && nullToAbsent
          ? const Value.absent()
          : Value(fileHash),
    );
  }

  factory LegalDoc.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LegalDoc(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      recipientName: serializer.fromJson<String>(json['recipientName']),
      contentText: serializer.fromJson<String>(json['contentText']),
      generatedDate: serializer.fromJson<DateTime>(json['generatedDate']),
      fileHash: serializer.fromJson<String?>(json['fileHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'recipientName': serializer.toJson<String>(recipientName),
      'contentText': serializer.toJson<String>(contentText),
      'generatedDate': serializer.toJson<DateTime>(generatedDate),
      'fileHash': serializer.toJson<String?>(fileHash),
    };
  }

  LegalDoc copyWith(
          {int? id,
          String? type,
          String? recipientName,
          String? contentText,
          DateTime? generatedDate,
          Value<String?> fileHash = const Value.absent()}) =>
      LegalDoc(
        id: id ?? this.id,
        type: type ?? this.type,
        recipientName: recipientName ?? this.recipientName,
        contentText: contentText ?? this.contentText,
        generatedDate: generatedDate ?? this.generatedDate,
        fileHash: fileHash.present ? fileHash.value : this.fileHash,
      );
  LegalDoc copyWithCompanion(LegalDocsCompanion data) {
    return LegalDoc(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      recipientName: data.recipientName.present
          ? data.recipientName.value
          : this.recipientName,
      contentText:
          data.contentText.present ? data.contentText.value : this.contentText,
      generatedDate: data.generatedDate.present
          ? data.generatedDate.value
          : this.generatedDate,
      fileHash: data.fileHash.present ? data.fileHash.value : this.fileHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LegalDoc(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('recipientName: $recipientName, ')
          ..write('contentText: $contentText, ')
          ..write('generatedDate: $generatedDate, ')
          ..write('fileHash: $fileHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, recipientName, contentText, generatedDate, fileHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LegalDoc &&
          other.id == this.id &&
          other.type == this.type &&
          other.recipientName == this.recipientName &&
          other.contentText == this.contentText &&
          other.generatedDate == this.generatedDate &&
          other.fileHash == this.fileHash);
}

class LegalDocsCompanion extends UpdateCompanion<LegalDoc> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> recipientName;
  final Value<String> contentText;
  final Value<DateTime> generatedDate;
  final Value<String?> fileHash;
  const LegalDocsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.recipientName = const Value.absent(),
    this.contentText = const Value.absent(),
    this.generatedDate = const Value.absent(),
    this.fileHash = const Value.absent(),
  });
  LegalDocsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String recipientName,
    required String contentText,
    required DateTime generatedDate,
    this.fileHash = const Value.absent(),
  })  : type = Value(type),
        recipientName = Value(recipientName),
        contentText = Value(contentText),
        generatedDate = Value(generatedDate);
  static Insertable<LegalDoc> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? recipientName,
    Expression<String>? contentText,
    Expression<DateTime>? generatedDate,
    Expression<String>? fileHash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (recipientName != null) 'recipient_name': recipientName,
      if (contentText != null) 'content_text': contentText,
      if (generatedDate != null) 'generated_date': generatedDate,
      if (fileHash != null) 'file_hash': fileHash,
    });
  }

  LegalDocsCompanion copyWith(
      {Value<int>? id,
      Value<String>? type,
      Value<String>? recipientName,
      Value<String>? contentText,
      Value<DateTime>? generatedDate,
      Value<String?>? fileHash}) {
    return LegalDocsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      recipientName: recipientName ?? this.recipientName,
      contentText: contentText ?? this.contentText,
      generatedDate: generatedDate ?? this.generatedDate,
      fileHash: fileHash ?? this.fileHash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (recipientName.present) {
      map['recipient_name'] = Variable<String>(recipientName.value);
    }
    if (contentText.present) {
      map['content_text'] = Variable<String>(contentText.value);
    }
    if (generatedDate.present) {
      map['generated_date'] = Variable<DateTime>(generatedDate.value);
    }
    if (fileHash.present) {
      map['file_hash'] = Variable<String>(fileHash.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LegalDocsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('recipientName: $recipientName, ')
          ..write('contentText: $contentText, ')
          ..write('generatedDate: $generatedDate, ')
          ..write('fileHash: $fileHash')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, title, dueDate, isDone, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final DateTime dueDate;
  final bool isDone;
  final int type;
  const Task(
      {required this.id,
      required this.title,
      required this.dueDate,
      required this.isDone,
      required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['is_done'] = Variable<bool>(isDone);
    map['type'] = Variable<int>(type);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      dueDate: Value(dueDate),
      isDone: Value(isDone),
      type: Value(type),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      type: serializer.fromJson<int>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'isDone': serializer.toJson<bool>(isDone),
      'type': serializer.toJson<int>(type),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          DateTime? dueDate,
          bool? isDone,
          int? type}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        dueDate: dueDate ?? this.dueDate,
        isDone: isDone ?? this.isDone,
        type: type ?? this.type,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isDone: $isDone, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, dueDate, isDone, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.dueDate == this.dueDate &&
          other.isDone == this.isDone &&
          other.type == this.type);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> dueDate;
  final Value<bool> isDone;
  final Value<int> type;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.type = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime dueDate,
    this.isDone = const Value.absent(),
    this.type = const Value.absent(),
  })  : title = Value(title),
        dueDate = Value(dueDate);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? dueDate,
    Expression<bool>? isDone,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dueDate != null) 'due_date': dueDate,
      if (isDone != null) 'is_done': isDone,
      if (type != null) 'type': type,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<DateTime>? dueDate,
      Value<bool>? isDone,
      Value<int>? type}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isDone: $isDone, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $ContractsTable extends Contracts
    with TableInfo<$ContractsTable, Contract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _employeeNameMeta =
      const VerificationMeta('employeeName');
  @override
  late final GeneratedColumn<String> employeeName = GeneratedColumn<String>(
      'employee_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _salaryMeta = const VerificationMeta('salary');
  @override
  late final GeneratedColumn<double> salary = GeneratedColumn<double>(
      'salary', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, employeeName, role, salary, startDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contracts';
  @override
  VerificationContext validateIntegrity(Insertable<Contract> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_name')) {
      context.handle(
          _employeeNameMeta,
          employeeName.isAcceptableOrUnknown(
              data['employee_name']!, _employeeNameMeta));
    } else if (isInserting) {
      context.missing(_employeeNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('salary')) {
      context.handle(_salaryMeta,
          salary.isAcceptableOrUnknown(data['salary']!, _salaryMeta));
    } else if (isInserting) {
      context.missing(_salaryMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contract(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      employeeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_name'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      salary: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}salary'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
    );
  }

  @override
  $ContractsTable createAlias(String alias) {
    return $ContractsTable(attachedDatabase, alias);
  }
}

class Contract extends DataClass implements Insertable<Contract> {
  final int id;
  final String employeeName;
  final String role;
  final double salary;
  final String startDate;
  const Contract(
      {required this.id,
      required this.employeeName,
      required this.role,
      required this.salary,
      required this.startDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employee_name'] = Variable<String>(employeeName);
    map['role'] = Variable<String>(role);
    map['salary'] = Variable<double>(salary);
    map['start_date'] = Variable<String>(startDate);
    return map;
  }

  ContractsCompanion toCompanion(bool nullToAbsent) {
    return ContractsCompanion(
      id: Value(id),
      employeeName: Value(employeeName),
      role: Value(role),
      salary: Value(salary),
      startDate: Value(startDate),
    );
  }

  factory Contract.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contract(
      id: serializer.fromJson<int>(json['id']),
      employeeName: serializer.fromJson<String>(json['employeeName']),
      role: serializer.fromJson<String>(json['role']),
      salary: serializer.fromJson<double>(json['salary']),
      startDate: serializer.fromJson<String>(json['startDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeName': serializer.toJson<String>(employeeName),
      'role': serializer.toJson<String>(role),
      'salary': serializer.toJson<double>(salary),
      'startDate': serializer.toJson<String>(startDate),
    };
  }

  Contract copyWith(
          {int? id,
          String? employeeName,
          String? role,
          double? salary,
          String? startDate}) =>
      Contract(
        id: id ?? this.id,
        employeeName: employeeName ?? this.employeeName,
        role: role ?? this.role,
        salary: salary ?? this.salary,
        startDate: startDate ?? this.startDate,
      );
  Contract copyWithCompanion(ContractsCompanion data) {
    return Contract(
      id: data.id.present ? data.id.value : this.id,
      employeeName: data.employeeName.present
          ? data.employeeName.value
          : this.employeeName,
      role: data.role.present ? data.role.value : this.role,
      salary: data.salary.present ? data.salary.value : this.salary,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contract(')
          ..write('id: $id, ')
          ..write('employeeName: $employeeName, ')
          ..write('role: $role, ')
          ..write('salary: $salary, ')
          ..write('startDate: $startDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, employeeName, role, salary, startDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contract &&
          other.id == this.id &&
          other.employeeName == this.employeeName &&
          other.role == this.role &&
          other.salary == this.salary &&
          other.startDate == this.startDate);
}

class ContractsCompanion extends UpdateCompanion<Contract> {
  final Value<int> id;
  final Value<String> employeeName;
  final Value<String> role;
  final Value<double> salary;
  final Value<String> startDate;
  const ContractsCompanion({
    this.id = const Value.absent(),
    this.employeeName = const Value.absent(),
    this.role = const Value.absent(),
    this.salary = const Value.absent(),
    this.startDate = const Value.absent(),
  });
  ContractsCompanion.insert({
    this.id = const Value.absent(),
    required String employeeName,
    required String role,
    required double salary,
    required String startDate,
  })  : employeeName = Value(employeeName),
        role = Value(role),
        salary = Value(salary),
        startDate = Value(startDate);
  static Insertable<Contract> custom({
    Expression<int>? id,
    Expression<String>? employeeName,
    Expression<String>? role,
    Expression<double>? salary,
    Expression<String>? startDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeName != null) 'employee_name': employeeName,
      if (role != null) 'role': role,
      if (salary != null) 'salary': salary,
      if (startDate != null) 'start_date': startDate,
    });
  }

  ContractsCompanion copyWith(
      {Value<int>? id,
      Value<String>? employeeName,
      Value<String>? role,
      Value<double>? salary,
      Value<String>? startDate}) {
    return ContractsCompanion(
      id: id ?? this.id,
      employeeName: employeeName ?? this.employeeName,
      role: role ?? this.role,
      salary: salary ?? this.salary,
      startDate: startDate ?? this.startDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeName.present) {
      map['employee_name'] = Variable<String>(employeeName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (salary.present) {
      map['salary'] = Variable<double>(salary.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractsCompanion(')
          ..write('id: $id, ')
          ..write('employeeName: $employeeName, ')
          ..write('role: $role, ')
          ..write('salary: $salary, ')
          ..write('startDate: $startDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ResidentsTable residents = $ResidentsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $ProvidersTable providers = $ProvidersTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $AppConfigsTable appConfigs = $AppConfigsTable(this);
  late final $MeetingsTable meetings = $MeetingsTable(this);
  late final $MeetingAttendanceTable meetingAttendance =
      $MeetingAttendanceTable(this);
  late final $IncidentsTable incidents = $IncidentsTable(this);
  late final $LotsTable lots = $LotsTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $LegalDocsTable legalDocs = $LegalDocsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $ContractsTable contracts = $ContractsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        residents,
        payments,
        providers,
        expenses,
        appConfigs,
        meetings,
        meetingAttendance,
        incidents,
        lots,
        accounts,
        transactions,
        legalDocs,
        tasks,
        contracts
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('providers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('expenses', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('meetings',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('meeting_attendance', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('residents',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('meeting_attendance', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('providers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('incidents', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('residents',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('lots', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ResidentsTableCreateCompanionBuilder = ResidentsCompanion Function({
  Value<int> id,
  required String name,
  Value<String> phone,
  Value<String> building,
  Value<String> apartment,
  Value<int?> floor,
  Value<int> monthlyFee,
  Value<DateTime> startDate,
  Value<String?> pinCode,
});
typedef $$ResidentsTableUpdateCompanionBuilder = ResidentsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> phone,
  Value<String> building,
  Value<String> apartment,
  Value<int?> floor,
  Value<int> monthlyFee,
  Value<DateTime> startDate,
  Value<String?> pinCode,
});

final class $$ResidentsTableReferences
    extends BaseReferences<_$AppDatabase, $ResidentsTable, Resident> {
  $$ResidentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.payments,
          aliasName:
              $_aliasNameGenerator(db.residents.id, db.payments.residentId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.residentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MeetingAttendanceTable,
      List<MeetingAttendanceData>> _meetingAttendanceRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.meetingAttendance,
          aliasName: $_aliasNameGenerator(
              db.residents.id, db.meetingAttendance.residentId));

  $$MeetingAttendanceTableProcessedTableManager get meetingAttendanceRefs {
    final manager =
        $$MeetingAttendanceTableTableManager($_db, $_db.meetingAttendance)
            .filter((f) => f.residentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_meetingAttendanceRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LotsTable, List<Lot>> _lotsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.lots,
          aliasName: $_aliasNameGenerator(db.residents.id, db.lots.residentId));

  $$LotsTableProcessedTableManager get lotsRefs {
    final manager = $$LotsTableTableManager($_db, $_db.lots)
        .filter((f) => f.residentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ResidentsTableFilterComposer
    extends Composer<_$AppDatabase, $ResidentsTable> {
  $$ResidentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get building => $composableBuilder(
      column: $table.building, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apartment => $composableBuilder(
      column: $table.apartment, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get floor => $composableBuilder(
      column: $table.floor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinCode => $composableBuilder(
      column: $table.pinCode, builder: (column) => ColumnFilters(column));

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.residentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> meetingAttendanceRefs(
      Expression<bool> Function($$MeetingAttendanceTableFilterComposer f) f) {
    final $$MeetingAttendanceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.meetingAttendance,
        getReferencedColumn: (t) => t.residentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MeetingAttendanceTableFilterComposer(
              $db: $db,
              $table: $db.meetingAttendance,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> lotsRefs(
      Expression<bool> Function($$LotsTableFilterComposer f) f) {
    final $$LotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lots,
        getReferencedColumn: (t) => t.residentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotsTableFilterComposer(
              $db: $db,
              $table: $db.lots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ResidentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ResidentsTable> {
  $$ResidentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get building => $composableBuilder(
      column: $table.building, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apartment => $composableBuilder(
      column: $table.apartment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get floor => $composableBuilder(
      column: $table.floor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinCode => $composableBuilder(
      column: $table.pinCode, builder: (column) => ColumnOrderings(column));
}

class $$ResidentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResidentsTable> {
  $$ResidentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get building =>
      $composableBuilder(column: $table.building, builder: (column) => column);

  GeneratedColumn<String> get apartment =>
      $composableBuilder(column: $table.apartment, builder: (column) => column);

  GeneratedColumn<int> get floor =>
      $composableBuilder(column: $table.floor, builder: (column) => column);

  GeneratedColumn<int> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get pinCode =>
      $composableBuilder(column: $table.pinCode, builder: (column) => column);

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.residentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> meetingAttendanceRefs<T extends Object>(
      Expression<T> Function($$MeetingAttendanceTableAnnotationComposer a) f) {
    final $$MeetingAttendanceTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.meetingAttendance,
            getReferencedColumn: (t) => t.residentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MeetingAttendanceTableAnnotationComposer(
                  $db: $db,
                  $table: $db.meetingAttendance,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> lotsRefs<T extends Object>(
      Expression<T> Function($$LotsTableAnnotationComposer a) f) {
    final $$LotsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lots,
        getReferencedColumn: (t) => t.residentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotsTableAnnotationComposer(
              $db: $db,
              $table: $db.lots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ResidentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ResidentsTable,
    Resident,
    $$ResidentsTableFilterComposer,
    $$ResidentsTableOrderingComposer,
    $$ResidentsTableAnnotationComposer,
    $$ResidentsTableCreateCompanionBuilder,
    $$ResidentsTableUpdateCompanionBuilder,
    (Resident, $$ResidentsTableReferences),
    Resident,
    PrefetchHooks Function(
        {bool paymentsRefs, bool meetingAttendanceRefs, bool lotsRefs})> {
  $$ResidentsTableTableManager(_$AppDatabase db, $ResidentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResidentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResidentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResidentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> building = const Value.absent(),
            Value<String> apartment = const Value.absent(),
            Value<int?> floor = const Value.absent(),
            Value<int> monthlyFee = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<String?> pinCode = const Value.absent(),
          }) =>
              ResidentsCompanion(
            id: id,
            name: name,
            phone: phone,
            building: building,
            apartment: apartment,
            floor: floor,
            monthlyFee: monthlyFee,
            startDate: startDate,
            pinCode: pinCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> phone = const Value.absent(),
            Value<String> building = const Value.absent(),
            Value<String> apartment = const Value.absent(),
            Value<int?> floor = const Value.absent(),
            Value<int> monthlyFee = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<String?> pinCode = const Value.absent(),
          }) =>
              ResidentsCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            building: building,
            apartment: apartment,
            floor: floor,
            monthlyFee: monthlyFee,
            startDate: startDate,
            pinCode: pinCode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ResidentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {paymentsRefs = false,
              meetingAttendanceRefs = false,
              lotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (paymentsRefs) db.payments,
                if (meetingAttendanceRefs) db.meetingAttendance,
                if (lotsRefs) db.lots
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentsRefs)
                    await $_getPrefetchedData<Resident, $ResidentsTable,
                            Payment>(
                        currentTable: table,
                        referencedTable:
                            $$ResidentsTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ResidentsTableReferences(db, table, p0)
                                .paymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.residentId == item.id),
                        typedResults: items),
                  if (meetingAttendanceRefs)
                    await $_getPrefetchedData<Resident, $ResidentsTable,
                            MeetingAttendanceData>(
                        currentTable: table,
                        referencedTable: $$ResidentsTableReferences
                            ._meetingAttendanceRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ResidentsTableReferences(db, table, p0)
                                .meetingAttendanceRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.residentId == item.id),
                        typedResults: items),
                  if (lotsRefs)
                    await $_getPrefetchedData<Resident, $ResidentsTable, Lot>(
                        currentTable: table,
                        referencedTable:
                            $$ResidentsTableReferences._lotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ResidentsTableReferences(db, table, p0).lotsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.residentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ResidentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ResidentsTable,
    Resident,
    $$ResidentsTableFilterComposer,
    $$ResidentsTableOrderingComposer,
    $$ResidentsTableAnnotationComposer,
    $$ResidentsTableCreateCompanionBuilder,
    $$ResidentsTableUpdateCompanionBuilder,
    (Resident, $$ResidentsTableReferences),
    Resident,
    PrefetchHooks Function(
        {bool paymentsRefs, bool meetingAttendanceRefs, bool lotsRefs})>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int residentId,
  required double amount,
  required DateTime date,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> residentId,
  Value<double> amount,
  Value<DateTime> date,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ResidentsTable _residentIdTable(_$AppDatabase db) =>
      db.residents.createAlias(
          $_aliasNameGenerator(db.payments.residentId, db.residents.id));

  $$ResidentsTableProcessedTableManager get residentId {
    final $_column = $_itemColumn<int>('resident_id')!;

    final manager = $$ResidentsTableTableManager($_db, $_db.residents)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_residentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  $$ResidentsTableFilterComposer get residentId {
    final $$ResidentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableFilterComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  $$ResidentsTableOrderingComposer get residentId {
    final $$ResidentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableOrderingComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$ResidentsTableAnnotationComposer get residentId {
    final $$ResidentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableAnnotationComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool residentId})> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> residentId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            residentId: residentId,
            amount: amount,
            date: date,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int residentId,
            required double amount,
            required DateTime date,
          }) =>
              PaymentsCompanion.insert(
            id: id,
            residentId: residentId,
            amount: amount,
            date: date,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PaymentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({residentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (residentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.residentId,
                    referencedTable:
                        $$PaymentsTableReferences._residentIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._residentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool residentId})>;
typedef $$ProvidersTableCreateCompanionBuilder = ProvidersCompanion Function({
  Value<int> id,
  required String name,
  required String jobType,
  required String phone,
});
typedef $$ProvidersTableUpdateCompanionBuilder = ProvidersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> jobType,
  Value<String> phone,
});

final class $$ProvidersTableReferences
    extends BaseReferences<_$AppDatabase, $ProvidersTable, Provider> {
  $$ProvidersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenses,
          aliasName:
              $_aliasNameGenerator(db.providers.id, db.expenses.providerId));

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager($_db, $_db.expenses)
        .filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IncidentsTable, List<Incident>>
      _incidentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.incidents,
              aliasName: $_aliasNameGenerator(
                  db.providers.id, db.incidents.assignedProviderId));

  $$IncidentsTableProcessedTableManager get incidentsRefs {
    final manager = $$IncidentsTableTableManager($_db, $_db.incidents).filter(
        (f) => f.assignedProviderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_incidentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $ProvidersTable> {
  $$ProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobType => $composableBuilder(
      column: $table.jobType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  Expression<bool> expensesRefs(
      Expression<bool> Function($$ExpensesTableFilterComposer f) f) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.providerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableFilterComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> incidentsRefs(
      Expression<bool> Function($$IncidentsTableFilterComposer f) f) {
    final $$IncidentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incidents,
        getReferencedColumn: (t) => t.assignedProviderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncidentsTableFilterComposer(
              $db: $db,
              $table: $db.incidents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $ProvidersTable> {
  $$ProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobType => $composableBuilder(
      column: $table.jobType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));
}

class $$ProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProvidersTable> {
  $$ProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get jobType =>
      $composableBuilder(column: $table.jobType, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  Expression<T> expensesRefs<T extends Object>(
      Expression<T> Function($$ExpensesTableAnnotationComposer a) f) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.providerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableAnnotationComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> incidentsRefs<T extends Object>(
      Expression<T> Function($$IncidentsTableAnnotationComposer a) f) {
    final $$IncidentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incidents,
        getReferencedColumn: (t) => t.assignedProviderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncidentsTableAnnotationComposer(
              $db: $db,
              $table: $db.incidents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProvidersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProvidersTable,
    Provider,
    $$ProvidersTableFilterComposer,
    $$ProvidersTableOrderingComposer,
    $$ProvidersTableAnnotationComposer,
    $$ProvidersTableCreateCompanionBuilder,
    $$ProvidersTableUpdateCompanionBuilder,
    (Provider, $$ProvidersTableReferences),
    Provider,
    PrefetchHooks Function({bool expensesRefs, bool incidentsRefs})> {
  $$ProvidersTableTableManager(_$AppDatabase db, $ProvidersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> jobType = const Value.absent(),
            Value<String> phone = const Value.absent(),
          }) =>
              ProvidersCompanion(
            id: id,
            name: name,
            jobType: jobType,
            phone: phone,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String jobType,
            required String phone,
          }) =>
              ProvidersCompanion.insert(
            id: id,
            name: name,
            jobType: jobType,
            phone: phone,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProvidersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {expensesRefs = false, incidentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (expensesRefs) db.expenses,
                if (incidentsRefs) db.incidents
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expensesRefs)
                    await $_getPrefetchedData<Provider, $ProvidersTable,
                            Expense>(
                        currentTable: table,
                        referencedTable:
                            $$ProvidersTableReferences._expensesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProvidersTableReferences(db, table, p0)
                                .expensesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.providerId == item.id),
                        typedResults: items),
                  if (incidentsRefs)
                    await $_getPrefetchedData<Provider, $ProvidersTable,
                            Incident>(
                        currentTable: table,
                        referencedTable:
                            $$ProvidersTableReferences._incidentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProvidersTableReferences(db, table, p0)
                                .incidentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.assignedProviderId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProvidersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProvidersTable,
    Provider,
    $$ProvidersTableFilterComposer,
    $$ProvidersTableOrderingComposer,
    $$ProvidersTableAnnotationComposer,
    $$ProvidersTableCreateCompanionBuilder,
    $$ProvidersTableUpdateCompanionBuilder,
    (Provider, $$ProvidersTableReferences),
    Provider,
    PrefetchHooks Function({bool expensesRefs, bool incidentsRefs})>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required String title,
  required double amount,
  Value<String> category,
  required String proofImagePath,
  required DateTime date,
  Value<String?> providerName,
  Value<int?> providerId,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<double> amount,
  Value<String> category,
  Value<String> proofImagePath,
  Value<DateTime> date,
  Value<String?> providerName,
  Value<int?> providerId,
});

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProvidersTable _providerIdTable(_$AppDatabase db) =>
      db.providers.createAlias(
          $_aliasNameGenerator(db.expenses.providerId, db.providers.id));

  $$ProvidersTableProcessedTableManager? get providerId {
    final $_column = $_itemColumn<int>('provider_id');
    if ($_column == null) return null;
    final manager = $$ProvidersTableTableManager($_db, $_db.providers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get proofImagePath => $composableBuilder(
      column: $table.proofImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get providerName => $composableBuilder(
      column: $table.providerName, builder: (column) => ColumnFilters(column));

  $$ProvidersTableFilterComposer get providerId {
    final $$ProvidersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.providerId,
        referencedTable: $db.providers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProvidersTableFilterComposer(
              $db: $db,
              $table: $db.providers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get proofImagePath => $composableBuilder(
      column: $table.proofImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get providerName => $composableBuilder(
      column: $table.providerName,
      builder: (column) => ColumnOrderings(column));

  $$ProvidersTableOrderingComposer get providerId {
    final $$ProvidersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.providerId,
        referencedTable: $db.providers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProvidersTableOrderingComposer(
              $db: $db,
              $table: $db.providers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get proofImagePath => $composableBuilder(
      column: $table.proofImagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get providerName => $composableBuilder(
      column: $table.providerName, builder: (column) => column);

  $$ProvidersTableAnnotationComposer get providerId {
    final $$ProvidersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.providerId,
        referencedTable: $db.providers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProvidersTableAnnotationComposer(
              $db: $db,
              $table: $db.providers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool providerId})> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> proofImagePath = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> providerName = const Value.absent(),
            Value<int?> providerId = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            title: title,
            amount: amount,
            category: category,
            proofImagePath: proofImagePath,
            date: date,
            providerName: providerName,
            providerId: providerId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required double amount,
            Value<String> category = const Value.absent(),
            required String proofImagePath,
            required DateTime date,
            Value<String?> providerName = const Value.absent(),
            Value<int?> providerId = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            title: title,
            amount: amount,
            category: category,
            proofImagePath: proofImagePath,
            date: date,
            providerName: providerName,
            providerId: providerId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ExpensesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (providerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.providerId,
                    referencedTable:
                        $$ExpensesTableReferences._providerIdTable(db),
                    referencedColumn:
                        $$ExpensesTableReferences._providerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool providerId})>;
typedef $$AppConfigsTableCreateCompanionBuilder = AppConfigsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppConfigsTableUpdateCompanionBuilder = AppConfigsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $AppConfigsTable> {
  $$AppConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$AppConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppConfigsTable> {
  $$AppConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$AppConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppConfigsTable> {
  $$AppConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppConfigsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppConfigsTable,
    AppConfig,
    $$AppConfigsTableFilterComposer,
    $$AppConfigsTableOrderingComposer,
    $$AppConfigsTableAnnotationComposer,
    $$AppConfigsTableCreateCompanionBuilder,
    $$AppConfigsTableUpdateCompanionBuilder,
    (AppConfig, BaseReferences<_$AppDatabase, $AppConfigsTable, AppConfig>),
    AppConfig,
    PrefetchHooks Function()> {
  $$AppConfigsTableTableManager(_$AppDatabase db, $AppConfigsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppConfigsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppConfigsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppConfigsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppConfigsTable,
    AppConfig,
    $$AppConfigsTableFilterComposer,
    $$AppConfigsTableOrderingComposer,
    $$AppConfigsTableAnnotationComposer,
    $$AppConfigsTableCreateCompanionBuilder,
    $$AppConfigsTableUpdateCompanionBuilder,
    (AppConfig, BaseReferences<_$AppDatabase, $AppConfigsTable, AppConfig>),
    AppConfig,
    PrefetchHooks Function()>;
typedef $$MeetingsTableCreateCompanionBuilder = MeetingsCompanion Function({
  Value<int> id,
  required DateTime date,
  required String location,
  required String agenda,
  Value<int> status,
});
typedef $$MeetingsTableUpdateCompanionBuilder = MeetingsCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<String> location,
  Value<String> agenda,
  Value<int> status,
});

final class $$MeetingsTableReferences
    extends BaseReferences<_$AppDatabase, $MeetingsTable, Meeting> {
  $$MeetingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MeetingAttendanceTable,
      List<MeetingAttendanceData>> _meetingAttendanceRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.meetingAttendance,
          aliasName: $_aliasNameGenerator(
              db.meetings.id, db.meetingAttendance.meetingId));

  $$MeetingAttendanceTableProcessedTableManager get meetingAttendanceRefs {
    final manager =
        $$MeetingAttendanceTableTableManager($_db, $_db.meetingAttendance)
            .filter((f) => f.meetingId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_meetingAttendanceRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MeetingsTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingsTable> {
  $$MeetingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agenda => $composableBuilder(
      column: $table.agenda, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  Expression<bool> meetingAttendanceRefs(
      Expression<bool> Function($$MeetingAttendanceTableFilterComposer f) f) {
    final $$MeetingAttendanceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.meetingAttendance,
        getReferencedColumn: (t) => t.meetingId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MeetingAttendanceTableFilterComposer(
              $db: $db,
              $table: $db.meetingAttendance,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MeetingsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingsTable> {
  $$MeetingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agenda => $composableBuilder(
      column: $table.agenda, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$MeetingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingsTable> {
  $$MeetingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get agenda =>
      $composableBuilder(column: $table.agenda, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> meetingAttendanceRefs<T extends Object>(
      Expression<T> Function($$MeetingAttendanceTableAnnotationComposer a) f) {
    final $$MeetingAttendanceTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.meetingAttendance,
            getReferencedColumn: (t) => t.meetingId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MeetingAttendanceTableAnnotationComposer(
                  $db: $db,
                  $table: $db.meetingAttendance,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$MeetingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MeetingsTable,
    Meeting,
    $$MeetingsTableFilterComposer,
    $$MeetingsTableOrderingComposer,
    $$MeetingsTableAnnotationComposer,
    $$MeetingsTableCreateCompanionBuilder,
    $$MeetingsTableUpdateCompanionBuilder,
    (Meeting, $$MeetingsTableReferences),
    Meeting,
    PrefetchHooks Function({bool meetingAttendanceRefs})> {
  $$MeetingsTableTableManager(_$AppDatabase db, $MeetingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> agenda = const Value.absent(),
            Value<int> status = const Value.absent(),
          }) =>
              MeetingsCompanion(
            id: id,
            date: date,
            location: location,
            agenda: agenda,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required String location,
            required String agenda,
            Value<int> status = const Value.absent(),
          }) =>
              MeetingsCompanion.insert(
            id: id,
            date: date,
            location: location,
            agenda: agenda,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MeetingsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({meetingAttendanceRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (meetingAttendanceRefs) db.meetingAttendance
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (meetingAttendanceRefs)
                    await $_getPrefetchedData<Meeting, $MeetingsTable,
                            MeetingAttendanceData>(
                        currentTable: table,
                        referencedTable: $$MeetingsTableReferences
                            ._meetingAttendanceRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MeetingsTableReferences(db, table, p0)
                                .meetingAttendanceRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.meetingId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MeetingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MeetingsTable,
    Meeting,
    $$MeetingsTableFilterComposer,
    $$MeetingsTableOrderingComposer,
    $$MeetingsTableAnnotationComposer,
    $$MeetingsTableCreateCompanionBuilder,
    $$MeetingsTableUpdateCompanionBuilder,
    (Meeting, $$MeetingsTableReferences),
    Meeting,
    PrefetchHooks Function({bool meetingAttendanceRefs})>;
typedef $$MeetingAttendanceTableCreateCompanionBuilder
    = MeetingAttendanceCompanion Function({
  required int meetingId,
  required int residentId,
  Value<bool> isPresent,
  Value<int> rowid,
});
typedef $$MeetingAttendanceTableUpdateCompanionBuilder
    = MeetingAttendanceCompanion Function({
  Value<int> meetingId,
  Value<int> residentId,
  Value<bool> isPresent,
  Value<int> rowid,
});

final class $$MeetingAttendanceTableReferences extends BaseReferences<
    _$AppDatabase, $MeetingAttendanceTable, MeetingAttendanceData> {
  $$MeetingAttendanceTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $MeetingsTable _meetingIdTable(_$AppDatabase db) =>
      db.meetings.createAlias(
          $_aliasNameGenerator(db.meetingAttendance.meetingId, db.meetings.id));

  $$MeetingsTableProcessedTableManager get meetingId {
    final $_column = $_itemColumn<int>('meeting_id')!;

    final manager = $$MeetingsTableTableManager($_db, $_db.meetings)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meetingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ResidentsTable _residentIdTable(_$AppDatabase db) =>
      db.residents.createAlias($_aliasNameGenerator(
          db.meetingAttendance.residentId, db.residents.id));

  $$ResidentsTableProcessedTableManager get residentId {
    final $_column = $_itemColumn<int>('resident_id')!;

    final manager = $$ResidentsTableTableManager($_db, $_db.residents)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_residentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MeetingAttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingAttendanceTable> {
  $$MeetingAttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isPresent => $composableBuilder(
      column: $table.isPresent, builder: (column) => ColumnFilters(column));

  $$MeetingsTableFilterComposer get meetingId {
    final $$MeetingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.meetingId,
        referencedTable: $db.meetings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MeetingsTableFilterComposer(
              $db: $db,
              $table: $db.meetings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ResidentsTableFilterComposer get residentId {
    final $$ResidentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableFilterComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MeetingAttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingAttendanceTable> {
  $$MeetingAttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isPresent => $composableBuilder(
      column: $table.isPresent, builder: (column) => ColumnOrderings(column));

  $$MeetingsTableOrderingComposer get meetingId {
    final $$MeetingsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.meetingId,
        referencedTable: $db.meetings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MeetingsTableOrderingComposer(
              $db: $db,
              $table: $db.meetings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ResidentsTableOrderingComposer get residentId {
    final $$ResidentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableOrderingComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MeetingAttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingAttendanceTable> {
  $$MeetingAttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isPresent =>
      $composableBuilder(column: $table.isPresent, builder: (column) => column);

  $$MeetingsTableAnnotationComposer get meetingId {
    final $$MeetingsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.meetingId,
        referencedTable: $db.meetings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MeetingsTableAnnotationComposer(
              $db: $db,
              $table: $db.meetings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ResidentsTableAnnotationComposer get residentId {
    final $$ResidentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableAnnotationComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MeetingAttendanceTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MeetingAttendanceTable,
    MeetingAttendanceData,
    $$MeetingAttendanceTableFilterComposer,
    $$MeetingAttendanceTableOrderingComposer,
    $$MeetingAttendanceTableAnnotationComposer,
    $$MeetingAttendanceTableCreateCompanionBuilder,
    $$MeetingAttendanceTableUpdateCompanionBuilder,
    (MeetingAttendanceData, $$MeetingAttendanceTableReferences),
    MeetingAttendanceData,
    PrefetchHooks Function({bool meetingId, bool residentId})> {
  $$MeetingAttendanceTableTableManager(
      _$AppDatabase db, $MeetingAttendanceTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingAttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingAttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetingAttendanceTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> meetingId = const Value.absent(),
            Value<int> residentId = const Value.absent(),
            Value<bool> isPresent = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MeetingAttendanceCompanion(
            meetingId: meetingId,
            residentId: residentId,
            isPresent: isPresent,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int meetingId,
            required int residentId,
            Value<bool> isPresent = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MeetingAttendanceCompanion.insert(
            meetingId: meetingId,
            residentId: residentId,
            isPresent: isPresent,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MeetingAttendanceTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({meetingId = false, residentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (meetingId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.meetingId,
                    referencedTable:
                        $$MeetingAttendanceTableReferences._meetingIdTable(db),
                    referencedColumn: $$MeetingAttendanceTableReferences
                        ._meetingIdTable(db)
                        .id,
                  ) as T;
                }
                if (residentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.residentId,
                    referencedTable:
                        $$MeetingAttendanceTableReferences._residentIdTable(db),
                    referencedColumn: $$MeetingAttendanceTableReferences
                        ._residentIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MeetingAttendanceTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MeetingAttendanceTable,
    MeetingAttendanceData,
    $$MeetingAttendanceTableFilterComposer,
    $$MeetingAttendanceTableOrderingComposer,
    $$MeetingAttendanceTableAnnotationComposer,
    $$MeetingAttendanceTableCreateCompanionBuilder,
    $$MeetingAttendanceTableUpdateCompanionBuilder,
    (MeetingAttendanceData, $$MeetingAttendanceTableReferences),
    MeetingAttendanceData,
    PrefetchHooks Function({bool meetingId, bool residentId})>;
typedef $$IncidentsTableCreateCompanionBuilder = IncidentsCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> description,
  Value<bool> isDone,
  required DateTime date,
  Value<int?> assignedProviderId,
});
typedef $$IncidentsTableUpdateCompanionBuilder = IncidentsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> description,
  Value<bool> isDone,
  Value<DateTime> date,
  Value<int?> assignedProviderId,
});

final class $$IncidentsTableReferences
    extends BaseReferences<_$AppDatabase, $IncidentsTable, Incident> {
  $$IncidentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProvidersTable _assignedProviderIdTable(_$AppDatabase db) =>
      db.providers.createAlias($_aliasNameGenerator(
          db.incidents.assignedProviderId, db.providers.id));

  $$ProvidersTableProcessedTableManager? get assignedProviderId {
    final $_column = $_itemColumn<int>('assigned_provider_id');
    if ($_column == null) return null;
    final manager = $$ProvidersTableTableManager($_db, $_db.providers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assignedProviderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IncidentsTableFilterComposer
    extends Composer<_$AppDatabase, $IncidentsTable> {
  $$IncidentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  $$ProvidersTableFilterComposer get assignedProviderId {
    final $$ProvidersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedProviderId,
        referencedTable: $db.providers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProvidersTableFilterComposer(
              $db: $db,
              $table: $db.providers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncidentsTableOrderingComposer
    extends Composer<_$AppDatabase, $IncidentsTable> {
  $$IncidentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  $$ProvidersTableOrderingComposer get assignedProviderId {
    final $$ProvidersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedProviderId,
        referencedTable: $db.providers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProvidersTableOrderingComposer(
              $db: $db,
              $table: $db.providers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncidentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncidentsTable> {
  $$IncidentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$ProvidersTableAnnotationComposer get assignedProviderId {
    final $$ProvidersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assignedProviderId,
        referencedTable: $db.providers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProvidersTableAnnotationComposer(
              $db: $db,
              $table: $db.providers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncidentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IncidentsTable,
    Incident,
    $$IncidentsTableFilterComposer,
    $$IncidentsTableOrderingComposer,
    $$IncidentsTableAnnotationComposer,
    $$IncidentsTableCreateCompanionBuilder,
    $$IncidentsTableUpdateCompanionBuilder,
    (Incident, $$IncidentsTableReferences),
    Incident,
    PrefetchHooks Function({bool assignedProviderId})> {
  $$IncidentsTableTableManager(_$AppDatabase db, $IncidentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncidentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncidentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncidentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int?> assignedProviderId = const Value.absent(),
          }) =>
              IncidentsCompanion(
            id: id,
            title: title,
            description: description,
            isDone: isDone,
            date: date,
            assignedProviderId: assignedProviderId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            required DateTime date,
            Value<int?> assignedProviderId = const Value.absent(),
          }) =>
              IncidentsCompanion.insert(
            id: id,
            title: title,
            description: description,
            isDone: isDone,
            date: date,
            assignedProviderId: assignedProviderId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IncidentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({assignedProviderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (assignedProviderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.assignedProviderId,
                    referencedTable:
                        $$IncidentsTableReferences._assignedProviderIdTable(db),
                    referencedColumn: $$IncidentsTableReferences
                        ._assignedProviderIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IncidentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IncidentsTable,
    Incident,
    $$IncidentsTableFilterComposer,
    $$IncidentsTableOrderingComposer,
    $$IncidentsTableAnnotationComposer,
    $$IncidentsTableCreateCompanionBuilder,
    $$IncidentsTableUpdateCompanionBuilder,
    (Incident, $$IncidentsTableReferences),
    Incident,
    PrefetchHooks Function({bool assignedProviderId})>;
typedef $$LotsTableCreateCompanionBuilder = LotsCompanion Function({
  Value<int> id,
  required int residentId,
  Value<int> tantiemes,
  Value<String> type,
});
typedef $$LotsTableUpdateCompanionBuilder = LotsCompanion Function({
  Value<int> id,
  Value<int> residentId,
  Value<int> tantiemes,
  Value<String> type,
});

final class $$LotsTableReferences
    extends BaseReferences<_$AppDatabase, $LotsTable, Lot> {
  $$LotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ResidentsTable _residentIdTable(_$AppDatabase db) => db.residents
      .createAlias($_aliasNameGenerator(db.lots.residentId, db.residents.id));

  $$ResidentsTableProcessedTableManager get residentId {
    final $_column = $_itemColumn<int>('resident_id')!;

    final manager = $$ResidentsTableTableManager($_db, $_db.residents)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_residentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LotsTableFilterComposer extends Composer<_$AppDatabase, $LotsTable> {
  $$LotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tantiemes => $composableBuilder(
      column: $table.tantiemes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  $$ResidentsTableFilterComposer get residentId {
    final $$ResidentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableFilterComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LotsTableOrderingComposer extends Composer<_$AppDatabase, $LotsTable> {
  $$LotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tantiemes => $composableBuilder(
      column: $table.tantiemes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  $$ResidentsTableOrderingComposer get residentId {
    final $$ResidentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableOrderingComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LotsTable> {
  $$LotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tantiemes =>
      $composableBuilder(column: $table.tantiemes, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$ResidentsTableAnnotationComposer get residentId {
    final $$ResidentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.residentId,
        referencedTable: $db.residents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ResidentsTableAnnotationComposer(
              $db: $db,
              $table: $db.residents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LotsTable,
    Lot,
    $$LotsTableFilterComposer,
    $$LotsTableOrderingComposer,
    $$LotsTableAnnotationComposer,
    $$LotsTableCreateCompanionBuilder,
    $$LotsTableUpdateCompanionBuilder,
    (Lot, $$LotsTableReferences),
    Lot,
    PrefetchHooks Function({bool residentId})> {
  $$LotsTableTableManager(_$AppDatabase db, $LotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> residentId = const Value.absent(),
            Value<int> tantiemes = const Value.absent(),
            Value<String> type = const Value.absent(),
          }) =>
              LotsCompanion(
            id: id,
            residentId: residentId,
            tantiemes: tantiemes,
            type: type,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int residentId,
            Value<int> tantiemes = const Value.absent(),
            Value<String> type = const Value.absent(),
          }) =>
              LotsCompanion.insert(
            id: id,
            residentId: residentId,
            tantiemes: tantiemes,
            type: type,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LotsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({residentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (residentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.residentId,
                    referencedTable: $$LotsTableReferences._residentIdTable(db),
                    referencedColumn:
                        $$LotsTableReferences._residentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LotsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LotsTable,
    Lot,
    $$LotsTableFilterComposer,
    $$LotsTableOrderingComposer,
    $$LotsTableAnnotationComposer,
    $$LotsTableCreateCompanionBuilder,
    $$LotsTableUpdateCompanionBuilder,
    (Lot, $$LotsTableReferences),
    Lot,
    PrefetchHooks Function({bool residentId})>;
typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  required int classCode,
  required String name,
  Value<int> balanceCents,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  Value<int> classCode,
  Value<String> name,
  Value<int> balanceCents,
});

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get classCode => $composableBuilder(
      column: $table.classCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get balanceCents => $composableBuilder(
      column: $table.balanceCents, builder: (column) => ColumnFilters(column));
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get classCode => $composableBuilder(
      column: $table.classCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get balanceCents => $composableBuilder(
      column: $table.balanceCents,
      builder: (column) => ColumnOrderings(column));
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get classCode =>
      $composableBuilder(column: $table.classCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get balanceCents => $composableBuilder(
      column: $table.balanceCents, builder: (column) => column);
}

class $$AccountsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AccountsTable,
    Account,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (Account, BaseReferences<_$AppDatabase, $AccountsTable, Account>),
    Account,
    PrefetchHooks Function()> {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> classCode = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> balanceCents = const Value.absent(),
          }) =>
              AccountsCompanion(
            id: id,
            classCode: classCode,
            name: name,
            balanceCents: balanceCents,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int classCode,
            required String name,
            Value<int> balanceCents = const Value.absent(),
          }) =>
              AccountsCompanion.insert(
            id: id,
            classCode: classCode,
            name: name,
            balanceCents: balanceCents,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AccountsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AccountsTable,
    Account,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (Account, BaseReferences<_$AppDatabase, $AccountsTable, Account>),
    Account,
    PrefetchHooks Function()>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  required int debitAccountId,
  required int creditAccountId,
  required int amountCents,
  required DateTime date,
  required String description,
  Value<String?> proofHash,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<int> debitAccountId,
  Value<int> creditAccountId,
  Value<int> amountCents,
  Value<DateTime> date,
  Value<String> description,
  Value<String?> proofHash,
});

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _debitAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias(
          $_aliasNameGenerator(db.transactions.debitAccountId, db.accounts.id));

  $$AccountsTableProcessedTableManager get debitAccountId {
    final $_column = $_itemColumn<int>('debit_account_id')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_debitAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AccountsTable _creditAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias($_aliasNameGenerator(
          db.transactions.creditAccountId, db.accounts.id));

  $$AccountsTableProcessedTableManager get creditAccountId {
    final $_column = $_itemColumn<int>('credit_account_id')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_creditAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get proofHash => $composableBuilder(
      column: $table.proofHash, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get debitAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debitAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableFilterComposer get creditAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creditAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get proofHash => $composableBuilder(
      column: $table.proofHash, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get debitAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debitAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableOrderingComposer get creditAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creditAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get proofHash =>
      $composableBuilder(column: $table.proofHash, builder: (column) => column);

  $$AccountsTableAnnotationComposer get debitAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debitAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableAnnotationComposer get creditAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creditAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (Transaction, $$TransactionsTableReferences),
    Transaction,
    PrefetchHooks Function({bool debitAccountId, bool creditAccountId})> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> debitAccountId = const Value.absent(),
            Value<int> creditAccountId = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> proofHash = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            debitAccountId: debitAccountId,
            creditAccountId: creditAccountId,
            amountCents: amountCents,
            date: date,
            description: description,
            proofHash: proofHash,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int debitAccountId,
            required int creditAccountId,
            required int amountCents,
            required DateTime date,
            required String description,
            Value<String?> proofHash = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            debitAccountId: debitAccountId,
            creditAccountId: creditAccountId,
            amountCents: amountCents,
            date: date,
            description: description,
            proofHash: proofHash,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {debitAccountId = false, creditAccountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (debitAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.debitAccountId,
                    referencedTable:
                        $$TransactionsTableReferences._debitAccountIdTable(db),
                    referencedColumn: $$TransactionsTableReferences
                        ._debitAccountIdTable(db)
                        .id,
                  ) as T;
                }
                if (creditAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.creditAccountId,
                    referencedTable:
                        $$TransactionsTableReferences._creditAccountIdTable(db),
                    referencedColumn: $$TransactionsTableReferences
                        ._creditAccountIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (Transaction, $$TransactionsTableReferences),
    Transaction,
    PrefetchHooks Function({bool debitAccountId, bool creditAccountId})>;
typedef $$LegalDocsTableCreateCompanionBuilder = LegalDocsCompanion Function({
  Value<int> id,
  required String type,
  required String recipientName,
  required String contentText,
  required DateTime generatedDate,
  Value<String?> fileHash,
});
typedef $$LegalDocsTableUpdateCompanionBuilder = LegalDocsCompanion Function({
  Value<int> id,
  Value<String> type,
  Value<String> recipientName,
  Value<String> contentText,
  Value<DateTime> generatedDate,
  Value<String?> fileHash,
});

class $$LegalDocsTableFilterComposer
    extends Composer<_$AppDatabase, $LegalDocsTable> {
  $$LegalDocsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recipientName => $composableBuilder(
      column: $table.recipientName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentText => $composableBuilder(
      column: $table.contentText, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get generatedDate => $composableBuilder(
      column: $table.generatedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileHash => $composableBuilder(
      column: $table.fileHash, builder: (column) => ColumnFilters(column));
}

class $$LegalDocsTableOrderingComposer
    extends Composer<_$AppDatabase, $LegalDocsTable> {
  $$LegalDocsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recipientName => $composableBuilder(
      column: $table.recipientName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentText => $composableBuilder(
      column: $table.contentText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get generatedDate => $composableBuilder(
      column: $table.generatedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileHash => $composableBuilder(
      column: $table.fileHash, builder: (column) => ColumnOrderings(column));
}

class $$LegalDocsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LegalDocsTable> {
  $$LegalDocsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get recipientName => $composableBuilder(
      column: $table.recipientName, builder: (column) => column);

  GeneratedColumn<String> get contentText => $composableBuilder(
      column: $table.contentText, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedDate => $composableBuilder(
      column: $table.generatedDate, builder: (column) => column);

  GeneratedColumn<String> get fileHash =>
      $composableBuilder(column: $table.fileHash, builder: (column) => column);
}

class $$LegalDocsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LegalDocsTable,
    LegalDoc,
    $$LegalDocsTableFilterComposer,
    $$LegalDocsTableOrderingComposer,
    $$LegalDocsTableAnnotationComposer,
    $$LegalDocsTableCreateCompanionBuilder,
    $$LegalDocsTableUpdateCompanionBuilder,
    (LegalDoc, BaseReferences<_$AppDatabase, $LegalDocsTable, LegalDoc>),
    LegalDoc,
    PrefetchHooks Function()> {
  $$LegalDocsTableTableManager(_$AppDatabase db, $LegalDocsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LegalDocsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LegalDocsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LegalDocsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> recipientName = const Value.absent(),
            Value<String> contentText = const Value.absent(),
            Value<DateTime> generatedDate = const Value.absent(),
            Value<String?> fileHash = const Value.absent(),
          }) =>
              LegalDocsCompanion(
            id: id,
            type: type,
            recipientName: recipientName,
            contentText: contentText,
            generatedDate: generatedDate,
            fileHash: fileHash,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String type,
            required String recipientName,
            required String contentText,
            required DateTime generatedDate,
            Value<String?> fileHash = const Value.absent(),
          }) =>
              LegalDocsCompanion.insert(
            id: id,
            type: type,
            recipientName: recipientName,
            contentText: contentText,
            generatedDate: generatedDate,
            fileHash: fileHash,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LegalDocsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LegalDocsTable,
    LegalDoc,
    $$LegalDocsTableFilterComposer,
    $$LegalDocsTableOrderingComposer,
    $$LegalDocsTableAnnotationComposer,
    $$LegalDocsTableCreateCompanionBuilder,
    $$LegalDocsTableUpdateCompanionBuilder,
    (LegalDoc, BaseReferences<_$AppDatabase, $LegalDocsTable, LegalDoc>),
    LegalDoc,
    PrefetchHooks Function()>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  required String title,
  required DateTime dueDate,
  Value<bool> isDone,
  Value<int> type,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<DateTime> dueDate,
  Value<bool> isDone,
  Value<int> type,
});

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
    Task,
    PrefetchHooks Function()> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<int> type = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            title: title,
            dueDate: dueDate,
            isDone: isDone,
            type: type,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required DateTime dueDate,
            Value<bool> isDone = const Value.absent(),
            Value<int> type = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            title: title,
            dueDate: dueDate,
            isDone: isDone,
            type: type,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
    Task,
    PrefetchHooks Function()>;
typedef $$ContractsTableCreateCompanionBuilder = ContractsCompanion Function({
  Value<int> id,
  required String employeeName,
  required String role,
  required double salary,
  required String startDate,
});
typedef $$ContractsTableUpdateCompanionBuilder = ContractsCompanion Function({
  Value<int> id,
  Value<String> employeeName,
  Value<String> role,
  Value<double> salary,
  Value<String> startDate,
});

class $$ContractsTableFilterComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeName => $composableBuilder(
      column: $table.employeeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get salary => $composableBuilder(
      column: $table.salary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));
}

class $$ContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeName => $composableBuilder(
      column: $table.employeeName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get salary => $composableBuilder(
      column: $table.salary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));
}

class $$ContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get employeeName => $composableBuilder(
      column: $table.employeeName, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<double> get salary =>
      $composableBuilder(column: $table.salary, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);
}

class $$ContractsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContractsTable,
    Contract,
    $$ContractsTableFilterComposer,
    $$ContractsTableOrderingComposer,
    $$ContractsTableAnnotationComposer,
    $$ContractsTableCreateCompanionBuilder,
    $$ContractsTableUpdateCompanionBuilder,
    (Contract, BaseReferences<_$AppDatabase, $ContractsTable, Contract>),
    Contract,
    PrefetchHooks Function()> {
  $$ContractsTableTableManager(_$AppDatabase db, $ContractsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> employeeName = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<double> salary = const Value.absent(),
            Value<String> startDate = const Value.absent(),
          }) =>
              ContractsCompanion(
            id: id,
            employeeName: employeeName,
            role: role,
            salary: salary,
            startDate: startDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String employeeName,
            required String role,
            required double salary,
            required String startDate,
          }) =>
              ContractsCompanion.insert(
            id: id,
            employeeName: employeeName,
            role: role,
            salary: salary,
            startDate: startDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ContractsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContractsTable,
    Contract,
    $$ContractsTableFilterComposer,
    $$ContractsTableOrderingComposer,
    $$ContractsTableAnnotationComposer,
    $$ContractsTableCreateCompanionBuilder,
    $$ContractsTableUpdateCompanionBuilder,
    (Contract, BaseReferences<_$AppDatabase, $ContractsTable, Contract>),
    Contract,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ResidentsTableTableManager get residents =>
      $$ResidentsTableTableManager(_db, _db.residents);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$ProvidersTableTableManager get providers =>
      $$ProvidersTableTableManager(_db, _db.providers);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$AppConfigsTableTableManager get appConfigs =>
      $$AppConfigsTableTableManager(_db, _db.appConfigs);
  $$MeetingsTableTableManager get meetings =>
      $$MeetingsTableTableManager(_db, _db.meetings);
  $$MeetingAttendanceTableTableManager get meetingAttendance =>
      $$MeetingAttendanceTableTableManager(_db, _db.meetingAttendance);
  $$IncidentsTableTableManager get incidents =>
      $$IncidentsTableTableManager(_db, _db.incidents);
  $$LotsTableTableManager get lots => $$LotsTableTableManager(_db, _db.lots);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$LegalDocsTableTableManager get legalDocs =>
      $$LegalDocsTableTableManager(_db, _db.legalDocs);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$ContractsTableTableManager get contracts =>
      $$ContractsTableTableManager(_db, _db.contracts);
}
