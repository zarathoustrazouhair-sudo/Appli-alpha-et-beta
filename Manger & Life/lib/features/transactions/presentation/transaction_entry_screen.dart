import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/database/database.dart'
    hide Provider; // Hide Provider to avoid conflict
import '../../transactions/data/transaction_repository.dart';
import '../../../../core/widgets/legal_help_icon.dart'; // Import Help Icon
import '../../settings/presentation/settings_controller.dart'; // Import for config

class TransactionEntryScreen extends ConsumerStatefulWidget {
  const TransactionEntryScreen({super.key});

  @override
  ConsumerState<TransactionEntryScreen> createState() =>
      _TransactionEntryScreenState();
}

class _TransactionEntryScreenState
    extends ConsumerState<TransactionEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();

  bool _isExpense = true;
  Account? _selectedAccount;
  Account? _selectedBank;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    if (_formKey.currentState!.validate()) {
      if (_selectedAccount == null || _selectedBank == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez sélectionner les comptes')),
        );
        return;
      }

      final amount = double.tryParse(_amountController.text);
      if (amount == null || amount <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Montant invalide')));
        return;
      }

      setState(() => _isSubmitting = true);

      final amountCents = (amount * 100).round();
      final date = DateTime.now();

      try {
        if (_isExpense) {
          await ref
              .read(transactionRepositoryProvider)
              .addTransaction(
                debitAccountId: _selectedAccount!.id,
                creditAccountId: _selectedBank!.id,
                amountCents: amountCents,
                description: _descController.text,
                date: date,
              );
        } else {
          await ref
              .read(transactionRepositoryProvider)
              .addTransaction(
                debitAccountId: _selectedBank!.id,
                creditAccountId: _selectedAccount!.id,
                amountCents: amountCents,
                description: _descController.text,
                date: date,
              );
        }

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Opération Enregistrée')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
          setState(() => _isSubmitting = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStream);
    final configAsync = ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('NOUVELLE OPÉRATION')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TYPE TOGGLE
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('DÉPENSE (-)'),
                          selected: _isExpense,
                          selectedColor: Colors.red.withValues(alpha: 0.2),
                          onSelected: (val) {
                            setState(() {
                              _isExpense = true;
                              _selectedAccount = null;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('RECETTE (+)'),
                          selected: !_isExpense,
                          selectedColor: Colors.green.withValues(alpha: 0.2),
                          onSelected: (val) {
                            setState(() {
                              _isExpense = false;
                              _selectedAccount = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // AMOUNT (UX UPGRADE)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            labelText: 'Montant',
                            suffixText: 'DH',
                            hintText: 'ex: 250.00', // HINT
                            helperText: 'Montant en dirhams', // HELPER
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Requis' : null,
                        ),
                      ),
                      const LegalHelpIcon(contextKey: 'montant'),
                    ],
                  ),
                  // Logic Hint Text for Fonds de Travaux
                  if (!_isExpense &&
                      _selectedAccount != null &&
                      _selectedAccount!.classCode == 1)
                    configAsync.when(
                      data: (config) {
                        final fee =
                            double.tryParse(config['MONTHLY_FEE'] ?? '250') ??
                            250;
                        final percent =
                            double.tryParse(config['FUND_PERCENT'] ?? '5') ?? 5;

                        final effectivePercent = percent < 5 ? 5.0 : percent;
                        final suggested = fee * (effectivePercent / 100);

                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                          child: Text(
                            "Montant légal requis (Min 5% ou Vote ${percent.toStringAsFixed(0)}%) : ${suggested.toStringAsFixed(2)} DH",
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),

                  const SizedBox(height: 16),

                  // DESCRIPTION (UX UPGRADE)
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      labelText: 'Description / Libellé',
                      hintText: 'ex: Facture ONEE Mars', // HINT
                      helperText:
                          'Détail de l\'opération pour la traçabilité', // HELPER
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Requis' : null,
                  ),
                  const SizedBox(height: 16),

                  // ACCOUNT SELECTION
                  accountsAsync.when(
                    data: (accounts) {
                      final banks = accounts
                          .where((a) => a.classCode == 5)
                          .toList();
                      final targets = _isExpense
                          ? accounts.where((a) => a.classCode == 6).toList()
                          : accounts
                                .where(
                                  (a) => a.classCode == 7 || a.classCode == 1,
                                )
                                .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Compte Bancaire / Caisse (Trésorerie)',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              LegalHelpIcon(contextKey: 'compte'),
                            ],
                          ),
                          DropdownButtonFormField<Account>(
                            isExpanded: true,
                            initialValue: _selectedBank,
                            items: banks
                                .map(
                                  (a) => DropdownMenuItem(
                                    value: a,
                                    child: Text(a.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) =>
                                setState(() => _selectedBank = val),
                            decoration: const InputDecoration(
                              helperText:
                                  'Le compte qui envoie ou reçoit l\'argent',
                            ),
                            validator: (v) =>
                                v == null ? 'Sélectionner une banque' : null,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Text(
                                _isExpense
                                    ? 'Compte de Charge (Nature)'
                                    : 'Compte de Produit (Origine)',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const LegalHelpIcon(contextKey: 'compte'),
                            ],
                          ),
                          DropdownButtonFormField<Account>(
                            isExpanded: true,
                            initialValue: _selectedAccount,
                            items: targets
                                .map(
                                  (a) => DropdownMenuItem(
                                    value: a,
                                    child: Text(a.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) =>
                                setState(() => _selectedAccount = val),
                            decoration: InputDecoration(
                              helperText: _isExpense
                                  ? 'La raison de la dépense'
                                  : 'La source du revenu',
                            ),
                            validator: (v) =>
                                v == null ? 'Sélectionner un compte' : null,
                          ),
                        ],
                      );
                    },
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Erreur chargement comptes: $e'),
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFFD4AF37), // Gold
                      foregroundColor: Colors.black,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('ENREGISTRER'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
