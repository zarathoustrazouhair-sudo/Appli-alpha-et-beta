import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../domain/repositories/resident_repository.dart';
import '../../../../domain/entities/resident.dart';
import '../domain/dashboard_state.dart';
import '../../transactions/data/transaction_repository.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardStats extends _$DashboardStats {
  @override
  Stream<DashboardData> build() {
    // Combine Streams for Dashboard Data
    final residentRepo = ref.watch(residentRepositoryProvider);
    final transactionRepo = ref.watch(transactionRepositoryProvider);

    // 1. Total Balance (Class 5)
    final balanceStream = transactionRepo.watchTotalBalance(5);

    // 2. Residents
    final residentsStream = residentRepo.watchAllResidents();

    // Combine
    return Rx.combineLatest2(balanceStream, residentsStream, (
      int balanceCents,
      List<Resident> residents,
    ) {
      double totalBalance = balanceCents / 100.0;

      return DashboardData(
        totalBalance: totalBalance,
        totalResidents: residents.length,
        unpaidResidentsCount: 0, // Placeholder
      );
    });
  }
}

// Rx Helper
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
