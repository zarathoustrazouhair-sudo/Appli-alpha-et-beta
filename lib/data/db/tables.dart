import 'package:drift/drift.dart';

// Table Settings (Key/Value store)
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

// Table Apartments
class Apartments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get number => text()();
  TextColumn get ownerName => text()();
  RealColumn get soldeInitial => real().withDefault(const Constant(0.0))();
  RealColumn get monthlyFee => real()();
  DateTimeColumn get entryDate => dateTime()();
}

// Table Transactions
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get apartmentId => integer().nullable().references(Apartments, #id)();
  TextColumn get type => text()(); // 'INCOME' or 'EXPENSE'
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  TextColumn get category => text()();
}
