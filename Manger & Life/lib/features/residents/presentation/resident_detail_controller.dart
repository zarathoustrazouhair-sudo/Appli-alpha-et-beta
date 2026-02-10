import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../domain/repositories/resident_repository.dart';
import '../../../../domain/entities/resident.dart';
import '../domain/history_item.dart';

part 'resident_detail_controller.g.dart';

@riverpod
class ResidentHistory extends _$ResidentHistory {
  @override
  Stream<List<HistoryItem>> build(Resident resident) {
    final repository = ref.watch(residentRepositoryProvider);

    // Watch payments
    final paymentsStream = repository.getPayments(resident);

    return paymentsStream.map((payments) {
      final items = <HistoryItem>[];

      // Add Payments
      for (var p in payments) {
        items.add(
          HistoryItem.payment(id: p.id, amount: p.amount, date: p.date),
        );
      }

      // Add Dues (Generated)
      final now = DateTime.now();
      var date = resident.startDate;
      while (date.isBefore(now) ||
          (date.month == now.month && date.year == now.year)) {
        items.add(
          HistoryItem.due(
            amount: resident.monthlyFee.toDouble(),
            date: date,
            label: 'Cotisation ${date.month}/${date.year}',
          ),
        );
        date = DateTime(date.year, date.month + 1, 1);
      }

      // Sort desc
      items.sort((a, b) {
        final dateA = a.map(payment: (p) => p.date, due: (d) => d.date);
        final dateB = b.map(payment: (p) => p.date, due: (d) => d.date);
        return dateB.compareTo(dateA);
      });

      return items;
    });
  }

  Future<void> addPayment(double amount, DateTime date) async {
    final repository = ref.read(residentRepositoryProvider);
    await repository.addPayment(resident.id, amount, date);
  }
}
