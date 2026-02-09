import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/image_service.dart';
import 'expenses_controller.dart';
import '../../providers/presentation/providers_controller.dart';
import '../../../domain/entities/provider.dart'
    as entity; // Alias to avoid conflict if any

class AddExpenseModal extends ConsumerStatefulWidget {
  const AddExpenseModal({super.key});

  @override
  ConsumerState<AddExpenseModal> createState() => _AddExpenseModalState();
}

class _AddExpenseModalState extends ConsumerState<AddExpenseModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _category = 'Divers';
  DateTime _date = DateTime.now();
  String? _imagePath;
  entity.Provider? _selectedProvider;
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Eau & Électricité',
    'Nettoyage',
    'Jardinage',
    'Maintenance Ascenseur',
    'Réparations',
    'Honoraires Syndic',
    'Divers',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      final compressedPath = await ImageService().compressAndSaveImage(
        xFile.path,
      );
      setState(() {
        _imagePath = compressedPath;
      });
    }
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    if (_formKey.currentState!.validate()) {
      if (_imagePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez ajouter une photo justificative'),
          ),
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

      // Auto-generate title if empty? Or just use "Dépense - Category"
      String title = _titleController.text.trim();
      if (title.isEmpty) {
        title = _category;
        if (_selectedProvider != null) {
          title += " - ${_selectedProvider!.name}";
        }
      }

      try {
        await ref
            .read(expensesListProvider.notifier)
            .addExpense(
              title,
              amount,
              _category,
              _date,
              _imagePath!,
              providerName: _selectedProvider?.name,
              providerId: _selectedProvider?.id,
            );

        if (mounted) Navigator.pop(context);
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

  List<entity.Provider> _filterProviders(List<entity.Provider> allProviders) {
    if (_category == 'Maintenance Ascenseur') {
      final matches = allProviders
          .where((p) => p.jobType == 'Ascenseur')
          .toList();
      if (matches.isNotEmpty) return matches;
    }
    if (_category == 'Jardinage') {
      final matches = allProviders
          .where((p) => p.jobType == 'Jardinage')
          .toList();
      if (matches.isNotEmpty) return matches;
    }
    if (_category == 'Nettoyage') {
      final matches = allProviders
          .where((p) => p.jobType == 'Nettoyage')
          .toList();
      if (matches.isNotEmpty) return matches;
    }
    if (_category == 'Eau & Électricité') {
      final matches = allProviders
          .where((p) => p.jobType == 'Électricité' || p.jobType == 'Plomberie')
          .toList();
      if (matches.isNotEmpty) return matches;
    }
    // Default: Show all
    return allProviders;
  }

  @override
  Widget build(BuildContext context) {
    final providersAsync = ref.watch(providersListProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nouvelle Dépense',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Catégorie'),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _category = val!;
                    _selectedProvider =
                        null; // Reset provider when category changes
                  });
                },
              ),
              const SizedBox(height: 16),

              // Provider Dropdown (Smart Filtered)
              providersAsync.when(
                data: (providers) {
                  final filteredProviders = _filterProviders(providers);
                  return DropdownButtonFormField<entity.Provider>(
                    initialValue: _selectedProvider, // Can be null
                    decoration: const InputDecoration(
                      labelText: 'Prestataire (Optionnel)',
                    ),
                    items: [
                      const DropdownMenuItem<entity.Provider>(
                        value: null,
                        child: Text('Aucun / Autre'),
                      ),
                      ...filteredProviders.map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text('${p.name} (${p.jobType})'),
                        ),
                      ),
                    ],
                    onChanged: (val) => setState(() => _selectedProvider = val),
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('Erreur chargement prestataires: $e'),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Description (Titre)',
                  hintText: 'Ex: Facture Mars',
                ),
                validator: (v) {
                  // Optional now, we can generate it
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Montant (DH)'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Requis' : null,
              ),

              ListTile(
                title: Text('Date: ${_date.toString().split(' ')[0]}'),
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
              const SizedBox(height: 16),
              if (_imagePath != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(File(_imagePath!), height: 150),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => setState(() => _imagePath = null),
                    ),
                  ],
                )
              else
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Prendre Photo Facture'),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('ENREGISTRER'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
