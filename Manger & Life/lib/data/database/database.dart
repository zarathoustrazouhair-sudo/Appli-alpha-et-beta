import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

// RESIDENT MANAGEMENT (Legacy & New)
class Residents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get building => text().withDefault(const Constant('B'))();
  TextColumn get apartment => text().withDefault(const Constant('0'))();
  IntColumn get floor => integer().nullable()();
  IntColumn get monthlyFee => integer().withDefault(const Constant(250))();
  DateTimeColumn get startDate => dateTime().withDefault(currentDate)();
  TextColumn get pinCode => text().nullable()();
}

class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get residentId =>
      integer().references(Residents, #id, onDelete: KeyAction.restrict)();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
}

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  TextColumn get category => text().withDefault(const Constant('Autre'))();
  TextColumn get proofImagePath => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get providerName => text().nullable()();
  IntColumn get providerId => integer().nullable().references(
    Providers,
    #id,
    onDelete: KeyAction.setNull,
  )();
}

class AppConfigs extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

class Meetings extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get location => text()();
  TextColumn get agenda => text()();
  IntColumn get status => integer().withDefault(const Constant(0))();
}

class MeetingAttendance extends Table {
  IntColumn get meetingId =>
      integer().references(Meetings, #id, onDelete: KeyAction.cascade)();
  IntColumn get residentId =>
      integer().references(Residents, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isPresent => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {meetingId, residentId};
}

class Providers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get jobType => text()();
  TextColumn get phone => text()();
}

class Incidents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get date => dateTime()();
  IntColumn get assignedProviderId => integer().nullable().references(
    Providers,
    #id,
    onDelete: KeyAction.setNull,
  )();
}

class Lots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get residentId =>
      integer().references(Residents, #id, onDelete: KeyAction.cascade)();
  IntColumn get tantiemes => integer().withDefault(const Constant(0))();
  TextColumn get type => text().withDefault(const Constant('Appartement'))();
}

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get classCode => integer()();
  TextColumn get name => text()();
  IntColumn get balanceCents => integer().withDefault(const Constant(0))();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get debitAccountId => integer().references(Accounts, #id)();
  IntColumn get creditAccountId => integer().references(Accounts, #id)();
  IntColumn get amountCents => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  TextColumn get proofHash => text().nullable()();
}

class LegalDocs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get recipientName => text()();
  TextColumn get contentText => text()();
  DateTimeColumn get generatedDate => dateTime()();
  TextColumn get fileHash => text().nullable()();
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  IntColumn get type => integer().withDefault(const Constant(0))();
}

class Contracts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get employeeName => text()();
  TextColumn get role => text()();
  RealColumn get salary => real()();
  TextColumn get startDate => text()();
}

@DriftDatabase(
  tables: [
    Residents,
    Payments,
    Expenses,
    AppConfigs,
    Meetings,
    MeetingAttendance,
    Providers,
    Incidents,
    Lots,
    Accounts,
    Transactions,
    LegalDocs,
    Tasks,
    Contracts,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 6) {
        await m.createTable(incidents);
      }
      if (from < 7) {
        await m.createTable(lots);
        await m.createTable(accounts);
        await m.createTable(transactions);
        await m.createTable(legalDocs);
      }
      if (from < 8) {
        await m.createTable(tasks);
      }
      if (from < 9) {
        await m.createTable(contracts);
        await m.createTable(providers);
      }
      if (from < 10) {
        try {
          await m.createTable(contracts);
        } catch (_) {}
        try {
          await m.createTable(providers);
        } catch (_) {}
      }
      if (from < 11) {
        await m.addColumn(residents, residents.pinCode);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');

      final result = await customSelect(
        'SELECT count(*) as c FROM accounts',
      ).getSingleOrNull();
      if (result != null) {
        final count = result.read<int>('c');
        if (count == 0) {
          await batch((batch) {
            batch.insertAll(accounts, [
              AccountsCompanion.insert(
                classCode: 1,
                name: 'Fonds de Travaux / Réserve',
                balanceCents: const Value(0),
              ),
              AccountsCompanion.insert(
                classCode: 5,
                name: 'Banque Populaire (Caisse)',
                balanceCents: const Value(0),
              ),
              AccountsCompanion.insert(
                classCode: 6,
                name: 'Eau & Électricité (601)',
                balanceCents: const Value(0),
              ),
              AccountsCompanion.insert(
                classCode: 6,
                name: 'Nettoyage & Entretien (602)',
                balanceCents: const Value(0),
              ),
              AccountsCompanion.insert(
                classCode: 6,
                name: 'Maintenance Ascenseur (603)',
                balanceCents: const Value(0),
              ),
              AccountsCompanion.insert(
                classCode: 6,
                name: 'Honoraires Syndic (604)',
                balanceCents: const Value(0),
              ),
              AccountsCompanion.insert(
                classCode: 6,
                name: 'Autres Charges (605)',
                balanceCents: const Value(0),
              ),
              AccountsCompanion.insert(
                classCode: 7,
                name: 'Cotisations Mensuelles (701)',
                balanceCents: const Value(0),
              ),
            ]);
          });
        }
      }

      final resCount = await customSelect(
        'SELECT count(*) as c FROM residents',
      ).getSingleOrNull();
      if (resCount != null && resCount.read<int>('c') == 0) {
        await batch((batch) {
          batch.insertAll(residents, [
            ResidentsCompanion.insert(
              id: const Value(1),
              floor: const Value(1),
              apartment: const Value('1'),
              name: 'AYAZI ADNAN',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(2),
              floor: const Value(1),
              apartment: const Value('2'),
              name: 'DEHBI FATIMA',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(3),
              floor: const Value(1),
              apartment: const Value('3'),
              name: 'MOUKTADI NORA',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(4),
              floor: const Value(1),
              apartment: const Value('4'),
              name: 'JALILA ANNAN',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(5),
              floor: const Value(1),
              apartment: const Value('5'),
              name: 'YAHYA SBAI',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(6),
              floor: const Value(2),
              apartment: const Value('6'),
              name: 'BOUKHERSSA YASMINE',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(7),
              floor: const Value(2),
              apartment: const Value('7'),
              name: 'LIASSINI JALAL EDDINE',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(8),
              floor: const Value(2),
              apartment: const Value('8'),
              name: 'KENBOUCHI ABDELATI',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(9),
              floor: const Value(2),
              apartment: const Value('9'),
              name: 'MARWA SBAILI',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(10),
              floor: const Value(2),
              apartment: const Value('10'),
              name: 'HALIL BESSAM',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(11),
              floor: const Value(3),
              apartment: const Value('11'),
              name: 'RAHIL ADIL',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(12),
              floor: const Value(3),
              apartment: const Value('12'),
              name: 'ARIF MOHSINE',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(13),
              floor: const Value(3),
              apartment: const Value('13'),
              name: 'OUALAD ASMAA',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(14),
              floor: const Value(3),
              apartment: const Value('14'),
              name: 'FIDAR NAOUAL',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
            ResidentsCompanion.insert(
              id: const Value(15),
              floor: const Value(3),
              apartment: const Value('15'),
              name: 'ESSAIDI KAWTAR',
              phone: const Value(''),
              pinCode: const Value('0000'),
            ),
          ]);
        });
      }

      const ribText =
          "1. Pour un virement au Maroc (National)\n"
          "Bénéficiaire : STE SYNDICAT AMANDIER B\n"
          "Banque : BANK OF AFRICA (Agence Bachkou)\n"
          "RIB (24 chiffres) : 011794000051200000374935\n\n"
          "2. Pour un virement de l'étranger (International)\n"
          "Bénéficiaire : STE SYNDICAT AMANDIER B\n"
          "Banque : BANK OF AFRICA - BMCE GROUP\n"
          "Code SWIFT / BIC : BMCEMAMC\n"
          "IBAN (International) : MA64011794000051200000374935";

      await into(appConfigs).insertOnConflictUpdate(
        AppConfigsCompanion.insert(key: 'RIB', value: ribText),
      );

      // FIXED SYNTAX: not(...)
      final anonymousTx =
          await (select(transactions)..where(
                (t) =>
                    t.description.like('Cotisation') &
                    t.description.like('%(%').not(),
              ))
              .get();
      if (anonymousTx.isNotEmpty) {
        final allPayments = await select(payments).get();
        final allResidents = await select(residents).get();
        for (var tx in anonymousTx) {
          try {
            final match = allPayments.where((p) {
              final diff = p.date.difference(tx.date).inSeconds.abs();
              final pAmountCents = (p.amount * 100).round();
              return diff < 5 && pAmountCents == tx.amountCents;
            }).firstOrNull;
            if (match != null) {
              final resident = allResidents
                  .where((r) => r.id == match.residentId)
                  .firstOrNull;
              if (resident != null) {
                await (update(
                  transactions,
                )..where((t) => t.id.equals(tx.id))).write(
                  TransactionsCompanion(
                    description: Value(
                      "Cotisation - ${resident.name} (Apt ${resident.apartment})",
                    ),
                  ),
                );
              }
            }
          } catch (e) {
            print("Migration Fix Error: $e");
          }
        }
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
