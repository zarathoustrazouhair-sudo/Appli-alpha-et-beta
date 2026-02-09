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
                // TODO: Open Apartment Details (Transactions)
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
        return AlertDialog(
          title: Text('Appartement ${apt.number}'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Propriétaire: ${apt.ownerName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Divider(),
                const Text('Historique récent', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 150,
                  child: StreamBuilder<List<Transaction>>(
                    stream: ref.watch(financialRepositoryProvider).watchTransactions(apt.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Aucune transaction'));
                      }
                      final transactions = snapshot.data!;
                      return ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return ListTile(
                            dense: true,
                            title: Text('${tx.amount} DH - ${tx.type}'),
                            subtitle: Text(tx.date.toString().split(' ')[0]),
                            trailing: tx.type == 'INCOME'
                                ? IconButton(
                                    icon: const Icon(Icons.print, size: 20),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PdfViewerScreen(
                                            title: 'Reçu N°${tx.id}',
                                            buildPdf: (format) => ref.read(pdfServiceProvider).generateReceiptPdf(tx.id),
                                          ),
                                        ),
                                      );
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
                const Text('Nouveau Paiement (INCOME)', style: TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Montant (DH)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
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
                  // Do not close dialog to show update
                  amountController.clear();
                }
              },
              child: const Text('Enregistrer Paiement'),
            ),
          ],
        );
      },
    );
  }
}
