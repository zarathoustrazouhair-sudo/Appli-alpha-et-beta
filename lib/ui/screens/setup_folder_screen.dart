import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import '../../data/repositories/settings_repo.dart';
import 'dashboard.dart';

class SetupFolderScreen extends ConsumerStatefulWidget {
  const SetupFolderScreen({super.key});

  @override
  ConsumerState<SetupFolderScreen> createState() => _SetupFolderScreenState();
}

class _SetupFolderScreenState extends ConsumerState<SetupFolderScreen> {
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickFolder() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Request permissions logic
      bool granted = false;
      if (await Permission.manageExternalStorage.request().isGranted) {
        granted = true;
      } else if (await Permission.storage.request().isGranted) {
        granted = true;
      }

      if (granted) {
        String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

        if (selectedDirectory != null) {
          final settingsRepo = ref.read(settingsRepositoryProvider);
          await settingsRepo.setRootFolderPath(selectedDirectory);

          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
            );
          }
        } else {
          setState(() {
            _error = "Aucun dossier sélectionné.";
            _loading = false;
          });
        }
      } else {
        setState(() {
          _error = "Permission refusée. Accès stockage requis.";
          _loading = false;
        });
        openAppSettings();
      }
    } catch (e) {
      setState(() {
        _error = "Erreur : $e";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuration Initiale')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.folder_shared, size: 80, color: Colors.blueGrey),
              const SizedBox(height: 32),
              const Text(
                'Bienvenue sur Amandier Manager',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Veuillez sélectionner un dossier pour sauvegarder vos documents comptables.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(_error!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                ),
              _loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _pickFolder,
                        icon: const Icon(Icons.create_new_folder),
                        label: const Text('CHOISIR LE DOSSIER RACINE'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
