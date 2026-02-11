import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart'
    hide Column; // Hide Column to avoid conflict with Flutter
import '../../../../features/residents/data/repositories/resident_repository.dart';
import '../../../../data/database/database_provider.dart';
import '../../residents/presentation/residents_controller.dart'; // IMPORT ADDED
import 'global_report_controller.dart'; // Reconnect Orphan Controller

part 'global_situation_screen.g.dart';

// Provider to fetch Matrix Data
@riverpod
Future<Map<int, Map<int, bool>>> paymentMatrix(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final year = DateTime.now().year;

  // Fetch all payments for current year
  // Fix: Drift date year filtering
  final startOfYear = DateTime(year, 1, 1);
  final endOfYear = DateTime(year + 1, 1, 1);

  final payments = await (db.select(
    db.payments,
  )..where((t) => t.date.isBetweenValues(startOfYear, endOfYear))).get();

  final residents = await ref.read(residentRepositoryProvider).getResidents();
  final Map<int, Map<int, bool>> matrix = {};

  for (var r in residents) {
    // Get payments for this resident
    final rPayments = payments.where((p) => p.residentId == r.id).toList();
    // final totalPaid = rPayments.fold(0.0, (sum, p) => sum + p.amount); // Unused

    // Calculate how many months covered from start of year
    final balance = await ref
        .read(residentRepositoryProvider)
        .getResidentBalance(r)
        .first;

    final monthsCovered = (balance / r.monthlyFee).floor();
    final now = DateTime.now();
    final paidUntil = DateTime(now.year, now.month + monthsCovered);

    final rMap = <int, bool>{};
    for (int m = 1; m <= 12; m++) {
      final monthDate = DateTime(now.year, m, 1);

      if (monthDate.isBefore(paidUntil) ||
          (monthDate.month == paidUntil.month &&
              monthDate.year == paidUntil.year)) {
        rMap[m] = true;
      } else {
        rMap[m] = false;
      }
    }
    matrix[r.id] = rMap;
  }

  return matrix;
}

class GlobalSituationScreen extends ConsumerWidget {
  const GlobalSituationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final residentsAsync = ref.watch(residentsListProvider); // Now Imported
    final matrixAsync = ref.watch(paymentMatrixProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Situation Annuelle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              ref
                  .read(globalReportControllerProvider.notifier)
                  .generateAndPrint();
            },
          ),
        ],
      ),
      body: residentsAsync.when(
        data: (residents) {
          return matrixAsync.when(
            data: (matrix) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Résident',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(label: Text('J')),
                      DataColumn(label: Text('F')),
                      DataColumn(label: Text('M')),
                      DataColumn(label: Text('A')),
                      DataColumn(label: Text('M')),
                      DataColumn(label: Text('J')),
                      DataColumn(label: Text('J')),
                      DataColumn(label: Text('A')),
                      DataColumn(label: Text('S')),
                      DataColumn(label: Text('O')),
                      DataColumn(label: Text('N')),
                      DataColumn(label: Text('D')),
                    ],
                    rows: residents.map((r) {
                      final rMatrix = matrix[r.id] ?? {};
                      return DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 100,
                              child: Text(
                                r.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ...List.generate(12, (index) {
                            final month = index + 1;
                            final isPaid = rMatrix[month] ?? false;
                            final isFuture = DateTime(
                              DateTime.now().year,
                              month,
                            ).isAfter(DateTime.now());

                            Color color;
                            if (isFuture) {
                              color = Colors.grey.withOpacity(0.3); // Future
                            } else if (isPaid) {
                              color = Colors.green; // Paid
                            } else {
                              color = Colors.red; // Unpaid
                            }

                            return DataCell(
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur matrice: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur résidents: $e')),
      ),
    );
  }
}
