import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'dart:async';
import '../../../../data/database/database.dart' hide Provider;
import '../../../../data/database/database_provider.dart';
import '../../domain/entities/resident.dart' as domain;
import '../../domain/repositories/resident_repository.dart';

export '../../domain/repositories/resident_repository.dart';

final residentRepositoryProvider = Provider<ResidentRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ResidentRepositoryImpl(db);
});

class ResidentRepositoryImpl implements ResidentRepository {
  final AppDatabase _db;
  ResidentRepositoryImpl(this._db);

  @override
  Stream<List<domain.Resident>> watchAllResidents() {
    return (_db.select(_db.residents)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .watch()
        .map((rows) => rows.map((row) => _toDomain(row)).toList());
  }

  @override
  Future<List<domain.Resident>> getResidents() async {
    final rows = await (_db.select(
      _db.residents,
    )..orderBy([(t) => OrderingTerm(expression: t.name)])).get();
    return rows.map((row) => _toDomain(row)).toList();
  }

  @override
  Stream<List<Payment>> getPayments(domain.Resident resident) {
    return (_db.select(
      _db.payments,
    )..where((t) => t.residentId.equals(resident.id))).watch();
  }

  @override
  Stream<double> getResidentBalance(domain.Resident resident) {
    final id = resident.id;

    final paymentsStream = (_db.select(
      _db.payments,
    )..where((t) => t.residentId.equals(id))).watch();
    final residentStream = (_db.select(
      _db.residents,
    )..where((t) => t.id.equals(id))).watchSingle();

    return Rx.combineLatest2(paymentsStream, residentStream, (
      List<Payment> payments,
      Resident r,
    ) {
      final totalPaid = payments.fold(0.0, (sum, p) => sum + p.amount);

      final now = DateTime.now();
      final start = r.startDate;
      int months = 0;
      if (now.isAfter(start)) {
        months = (now.year - start.year) * 12 + now.month - start.month + 1;
      }
      if (months < 0) months = 0;

      final totalDue = months * r.monthlyFee;
      return totalPaid - totalDue;
    });
  }

  @override
  Future<void> addResident(
    String name,
    String building,
    String apartment,
    String phone,
    int monthlyFee,
    int? floor,
  ) {
    return _db
        .into(_db.residents)
        .insert(
          ResidentsCompanion.insert(
            name: name,
            building: Value(building),
            apartment: Value(apartment),
            phone: Value(phone),
            monthlyFee: Value(monthlyFee),
            floor: Value(floor),
            startDate: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> updateResident(domain.Resident resident) {
    return (_db.update(
      _db.residents,
    )..where((t) => t.id.equals(resident.id))).write(
      ResidentsCompanion(
        name: Value(resident.name),
        phone: Value(resident.phone),
        building: Value(resident.building),
        apartment: Value(resident.apartment),
        monthlyFee: Value(resident.monthlyFee),
        floor: Value(resident.floor),
        pinCode: Value(resident.pinCode), // ADDED pinCode update support
      ),
    );
  }

  @override
  Future<void> deleteResident(int id) {
    return (_db.delete(_db.residents)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> updateAllFees(int newFee) async {
    await (_db.update(
      _db.residents,
    )).write(ResidentsCompanion(monthlyFee: Value(newFee)));
  }

  @override
  Future<void> addPayment(int residentId, double amount, DateTime date) async {
    return _db.transaction(() async {
      // 1. Add Payment Record (Resident History)
      await _db
          .into(_db.payments)
          .insert(
            PaymentsCompanion.insert(
              residentId: residentId,
              amount: amount,
              date: date,
            ),
          );

      // 2. Add Corresponding Transaction (for Finance Tab Visibility)
      // Fetch resident info for Description
      final residentRow = await (_db.select(
        _db.residents,
      )..where((t) => t.id.equals(residentId))).getSingle();

      final amountCents = (amount * 100).round();

      // Find default accounts (Banque vs Produit)
      // We assume Bank (Class 5) and Revenue (Class 7)
      final banks = await (_db.select(
        _db.accounts,
      )..where((t) => t.classCode.equals(5))).get();
      final revenues = await (_db.select(
        _db.accounts,
      )..where((t) => t.classCode.equals(7))).get();

      if (banks.isNotEmpty && revenues.isNotEmpty) {
        final bank = banks.first; // Default Bank
        final revenue = revenues.first; // Default Revenue Account

        await _db
            .into(_db.transactions)
            .insert(
              TransactionsCompanion.insert(
                debitAccountId: bank.id,
                creditAccountId: revenue.id,
                amountCents: amountCents,
                date: date,
                description:
                    "Cotisation - ${residentRow.name} (Apt ${residentRow.apartment})", // VISIBILITY FIX
              ),
            );

        // Update Account Balances (Double Entry)
        // Bank (Asset) increases with Debit
        await (_db.update(
          _db.accounts,
        )..where((t) => t.id.equals(bank.id))).write(
          AccountsCompanion(
            balanceCents: Value(bank.balanceCents + amountCents),
          ),
        );

        // Revenue (Income) increases with Credit
        await (_db.update(
          _db.accounts,
        )..where((t) => t.id.equals(revenue.id))).write(
          AccountsCompanion(
            balanceCents: Value(revenue.balanceCents - amountCents),
          ),
        );
      }
    });
  }

  // Helper
  domain.Resident _toDomain(Resident row) {
    return domain.Resident(
      id: row.id,
      name: row.name,
      phone: row.phone,
      building: row.building,
      apartment: row.apartment,
      floor: row.floor,
      monthlyFee: row.monthlyFee,
      startDate: row.startDate,
      pinCode: row.pinCode, // ADDED Mapping
    );
  }
}

class Rx {
  static Stream<T> combineLatest2<A, B, T>(
    Stream<A> streamA,
    Stream<B> streamB,
    T Function(A a, B b) combiner,
  ) {
    late StreamController<T> controller;
    A? lastA;
    B? lastB;
    bool hasA = false;
    bool hasB = false;

    void update() {
      if (hasA && hasB) {
        if (!controller.isClosed) {
          controller.add(combiner(lastA as A, lastB as B));
        }
      }
    }

    StreamSubscription<A>? subA;
    StreamSubscription<B>? subB;

    controller = StreamController<T>(
      onListen: () {
        subA = streamA.listen((a) {
          lastA = a;
          hasA = true;
          update();
        }, onError: controller.addError);
        subB = streamB.listen((b) {
          lastB = b;
          hasB = true;
          update();
        }, onError: controller.addError);
      },
      onCancel: () async {
        await subA?.cancel();
        await subB?.cancel();
      },
    );

    return controller.stream;
  }
}
