import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/resident.dart';
import 'residents_controller.dart';

class AddResidentModal extends ConsumerStatefulWidget {
  const AddResidentModal({super.key});

  @override
  ConsumerState<AddResidentModal> createState() => _AddResidentModalState();
}

class _AddResidentModalState extends ConsumerState<AddResidentModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _buildingController = TextEditingController();
  final _apartmentController = TextEditingController();
  DateTime _startDate = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _buildingController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final resident = Resident(
        id: 0, // Drift auto-increments
        name: _nameController.text,
        phone: _phoneController.text,
        building: _buildingController.text,
        apartment: _apartmentController.text,
        startDate: _startDate,
      );

      await ref.read(residentsListProvider.notifier).addResident(resident);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                'Nouveau Résident',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom Complet'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Téléphone'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _buildingController,
                      decoration: const InputDecoration(labelText: 'Immeuble'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Requis' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _apartmentController,
                      decoration: const InputDecoration(
                        labelText: 'Appartement',
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Requis' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Date de début'),
                subtitle: Text(_startDate.toString().split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _startDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _submit, child: const Text('Ajouter')),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
