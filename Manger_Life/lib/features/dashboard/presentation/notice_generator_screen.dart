import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class NoticeGeneratorScreen extends ConsumerStatefulWidget {
  const NoticeGeneratorScreen({super.key});

  @override
  ConsumerState<NoticeGeneratorScreen> createState() =>
      _NoticeGeneratorScreenState();
}

class _NoticeGeneratorScreenState extends ConsumerState<NoticeGeneratorScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final _models = ['Ascenseur', 'Coupure d\'Eau', 'Appel de Fonds', 'Autre'];
  String _selectedModel = 'Ascenseur';

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateModel();
  }

  void _updateModel() {
    final date = DateTime.now().toString().split(' ')[0];
    switch (_selectedModel) {
      case 'Ascenseur':
        _titleController.text = "AVIS - ASCENSEUR";
        _bodyController.text =
            "L'ascenseur sera à l'arrêt pour maintenance le $date.\nMerci de votre compréhension.\n\nLe Syndic.";
        break;
      case 'Coupure d\'Eau':
        _titleController.text = "COUPURE D'EAU";
        _bodyController.text =
            "Une coupure d'eau est prévue le $date en raison de travaux.\n\nLe Syndic.";
        break;
      case 'Appel de Fonds':
        _titleController.text = "APPEL DE FONDS";
        _bodyController.text =
            "Les copropriétaires sont priés de régler leurs charges avant le 5 du mois.\nMerci.\n\nLe Syndic.";
        break;
      default:
        _titleController.text = "AVIS AUX RÉSIDENTS";
        _bodyController.text = "Information importante...\n\nLe Syndic.";
    }
    setState(() {});
  }

  Future<void> _shareImage() async {
    final imageBytes = await _screenshotController.capture();
    if (imageBytes == null) return;

    final tempDir = await getTemporaryDirectory();
    final fileName = "Avis_Syndic_${DateTime.now().millisecondsSinceEpoch}.png";
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(imageBytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: _titleController.text,
      subject: 'Avis Syndic',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Générateur d\'Avis')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedModel,
              items: _models
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedModel = val);
                  _updateModel();
                }
              },
              decoration: const InputDecoration(labelText: 'Modèle'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Contenu'),
            ),

            const SizedBox(height: 24),
            const Text(
              'Aperçu (Sera partagé)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // PREVIEW WIDGET
            Screenshot(
              controller: _screenshotController,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E), // Dark Grey
                  border: Border.all(
                    color: const Color(0xFFD4AF37),
                    width: 2,
                  ), // Gold Border
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Logo Placeholder
                    const Icon(
                      Icons.apartment,
                      size: 48,
                      color: Color(0xFFD4AF37),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'SYNDIC L\'AMANDIER B',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFFD4AF37),
                      thickness: 1,
                      height: 30,
                    ),

                    Text(
                      _titleController.text.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _bodyController.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Votre confort, notre priorité.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _shareImage,
              icon: const Icon(Icons.share),
              label: const Text('GÉNÉRER IMAGE & PARTAGER (WhatsApp)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
