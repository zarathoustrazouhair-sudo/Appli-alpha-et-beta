import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:printing/printing.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/resident.dart';
import 'resident_detail_controller.dart';
import 'residents_controller.dart';
import '../../../../core/services/eco_pdf_service.dart'; // Upgrade to EcoPdfService
import '../../../../data/database/database.dart' hide Resident, Payment;
import '../../settings/presentation/settings_controller.dart';
import '../domain/history_item.dart'; // IMPORT THIS

class ResidentDetailScreen extends ConsumerStatefulWidget {
  final Resident resident;
  final bool autoOpenPayment;

  const ResidentDetailScreen({
    super.key,
    required this.resident,
    this.autoOpenPayment = false,
  });

  @override
  ConsumerState<ResidentDetailScreen> createState() =>
      _ResidentDetailScreenState();
}

class _ResidentDetailScreenState extends ConsumerState<ResidentDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.autoOpenPayment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => _AddPaymentDialog(resident: widget.resident),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Re-fetch resident to ensure we have the latest data (e.g. after edit)
    final residentsList = ref.watch(residentsListProvider).valueOrNull ?? [];
    final currentResident = residentsList.firstWhere(
      (r) => r.id == widget.resident.id,
      orElse: () => widget.resident,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentResident.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Infos'),
              Tab(text: 'Historique'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      _EditResidentDialog(resident: currentResident),
                );
              },
            ),
            _WhatsAppButton(resident: currentResident),
          ],
        ),
        body: TabBarView(
          children: [
            _InfoTab(resident: currentResident),
            _HistoryTab(resident: currentResident),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              heroTag: 'generate_receipt',
              onPressed: () {
                _reprintLastReceipt(context, ref, currentResident);
              },
              label: const Text('Reçu'),
              icon: const Icon(Icons.print),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            FloatingActionButton.extended(
              heroTag: 'new_payment',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => _AddPaymentDialog(resident: currentResident),
                );
              },
              label: const Text('Encaisser'),
              icon: const Icon(Icons.attach_money),
              backgroundColor: const Color(0xFFD4AF37),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reprintLastReceipt(
    BuildContext context,
    WidgetRef ref,
    Resident resident,
  ) async {
    final history = await ref.read(residentHistoryProvider(resident).future);
    // Find first payment
    // We cannot construct HistoryItem.due with DateTime.timestamp() as const if timestamp is not const.
    // Fixed: Removed const and used DateTime.now() or just handled null.

    final lastPaymentItem = history.firstWhere(
      (item) => item.map(payment: (_) => true, due: (_) => false),
      orElse: () => HistoryItem.due(amount: 0, date: DateTime.now(), label: ''),
    );

    lastPaymentItem.map(
      payment: (p) async {
        final config = await ref.read(settingsControllerProvider.future);

        final transaction = Transaction(
          id: p.id,
          debitAccountId: 0,
          creditAccountId: 0,
          amountCents: (p.amount * 100).round(),
          date: p.date,
          description: "Cotisation (Réimpression)",
        );

        final pdfService = EcoPdfService(config);
        final pdfFile = await pdfService.generateReceipt(
          transaction,
          resident.name,
        );
        await Printing.layoutPdf(onLayout: (_) => pdfFile.readAsBytes());
      },
      due: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucun paiement récent trouvé.')),
        );
      },
    );
  }
}

class _WhatsAppButton extends ConsumerWidget {
  final Resident resident;
  const _WhatsAppButton({required this.resident});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(residentBalanceProvider(resident));

    return IconButton(
      icon: const Icon(Icons.message, color: Colors.green),
      onPressed: () async {
        if (resident.phone.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pas de numéro de téléphone')),
          );
          return;
        }

        final number = Formatters.formatWhatsAppNumber(resident.phone);

        final balance = balanceAsync.value ?? 0.0;
        String message;

        if (balance < 0) {
          message =
              "Bonjour M/Mme ${resident.name}, sauf erreur, votre solde est de ${(-balance).toStringAsFixed(2)} DH (Impayé). Merci de régulariser.\n\nLe Syndic.";
        } else {
          final monthsCovered =
              (balance / (resident.monthlyFee > 0 ? resident.monthlyFee : 1))
                  .floor();
          final now = DateTime.now();
          final paidUntil = DateTime(now.year, now.month + monthsCovered);
          final formattedDate =
              "${paidUntil.month.toString().padLeft(2, '0')}/${paidUntil.year}";

          message =
              "Bonjour M/Mme ${resident.name}, merci pour votre paiement. Vous êtes à jour jusqu'à $formattedDate.\n\nLe Syndic.";
        }

        final encodedMessage = Uri.encodeComponent(message);
        final uri = Uri.parse("https://wa.me/$number?text=$encodedMessage");

        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Impossible d\'ouvrir WhatsApp')),
            );
          }
        }
      },
    );
  }
}

class _EditResidentDialog extends ConsumerStatefulWidget {
  final Resident resident;
  const _EditResidentDialog({required this.resident});

  @override
  ConsumerState<_EditResidentDialog> createState() =>
      _EditResidentDialogState();
}

class _EditResidentDialogState extends ConsumerState<_EditResidentDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.resident.name);
    _phoneController = TextEditingController(text: widget.resident.phone);
    _emailController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier Résident'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nom'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Téléphone'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email (Optionnel)'),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () async {
            final updated = widget.resident.copyWith(
              name: _nameController.text,
              phone: _phoneController.text,
            );
            await ref
                .read(residentsListProvider.notifier)
                .updateResident(updated);
            if (mounted) Navigator.pop(context);
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}

class _InfoTab extends ConsumerWidget {
  final Resident resident;
  const _InfoTab({required this.resident});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(residentBalanceProvider(resident));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(label: 'Téléphone', value: resident.phone),
          _InfoRow(label: 'Immeuble', value: resident.building),
          _InfoRow(label: 'Appartement', value: resident.apartment),
          _InfoRow(label: 'Cotisation', value: '${resident.monthlyFee} DH'),
          const Divider(height: 32),

          balanceAsync.when(
            data: (balance) {
              Widget statusWidget;
              if (balance >= 0) {
                final monthsCovered = (balance / resident.monthlyFee).floor();
                final now = DateTime.now();
                final paidUntil = DateTime(now.year, now.month + monthsCovered);

                statusWidget = Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'STATUT COMPTABLE',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'À JOUR',
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Payé jusqu\'au ${paidUntil.month}/${paidUntil.year}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      if (balance > 0)
                        Text(
                          'Solde Créditeur: ${balance.toStringAsFixed(2)} DH',
                          style: const TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                );
              } else {
                final debt = -balance;
                final monthsLate = (debt / resident.monthlyFee).ceil();
                statusWidget = Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'STATUT COMPTABLE',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'EN RETARD',
                        style: TextStyle(
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Retard de $monthsLate mois',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Dette Totale: ${debt.toStringAsFixed(2)} DH',
                        style: TextStyle(
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return statusWidget;
            },
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => const Text('Erreur calcul solde'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class _HistoryTab extends ConsumerWidget {
  final Resident resident;
  const _HistoryTab({required this.resident});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(residentHistoryProvider(resident));

    return historyAsync.when(
      data: (items) {
        if (items.isEmpty)
          return const Center(child: Text('Aucun historique.'));
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return item.when(
              payment: (id, amount, date) => ListTile(
                leading: const Icon(Icons.arrow_upward, color: Colors.green),
                title: const Text(
                  'Paiement reçu',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("${date.day}/${date.month}/${date.year}"),
                trailing: Text(
                  '+${amount.toStringAsFixed(0)} DH',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Could offer reprint here too
                },
              ),
              due: (amount, date, label) => ListTile(
                leading: Icon(
                  Icons.arrow_downward,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  label,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                subtitle: Text("${date.month}/${date.year}"),
                trailing: Text(
                  '-${amount.toStringAsFixed(0)} DH',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur: $e')),
    );
  }
}

class _AddPaymentDialog extends ConsumerStatefulWidget {
  final Resident resident;
  const _AddPaymentDialog({required this.resident});

  @override
  ConsumerState<_AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends ConsumerState<_AddPaymentDialog> {
  final _amountController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nouveau Paiement'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Montant (DH)',
              suffixText: 'DH',
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text('Date: ${_date.day}/${_date.month}/${_date.year}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => _date = picked);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () async {
            final amount = double.tryParse(_amountController.text);
            if (amount != null && amount > 0) {
              await ref
                  .read(residentHistoryProvider(widget.resident).notifier)
                  .addPayment(amount, _date);

              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Paiement enregistré')),
                );
              }
            }
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}
