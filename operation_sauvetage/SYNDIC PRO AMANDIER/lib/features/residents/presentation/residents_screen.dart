import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/residents/domain/entities/resident.dart';
import 'residents_controller.dart';
import 'add_resident_modal.dart';
import 'resident_detail_screen.dart';
import 'bulk_relaunch_screen.dart';

class ResidentsScreen extends ConsumerWidget {
  const ResidentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final residentsAsync = ref.watch(residentsListProvider);

    return Scaffold(
      // AppBar is already provided by ManagementTab, but we can have sub-actions or just body
      // Actually ManagementTab has the AppBar with Tabs. ResidentsScreen is the TabBarView child.
      // So we don't need another Scaffold with AppBar unless we want FAB and Body specific.
      // Nested Scaffold is fine for FAB.
      body: residentsAsync.when(
        data: (residents) {
          if (residents.isEmpty) {
            return const Center(child: Text('Aucun résident.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80), // Space for FAB
            itemCount: residents.length,
            itemBuilder: (context, index) {
              final resident = residents[index];
              return _ResidentCard(resident: resident);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'bulk_relaunch',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BulkRelaunchScreen()),
              );
            },
            label: const Text('Mode Rafale'),
            icon: const Icon(Icons.send),
            backgroundColor: Colors.redAccent,
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add_resident',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const AddResidentModal(),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _ResidentCard extends ConsumerWidget {
  final Resident resident;

  const _ResidentCard({required this.resident});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(residentBalanceProvider(resident));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResidentDetailScreen(resident: resident),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF1E1E1E),
                child: Text(
                  resident.apartment,
                  style: const TextStyle(color: Color(0xFFD4AF37)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resident.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    balanceAsync.when(
                      data: (balance) {
                        if (balance >= 0) {
                          // Logic: Paid until when?
                          // Simplified: +1 month for every fee unit in balance
                          final months = (balance / resident.monthlyFee)
                              .floor();
                          final now = DateTime.now();
                          final paidUntil = DateTime(
                            now.year,
                            now.month + months,
                          );
                          return Text(
                            'Payé jusqu\'à ${paidUntil.month}/${paidUntil.year}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          );
                        } else {
                          return Text(
                            'Impayé',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12,
                            ),
                          );
                        }
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              balanceAsync.when(
                data: (balance) => Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${balance.toStringAsFixed(2)} DH',
                      style: TextStyle(
                        color: balance >= 0
                            ? Colors.green
                            : Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (balance < 0)
                      TextButton.icon(
                        onPressed: () {
                          // Quick Pay Action
                          // For now, open detail and trigger payment dialog?
                          // Or direct dialog here.
                          // Let's open Detail Screen -> Payment Dialog for better UX flow
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResidentDetailScreen(
                                resident: resident,
                                autoOpenPayment: true,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.payment, size: 16),
                        label: const Text('Encaisser'),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                  ],
                ),
                loading: () => const CircularProgressIndicator(strokeWidth: 2),
                error: (_, __) => const Icon(Icons.error, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
