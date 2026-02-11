import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../../data/database/database.dart' hide Provider;
import '../data/transaction_repository.dart';
import 'transaction_entry_screen.dart';
import '../../../../features/settings/presentation/settings_controller.dart';
import '../../../../features/pdf_reports/data/services/eco_pdf_service_impl.dart';

// Const Color for Low RAM usage
const Color kCardColor = Color(0xFF1E1E1E);
const Color kGoldColor = Color(0xFFD4AF37);

class TransactionsHistoryScreen extends ConsumerWidget {
  const TransactionsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch last 50 transactions
    final historyAsync = ref.watch(transactionHistoryStream);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'FINANCES',
          style: TextStyle(
            letterSpacing: 1.5,
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
      ),
      body: historyAsync.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return const Center(
              child: Text(
                'Aucune opération.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              final amountDH = tx.amountCents / 100.0;

              return Card(
                color: kCardColor,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: const Icon(Icons.receipt_long, color: Colors.grey),
                  title: Text(
                    tx.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    tx.date.toString().split(' ')[0],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${amountDH.toStringAsFixed(2)} DH',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.print, color: kGoldColor),
                        onPressed: () async {
                          try {
                            final config = await ref.read(
                              settingsControllerProvider.future,
                            );
                            final pdfService = ref.read(pdfServiceProvider);
                            // Need resident name? Receipt usually implies resident payment.
                            // But Transaction table doesn't link to Resident directly unless we join or parse desc.
                            // For now, pass "Résident / Fournisseur" or check if `debitAccountId` is a Class 7 (Revenue from resident).
                            // We'll pass a generic name or "Copropriétaire".
                            // Ideally, we store residentId in transaction or link it.
                            // EcoPdfService.generateReceipt(tx, "Copropriétaire")

                            final pdfFile = await pdfService.generateReceipt(
                              tx,
                              "Copropriétaire (Voir Description)",
                            );
                            await Printing.layoutPdf(
                              onLayout: (_) => pdfFile.readAsBytes(),
                            );
                          } catch (e) {
                            if (context.mounted)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Erreur: $e')),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Erreur: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGoldColor,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TransactionEntryScreen()),
          );
        },
      ),
    );
  }
}

final transactionHistoryStream = StreamProvider<List<Transaction>>((ref) {
  // Watch last 50 transactions
  return ref.watch(transactionRepositoryProvider).watchRecentTransactions(50);
});
