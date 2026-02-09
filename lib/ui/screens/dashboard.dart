import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_db.dart';
import '../../data/repositories/financial_repo.dart';
import '../../data/repositories/settings_repo.dart';
import '../../services/pdf_generator/pdf_service.dart';
import '../widgets/apartment_card.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsRepo = ref.watch(settingsRepositoryProvider);
    final residenceNameStream = settingsRepo.watchResidenceName();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String?>(
          stream: residenceNameStream,
          builder: (context, snapshot) {
            return Text(snapshot.data ?? 'Amandier Manager');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: 'Rapports',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: const ApartmentList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddApartmentDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddApartmentDialog(BuildContext context, WidgetRef ref) {
    final numberController = TextEditingController();
    final ownerController = TextEditingController();
    final feeController = TextEditingController();
    final initialBalanceController = TextEditingController(text: '0.0');
    final entryDateController = TextEditingController(text: DateTime.now().toString().split(' ')[0]);
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un Appartement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: numberController,
                  decoration: const InputDecoration(labelText: 'Numéro Apt'),
                ),
                TextField(
                  controller: ownerController,
                  decoration: const InputDecoration(labelText: 'Propriétaire'),
                ),
                TextField(
                  controller: feeController,
                  decoration: const InputDecoration(labelText: 'Cotisation (DH)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: initialBalanceController,
                  decoration: const InputDecoration(labelText: 'Solde Initial (DH)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: entryDateController,
                  decoration: const InputDecoration(labelText: "Date d'entrée"),
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      selectedDate = date;
                      entryDateController.text = date.toString().split(' ')[0];
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                final number = numberController.text;
                final owner = ownerController.text;
                final fee = double.tryParse(feeController.text);
                final initialBalance = double.tryParse(initialBalanceController.text) ?? 0.0;

                if (number.isNotEmpty && owner.isNotEmpty && fee != null) {
                  final repo = ref.read(financialRepositoryProvider);
                  await repo.addApartment(ApartmentsCompanion(
                    number: drift.Value(number),
                    ownerName: drift.Value(owner),
                    monthlyFee: drift.Value(fee),
                    entryDate: drift.Value(selectedDate),
                    soldeInitial: drift.Value(initialBalance),
                  ));
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }
}

class ApartmentList extends ConsumerWidget {
  const ApartmentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apartmentsAsync = ref.watch(apartmentsStreamProvider);

    return apartmentsAsync.when(
      data: (apartments) {
        if (apartments.isEmpty) {
          return const Center(child: Text('Aucun appartement. Ajoutez-en un !'));
        }
        return ListView.builder(
          itemCount: apartments.length,
          itemBuilder: (context, index) {
            final apt = apartments[index];
            return ApartmentCard(
              apartment: apt,
              onTap: () {
                _showTransactionDialog(context, ref, apt);
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Erreur: $e')),
    );
  }

  void _showTransactionDialog(BuildContext context, WidgetRef ref, Apartment apt) {
    showDialog(
      context: context,
      builder: (context) {
        final amountController = TextEditingController();
        // Use Flex/Expanded to handle different screen sizes as per "Responsive UI" constraint
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Appartement ${apt.number}', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Propriétaire: ${apt.ownerName}'),
                const Divider(),
                Text('Historique récent', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                Expanded(
                  child: StreamBuilder<List<Transaction>>(
                    stream: ref.watch(financialRepositoryProvider).watchTransactions(apt.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Aucune transaction'));
                      }
                      final transactions = snapshot.data!;
                      // ListView.builder strictly used as requested
                      return ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text('${tx.amount} DH - ${tx.type}'),
                            subtitle: Text(tx.date.toString().split(' ')[0]),
                            trailing: tx.type == 'INCOME'
                                ? IconButton(
                                    icon: const Icon(Icons.print, size: 20),
                                    onPressed: () {
                                      // Hybrid Workflow for Receipts
                                      _handleReceiptAction(context, ref, tx);
                                    },
                                  )
                                : null,
                          );
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                Text('Nouveau Paiement (INCOME)', style: Theme.of(context).textTheme.titleSmall),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Montant (DH)'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fermer'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        final amount = double.tryParse(amountController.text);
                        if (amount != null) {
                          final repo = ref.read(financialRepositoryProvider);
                          await repo.addTransaction(TransactionsCompanion(
                            apartmentId: drift.Value(apt.id),
                            type: const drift.Value('INCOME'),
                            amount: drift.Value(amount),
                            date: drift.Value(DateTime.now()),
                            description: const drift.Value('Paiement Cotisation'),
                            category: const drift.Value('Cotisation'),
                          ));
                          amountController.clear();
                        }
                      },
                      child: const Text('Enregistrer'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleReceiptAction(
    BuildContext context,
    WidgetRef ref,
    Transaction tx,
  ) async {
    final fileName = 'Recu_${tx.id}.pdf';

    // Show Modal
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Reçu N°${tx.id}',
                style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('ENREGISTRER'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, foregroundColor: Colors.white),
                    onPressed: () async {
                       Navigator.pop(context);
                       try {
                         final bytes = await ref.read(pdfServiceProvider).generateReceiptPdf(tx.id);
                         await ref.read(pdfServiceProvider).savePdfToRootFolder(fileName, bytes);
                         if (context.mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Reçu sauvegardé')),
                           );
                         }
                       } catch (e) {
                         if (context.mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red),
                           );
                         }
                       }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.print),
                    label: const Text('IMPRIMER'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    onPressed: () async {
                      Navigator.pop(context);
                      final bytes = await ref.read(pdfServiceProvider).generateReceiptPdf(tx.id);
                      ref.read(pdfServiceProvider).printOrSharePdf(fileName, bytes);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
