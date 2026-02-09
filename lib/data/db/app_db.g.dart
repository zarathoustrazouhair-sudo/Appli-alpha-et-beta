// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String? value;
  const Setting({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  Setting copyWith(
          {String? key, Value<String?> value = const Value.absent()}) =>
      Setting(
        key: key ?? this.key,
        value: value.present ? value.value : this.value,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
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
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<Setting> custom({
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

  SettingsCompanion copyWith(
      {Value<String>? key, Value<String?>? value, Value<int>? rowid}) {
    return SettingsCompanion(
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
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ApartmentsTable extends Apartments
    with TableInfo<$ApartmentsTable, Apartment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApartmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _soldeInitialMeta =
      const VerificationMeta('soldeInitial');
  @override
  late final GeneratedColumn<double> soldeInitial = GeneratedColumn<double>(
      'solde_initial', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _monthlyFeeMeta =
      const VerificationMeta('monthlyFee');
  @override
  late final GeneratedColumn<double> monthlyFee = GeneratedColumn<double>(
      'monthly_fee', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _entryDateMeta =
      const VerificationMeta('entryDate');
  @override
  late final GeneratedColumn<DateTime> entryDate = GeneratedColumn<DateTime>(
      'entry_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, number, ownerName, soldeInitial, monthlyFee, entryDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apartments';
  @override
  VerificationContext validateIntegrity(Insertable<Apartment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    } else if (isInserting) {
      context.missing(_ownerNameMeta);
    }
    if (data.containsKey('solde_initial')) {
      context.handle(
          _soldeInitialMeta,
          soldeInitial.isAcceptableOrUnknown(
              data['solde_initial']!, _soldeInitialMeta));
    }
    if (data.containsKey('monthly_fee')) {
      context.handle(
          _monthlyFeeMeta,
          monthlyFee.isAcceptableOrUnknown(
              data['monthly_fee']!, _monthlyFeeMeta));
    } else if (isInserting) {
      context.missing(_monthlyFeeMeta);
    }
    if (data.containsKey('entry_date')) {
      context.handle(_entryDateMeta,
          entryDate.isAcceptableOrUnknown(data['entry_date']!, _entryDateMeta));
    } else if (isInserting) {
      context.missing(_entryDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Apartment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Apartment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name'])!,
      soldeInitial: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}solde_initial'])!,
      monthlyFee: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monthly_fee'])!,
      entryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}entry_date'])!,
    );
  }

  @override
  $ApartmentsTable createAlias(String alias) {
    return $ApartmentsTable(attachedDatabase, alias);
  }
}

class Apartment extends DataClass implements Insertable<Apartment> {
  final int id;
  final String number;
  final String ownerName;
  final double soldeInitial;
  final double monthlyFee;
  final DateTime entryDate;
  const Apartment(
      {required this.id,
      required this.number,
      required this.ownerName,
      required this.soldeInitial,
      required this.monthlyFee,
      required this.entryDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['number'] = Variable<String>(number);
    map['owner_name'] = Variable<String>(ownerName);
    map['solde_initial'] = Variable<double>(soldeInitial);
    map['monthly_fee'] = Variable<double>(monthlyFee);
    map['entry_date'] = Variable<DateTime>(entryDate);
    return map;
  }

  ApartmentsCompanion toCompanion(bool nullToAbsent) {
    return ApartmentsCompanion(
      id: Value(id),
      number: Value(number),
      ownerName: Value(ownerName),
      soldeInitial: Value(soldeInitial),
      monthlyFee: Value(monthlyFee),
      entryDate: Value(entryDate),
    );
  }

  factory Apartment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Apartment(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<String>(json['number']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      soldeInitial: serializer.fromJson<double>(json['soldeInitial']),
      monthlyFee: serializer.fromJson<double>(json['monthlyFee']),
      entryDate: serializer.fromJson<DateTime>(json['entryDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'number': serializer.toJson<String>(number),
      'ownerName': serializer.toJson<String>(ownerName),
      'soldeInitial': serializer.toJson<double>(soldeInitial),
      'monthlyFee': serializer.toJson<double>(monthlyFee),
      'entryDate': serializer.toJson<DateTime>(entryDate),
    };
  }

  Apartment copyWith(
          {int? id,
          String? number,
          String? ownerName,
          double? soldeInitial,
          double? monthlyFee,
          DateTime? entryDate}) =>
      Apartment(
        id: id ?? this.id,
        number: number ?? this.number,
        ownerName: ownerName ?? this.ownerName,
        soldeInitial: soldeInitial ?? this.soldeInitial,
        monthlyFee: monthlyFee ?? this.monthlyFee,
        entryDate: entryDate ?? this.entryDate,
      );
  Apartment copyWithCompanion(ApartmentsCompanion data) {
    return Apartment(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      soldeInitial: data.soldeInitial.present
          ? data.soldeInitial.value
          : this.soldeInitial,
      monthlyFee:
          data.monthlyFee.present ? data.monthlyFee.value : this.monthlyFee,
      entryDate: data.entryDate.present ? data.entryDate.value : this.entryDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Apartment(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('ownerName: $ownerName, ')
          ..write('soldeInitial: $soldeInitial, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('entryDate: $entryDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, number, ownerName, soldeInitial, monthlyFee, entryDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Apartment &&
          other.id == this.id &&
          other.number == this.number &&
          other.ownerName == this.ownerName &&
          other.soldeInitial == this.soldeInitial &&
          other.monthlyFee == this.monthlyFee &&
          other.entryDate == this.entryDate);
}

class ApartmentsCompanion extends UpdateCompanion<Apartment> {
  final Value<int> id;
  final Value<String> number;
  final Value<String> ownerName;
  final Value<double> soldeInitial;
  final Value<double> monthlyFee;
  final Value<DateTime> entryDate;
  const ApartmentsCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.soldeInitial = const Value.absent(),
    this.monthlyFee = const Value.absent(),
    this.entryDate = const Value.absent(),
  });
  ApartmentsCompanion.insert({
    this.id = const Value.absent(),
    required String number,
    required String ownerName,
    this.soldeInitial = const Value.absent(),
    required double monthlyFee,
    required DateTime entryDate,
  })  : number = Value(number),
        ownerName = Value(ownerName),
        monthlyFee = Value(monthlyFee),
        entryDate = Value(entryDate);
  static Insertable<Apartment> custom({
    Expression<int>? id,
    Expression<String>? number,
    Expression<String>? ownerName,
    Expression<double>? soldeInitial,
    Expression<double>? monthlyFee,
    Expression<DateTime>? entryDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (ownerName != null) 'owner_name': ownerName,
      if (soldeInitial != null) 'solde_initial': soldeInitial,
      if (monthlyFee != null) 'monthly_fee': monthlyFee,
      if (entryDate != null) 'entry_date': entryDate,
    });
  }

  ApartmentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? number,
      Value<String>? ownerName,
      Value<double>? soldeInitial,
      Value<double>? monthlyFee,
      Value<DateTime>? entryDate}) {
    return ApartmentsCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      ownerName: ownerName ?? this.ownerName,
      soldeInitial: soldeInitial ?? this.soldeInitial,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      entryDate: entryDate ?? this.entryDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (soldeInitial.present) {
      map['solde_initial'] = Variable<double>(soldeInitial.value);
    }
    if (monthlyFee.present) {
      map['monthly_fee'] = Variable<double>(monthlyFee.value);
    }
    if (entryDate.present) {
      map['entry_date'] = Variable<DateTime>(entryDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApartmentsCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('ownerName: $ownerName, ')
          ..write('soldeInitial: $soldeInitial, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('entryDate: $entryDate')
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
  static const VerificationMeta _apartmentIdMeta =
      const VerificationMeta('apartmentId');
  @override
  late final GeneratedColumn<int> apartmentId = GeneratedColumn<int>(
      'apartment_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES apartments (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, apartmentId, type, amount, date, description, category];
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
    if (data.containsKey('apartment_id')) {
      context.handle(
          _apartmentIdMeta,
          apartmentId.isAcceptableOrUnknown(
              data['apartment_id']!, _apartmentIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
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
      apartmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}apartment_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int? apartmentId;
  final String type;
  final double amount;
  final DateTime date;
  final String description;
  final String category;
  const Transaction(
      {required this.id,
      this.apartmentId,
      required this.type,
      required this.amount,
      required this.date,
      required this.description,
      required this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || apartmentId != null) {
      map['apartment_id'] = Variable<int>(apartmentId);
    }
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      apartmentId: apartmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(apartmentId),
      type: Value(type),
      amount: Value(amount),
      date: Value(date),
      description: Value(description),
      category: Value(category),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      apartmentId: serializer.fromJson<int?>(json['apartmentId']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'apartmentId': serializer.toJson<int?>(apartmentId),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
    };
  }

  Transaction copyWith(
          {int? id,
          Value<int?> apartmentId = const Value.absent(),
          String? type,
          double? amount,
          DateTime? date,
          String? description,
          String? category}) =>
      Transaction(
        id: id ?? this.id,
        apartmentId: apartmentId.present ? apartmentId.value : this.apartmentId,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        description: description ?? this.description,
        category: category ?? this.category,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      apartmentId:
          data.apartmentId.present ? data.apartmentId.value : this.apartmentId,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('apartmentId: $apartmentId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, apartmentId, type, amount, date, description, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.apartmentId == this.apartmentId &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.description == this.description &&
          other.category == this.category);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int?> apartmentId;
  final Value<String> type;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<String> category;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.apartmentId = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.apartmentId = const Value.absent(),
    required String type,
    required double amount,
    required DateTime date,
    required String description,
    required String category,
  })  : type = Value(type),
        amount = Value(amount),
        date = Value(date),
        description = Value(description),
        category = Value(category);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? apartmentId,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (apartmentId != null) 'apartment_id': apartmentId,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? apartmentId,
      Value<String>? type,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String>? description,
      Value<String>? category}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      apartmentId: apartmentId ?? this.apartmentId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (apartmentId.present) {
      map['apartment_id'] = Variable<int>(apartmentId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('apartmentId: $apartmentId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $ApartmentsTable apartments = $ApartmentsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [settings, apartments, transactions];
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  Value<String?> value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String?> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
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

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
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

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
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

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String?> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            Value<String?> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
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

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()>;
typedef $$ApartmentsTableCreateCompanionBuilder = ApartmentsCompanion Function({
  Value<int> id,
  required String number,
  required String ownerName,
  Value<double> soldeInitial,
  required double monthlyFee,
  required DateTime entryDate,
});
typedef $$ApartmentsTableUpdateCompanionBuilder = ApartmentsCompanion Function({
  Value<int> id,
  Value<String> number,
  Value<String> ownerName,
  Value<double> soldeInitial,
  Value<double> monthlyFee,
  Value<DateTime> entryDate,
});

final class $$ApartmentsTableReferences
    extends BaseReferences<_$AppDatabase, $ApartmentsTable, Apartment> {
  $$ApartmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _transactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactions,
              aliasName: $_aliasNameGenerator(
                  db.apartments.id, db.transactions.apartmentId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.apartmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ApartmentsTableFilterComposer
    extends Composer<_$AppDatabase, $ApartmentsTable> {
  $$ApartmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get soldeInitial => $composableBuilder(
      column: $table.soldeInitial, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get entryDate => $composableBuilder(
      column: $table.entryDate, builder: (column) => ColumnFilters(column));

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.apartmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ApartmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ApartmentsTable> {
  $$ApartmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get soldeInitial => $composableBuilder(
      column: $table.soldeInitial,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get entryDate => $composableBuilder(
      column: $table.entryDate, builder: (column) => ColumnOrderings(column));
}

class $$ApartmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApartmentsTable> {
  $$ApartmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<double> get soldeInitial => $composableBuilder(
      column: $table.soldeInitial, builder: (column) => column);

  GeneratedColumn<double> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => column);

  GeneratedColumn<DateTime> get entryDate =>
      $composableBuilder(column: $table.entryDate, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.apartmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ApartmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ApartmentsTable,
    Apartment,
    $$ApartmentsTableFilterComposer,
    $$ApartmentsTableOrderingComposer,
    $$ApartmentsTableAnnotationComposer,
    $$ApartmentsTableCreateCompanionBuilder,
    $$ApartmentsTableUpdateCompanionBuilder,
    (Apartment, $$ApartmentsTableReferences),
    Apartment,
    PrefetchHooks Function({bool transactionsRefs})> {
  $$ApartmentsTableTableManager(_$AppDatabase db, $ApartmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApartmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApartmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApartmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<String> ownerName = const Value.absent(),
            Value<double> soldeInitial = const Value.absent(),
            Value<double> monthlyFee = const Value.absent(),
            Value<DateTime> entryDate = const Value.absent(),
          }) =>
              ApartmentsCompanion(
            id: id,
            number: number,
            ownerName: ownerName,
            soldeInitial: soldeInitial,
            monthlyFee: monthlyFee,
            entryDate: entryDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String number,
            required String ownerName,
            Value<double> soldeInitial = const Value.absent(),
            required double monthlyFee,
            required DateTime entryDate,
          }) =>
              ApartmentsCompanion.insert(
            id: id,
            number: number,
            ownerName: ownerName,
            soldeInitial: soldeInitial,
            monthlyFee: monthlyFee,
            entryDate: entryDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ApartmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<Apartment, $ApartmentsTable,
                            Transaction>(
                        currentTable: table,
                        referencedTable: $$ApartmentsTableReferences
                            ._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ApartmentsTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.apartmentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ApartmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ApartmentsTable,
    Apartment,
    $$ApartmentsTableFilterComposer,
    $$ApartmentsTableOrderingComposer,
    $$ApartmentsTableAnnotationComposer,
    $$ApartmentsTableCreateCompanionBuilder,
    $$ApartmentsTableUpdateCompanionBuilder,
    (Apartment, $$ApartmentsTableReferences),
    Apartment,
    PrefetchHooks Function({bool transactionsRefs})>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<int?> apartmentId,
  required String type,
  required double amount,
  required DateTime date,
  required String description,
  required String category,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<int?> apartmentId,
  Value<String> type,
  Value<double> amount,
  Value<DateTime> date,
  Value<String> description,
  Value<String> category,
});

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ApartmentsTable _apartmentIdTable(_$AppDatabase db) =>
      db.apartments.createAlias(
          $_aliasNameGenerator(db.transactions.apartmentId, db.apartments.id));

  $$ApartmentsTableProcessedTableManager? get apartmentId {
    final $_column = $_itemColumn<int>('apartment_id');
    if ($_column == null) return null;
    final manager = $$ApartmentsTableTableManager($_db, $_db.apartments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_apartmentIdTable($_db));
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

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  $$ApartmentsTableFilterComposer get apartmentId {
    final $$ApartmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.apartmentId,
        referencedTable: $db.apartments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ApartmentsTableFilterComposer(
              $db: $db,
              $table: $db.apartments,
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

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  $$ApartmentsTableOrderingComposer get apartmentId {
    final $$ApartmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.apartmentId,
        referencedTable: $db.apartments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ApartmentsTableOrderingComposer(
              $db: $db,
              $table: $db.apartments,
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  $$ApartmentsTableAnnotationComposer get apartmentId {
    final $$ApartmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.apartmentId,
        referencedTable: $db.apartments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ApartmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.apartments,
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
    PrefetchHooks Function({bool apartmentId})> {
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
            Value<int?> apartmentId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> category = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            apartmentId: apartmentId,
            type: type,
            amount: amount,
            date: date,
            description: description,
            category: category,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> apartmentId = const Value.absent(),
            required String type,
            required double amount,
            required DateTime date,
            required String description,
            required String category,
          }) =>
              TransactionsCompanion.insert(
            id: id,
            apartmentId: apartmentId,
            type: type,
            amount: amount,
            date: date,
            description: description,
            category: category,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({apartmentId = false}) {
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
                if (apartmentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.apartmentId,
                    referencedTable:
                        $$TransactionsTableReferences._apartmentIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._apartmentIdTable(db).id,
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
    PrefetchHooks Function({bool apartmentId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$ApartmentsTableTableManager get apartments =>
      $$ApartmentsTableTableManager(_db, _db.apartments);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
