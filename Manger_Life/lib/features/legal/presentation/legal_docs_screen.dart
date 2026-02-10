import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../core/services/eco_pdf_service.dart';
import '../../../features/residents/presentation/residents_controller.dart';
import '../../../features/settings/presentation/settings_controller.dart';
import '../../../features/transactions/data/transaction_repository.dart';
import '../../../data/models/resident.dart';

class AdministrativeHubScreen extends ConsumerWidget {
  const AdministrativeHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CENTRE ADMINISTRATIF',
          style: TextStyle(fontFamily: 'Serif', letterSpacing: 1.5),
        ),
        backgroundColor: const Color(0xFF121212),
      ),
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCategoryHeader('GESTION FINANCIÈRE', Icons.attach_money),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _AdminButton(
                  icon: Icons.campaign,
                  label: 'Appel de Fonds',
                  onTap: () => _showResidentPicker(
                    context,
                    ref,
                    (r) => _generateAppelFonds(context, ref, r),
                  ),
                ),
                _AdminButton(
                  icon: Icons.receipt,
                  label: 'Reçu Paiement',
                  onTap: () => _showTransactionPicker(context, ref),
                ),
                _AdminButton(
                  icon: Icons.table_chart,
                  label: 'État Global (Matrice)',
                  onTap: () => _generateGlobalMatrix(context, ref),
                ),
                _AdminButton(
                  icon: Icons.book,
                  label: 'Journal de Caisse',
                  onTap: () => _generateJournalCaisse(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildCategoryHeader('OPÉRATIONS & ACHATS', Icons.shopping_cart),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _AdminButton(
                  icon: Icons.request_quote,
                  label: 'Bon de Commande',
                  onTap: () => _showPOCreationDialog(context, ref),
                ),
                // Reçu Ménage moved to RH section
              ],
            ),
            const SizedBox(height: 24),

            _buildCategoryHeader('GESTION PERSONNEL (RH)', Icons.badge),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _AdminButton(
                  icon: Icons.description,
                  label: 'Contrat Concierge',
                  onTap: () => _showContractDialog(context, ref),
                ),
                _AdminButton(
                  icon: Icons.payments,
                  label: 'Bulletin de Paie',
                  onTap: () => _showPayslipDialog(context, ref),
                ),
                _AdminButton(
                  icon: Icons.cleaning_services,
                  label: 'Reçu Femme de Ménage',
                  onTap: () => _showCleaningReceiptDialog(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildCategoryHeader('JURIDIQUE', Icons.gavel),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _AdminButton(
                  icon: Icons.balance,
                  label: 'Pouvoir AG',
                  onTap: () => _showResidentPicker(
                    context,
                    ref,
                    (r) => _generatePouvoir(context, ref, r),
                  ),
                ),
                _AdminButton(
                  icon: Icons.home,
                  label: 'Décharge Logement',
                  onTap: () => _showHousingDialog(context, ref),
                ),
                _AdminButton(
                  icon: Icons.warning,
                  label: 'Mise en Demeure',
                  color: Colors.redAccent,
                  onTap: () => _showResidentPicker(
                    context,
                    ref,
                    (r) => _generateMiseEnDemeure(context, ref, r),
                  ),
                ),
                _AdminButton(
                  icon: Icons.smartphone,
                  label: 'Consentement Digital',
                  onTap: () => _showResidentPicker(
                    context,
                    ref,
                    (r) => _generateConsentement(context, ref, r),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37)),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Expanded(child: Divider(color: Color(0xFFD4AF37), indent: 10)),
        ],
      ),
    );
  }

  // --- ACTIONS ---

  Future<void> _showResidentPicker(
    BuildContext context,
    WidgetRef ref,
    Function(Resident) onSelect,
  ) async {
    final residents = await ref.read(residentsListProvider.future);
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sélectionner un Résident'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: residents.length,
            itemBuilder: (context, index) {
              final r = residents[index];
              return ListTile(
                title: Text(r.name),
                subtitle: Text('Appt: ${r.apartment}'),
                onTap: () {
                  Navigator.pop(context);
                  onSelect(r);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _generateAppelFonds(
    BuildContext context,
    WidgetRef ref,
    Resident resident,
  ) async {
    final now = DateTime.now();
    final quarter = (now.month / 3).ceil();
    final amountCents = (resident.monthlyFee * 3) * 100;

    try {
      final config = await ref.read(settingsControllerProvider.future);
      final pdfService = EcoPdfService(config);
      final pdf = await pdfService.generateAppelDeFonds(
        resident,
        amountCents,
        quarter,
        now.year,
      );
      await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    }
  }

  Future<void> _showTransactionPicker(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final transactions = await ref.read(recentTransactionsStream.future);

    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sélectionner une Transaction'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return ListTile(
                title: Text(tx.description),
                subtitle: Text(
                  '${(tx.amountCents / 100).toStringAsFixed(2)} DH - ${tx.date.toString().split(' ')[0]}',
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final config = await ref.read(
                    settingsControllerProvider.future,
                  );
                  final pdfService = EcoPdfService(config);
                  final pdf = await pdfService.generateReceipt(
                    tx,
                    "Copropriétaire",
                  );
                  await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _generateGlobalMatrix(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final config = await ref.read(settingsControllerProvider.future);
      final pdfService = EcoPdfService(config);
      final residents = await ref.read(residentsListProvider.future);

      Map<int, Map<int, bool>> matrix = {};
      for (var r in residents) {
        matrix[r.id] = {1: true, 2: true, 3: false};
      }

      final pdf = await pdfService.generateGlobalMatrix(
        residents,
        matrix,
        DateTime.now().year,
      );
      await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    }
  }

  Future<void> _generateJournalCaisse(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final config = await ref.read(settingsControllerProvider.future);
      final pdfService = EcoPdfService(config);

      final pdf = await pdfService.generateJournalCaisse(
        15000.0,
        5000.0,
        2000.0,
        18000.0,
        10000.0,
        500.0,
        3000.0,
      );
      await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    }
  }

  Future<void> _showPOCreationDialog(BuildContext context, WidgetRef ref) {
    final providerCtrl = TextEditingController();
    final itemCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    final iceCtrl = TextEditingController();

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nouveau Bon de Commande'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: providerCtrl,
                decoration: const InputDecoration(labelText: 'Fournisseur'),
              ),
              TextField(
                controller: iceCtrl,
                decoration: const InputDecoration(labelText: 'ICE'),
              ),
              TextField(
                controller: itemCtrl,
                decoration: const InputDecoration(
                  labelText: 'Désignation (Service/Produit)',
                ),
              ),
              TextField(
                controller: amountCtrl,
                decoration: const InputDecoration(
                  labelText: 'Montant Total (DH)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (providerCtrl.text.isNotEmpty && amountCtrl.text.isNotEmpty) {
                final config = await ref.read(
                  settingsControllerProvider.future,
                );
                final pdfService = EcoPdfService(config);

                final supplier = {
                  'name': providerCtrl.text,
                  'ice': iceCtrl.text,
                  'quoteRef': 'DEVIS-001',
                };
                final items = [
                  {
                    'name': itemCtrl.text,
                    'qty': 1,
                    'price': double.tryParse(amountCtrl.text) ?? 0,
                  },
                ];

                final pdf = await pdfService.generateBonDeCommande(
                  "BC-${DateTime.now().millisecondsSinceEpoch}",
                  supplier,
                  items,
                  "Charges Courantes (601)",
                  DateTime.now(),
                );

                if (context.mounted) {
                  Navigator.pop(context);
                  await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
                }
              }
            },
            child: const Text('Générer'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCleaningReceiptDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final cinCtrl = TextEditingController();
    final hoursCtrl = TextEditingController();
    final rateCtrl = TextEditingController(text: '20');

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Prestation Ménage'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nom Intervenant(e)',
                ),
              ),
              TextField(
                controller: cinCtrl,
                decoration: const InputDecoration(labelText: 'CIN'),
              ),
              TextField(
                controller: hoursCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre d\'heures (Int)',
                ),
              ),
              TextField(
                controller: rateCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tarif Horaire (DH)',
                ),
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
              if (nameCtrl.text.isNotEmpty && hoursCtrl.text.isNotEmpty) {
                try {
                  final config = await ref.read(
                    settingsControllerProvider.future,
                  );
                  final pdfService = EcoPdfService(config);

                  final hours = double.tryParse(hoursCtrl.text) ?? 0;
                  final rate = double.tryParse(rateCtrl.text) ?? 20;

                  final pdf = await pdfService.generateRecuPrestationMenage(
                    nameCtrl.text,
                    cinCtrl.text,
                    DateTime.now().toString().split(' ')[0],
                    hours,
                    rate,
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                    await Printing.layoutPdf(
                      onLayout: (_) => pdf.readAsBytes(),
                    );
                  }
                } catch (e) {
                  if (context.mounted)
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
                }
              }
            },
            child: const Text('Générer'),
          ),
        ],
      ),
    );
  }

  Future<void> _showContractDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final cinCtrl = TextEditingController();
    final salaryCtrl = TextEditingController();

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nouveau Contrat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nom Employé'),
            ),
            TextField(
              controller: cinCtrl,
              decoration: const InputDecoration(labelText: 'CIN'),
            ),
            TextField(
              controller: salaryCtrl,
              decoration: const InputDecoration(labelText: 'Salaire Net (DH)'),
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
              if (nameCtrl.text.isNotEmpty) {
                final config = await ref.read(
                  settingsControllerProvider.future,
                );
                final pdfService = EcoPdfService(config);
                final pdf = await pdfService.generateContratConcierge(
                  nameCtrl.text,
                  cinCtrl.text,
                  double.tryParse(salaryCtrl.text) ?? 3000,
                  44,
                  "Dimanche",
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
                }
              }
            },
            child: const Text('Générer'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPayslipDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final monthCtrl = TextEditingController(
      text: DateTime.now().month.toString(),
    );
    final salaryCtrl = TextEditingController();

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bulletin de Paie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nom Employé'),
            ),
            TextField(
              controller: monthCtrl,
              decoration: const InputDecoration(labelText: 'Mois (1-12)'),
            ),
            TextField(
              controller: salaryCtrl,
              decoration: const InputDecoration(labelText: 'Salaire Base'),
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
              final config = await ref.read(settingsControllerProvider.future);
              final pdfService = EcoPdfService(config);
              final pdf = await pdfService.generateBulletinPaieConcierge(
                nameCtrl.text,
                "CIN",
                int.tryParse(monthCtrl.text) ?? 1,
                DateTime.now().year,
                double.tryParse(salaryCtrl.text) ?? 3000,
                0,
                0,
                0,
                0,
                0,
                "N/A",
                "Virement",
              );
              if (context.mounted) {
                Navigator.pop(context);
                await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
              }
            },
            child: const Text('Générer'),
          ),
        ],
      ),
    );
  }

  Future<void> _generatePouvoir(
    BuildContext context,
    WidgetRef ref,
    Resident resident,
  ) async {
    final config = await ref.read(settingsControllerProvider.future);
    final pdfService = EcoPdfService(config);
    final pdf = await pdfService.generatePouvoir(resident, DateTime.now());
    await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
  }

  Future<void> _showHousingDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Décharge Logement'),
        content: TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(labelText: 'Nom Gardien'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final config = await ref.read(settingsControllerProvider.future);
              final pdfService = EcoPdfService(config);
              final pdf = await pdfService.generateDechargeLogement(
                nameCtrl.text,
                DateTime.now(),
              );
              if (context.mounted) {
                Navigator.pop(context);
                await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
              }
            },
            child: const Text('Générer'),
          ),
        ],
      ),
    );
  }

  Future<void> _generateMiseEnDemeure(
    BuildContext context,
    WidgetRef ref,
    Resident resident,
  ) async {
    const debt = 50000;
    final config = await ref.read(settingsControllerProvider.future);
    final pdfService = EcoPdfService(config);
    final pdf = await pdfService.generateMiseEnDemeure(
      resident,
      debt,
      "HASH123",
    );
    await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
  }

  Future<void> _generateConsentement(
    BuildContext context,
    WidgetRef ref,
    Resident resident,
  ) async {
    final config = await ref.read(settingsControllerProvider.future);
    final pdfService = EcoPdfService(config);
    final pdf = await pdfService.generateConsentementDigital(
      resident,
      resident.apartment,
      resident.phone,
    );
    await Printing.layoutPdf(onLayout: (_) => pdf.readAsBytes());
  }
}

class _AdminButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _AdminButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: (color ?? const Color(0xFFD4AF37)).withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color ?? const Color(0xFFD4AF37), size: 32),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
