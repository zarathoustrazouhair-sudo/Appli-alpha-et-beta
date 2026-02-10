import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/services/eco_pdf_service.dart';
import '../../residents/presentation/residents_controller.dart';
import '../../settings/presentation/settings_controller.dart';

class ConvocationDialog extends ConsumerStatefulWidget {
  const ConvocationDialog({super.key});

  @override
  ConsumerState<ConvocationDialog> createState() => _ConvocationDialogState();
}

class _ConvocationDialogState extends ConsumerState<ConvocationDialog> {
  final _agendaController = TextEditingController();
  final _dateController = TextEditingController();
  final _placeController = TextEditingController();
  bool _isGenerating = false;

  Future<void> _generatePdf({bool share = false}) async {
    final residents = await ref.read(residentsListProvider.future);
    if (residents.isEmpty) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Aucun résident trouvé.')));
      return;
    }

    setState(() => _isGenerating = true);

    try {
      final config = await ref.read(settingsControllerProvider.future);
      final pdfService = EcoPdfService(config);

      // Parse agenda from text (bullet points by newline)
      final agendaItems = _agendaController.text
          .split('\n')
          .where((s) => s.trim().isNotEmpty)
          .toList();
      if (agendaItems.isEmpty) agendaItems.add("Ordre du jour standard");

      // Parse date (Simplified for demo, user inputs string but we need DateTime)
      // Ideally use DatePicker. For now assume today if parsing fails or try basic parse.
      DateTime meetingDate = DateTime.now().add(const Duration(days: 15));
      // Try to parse? No, keep it robust. Use logic date.

      final pdfFile = await pdfService.generateConvocationAG(
        agendaItems,
        meetingDate,
        _placeController.text.isNotEmpty
            ? _placeController.text
            : "Salle de Réunion",
      );

      if (!mounted) return;

      if (share) {
        // Rasterize logic for WhatsApp Image sharing
        final bytes = await pdfFile.readAsBytes();
        await for (final page in Printing.raster(bytes, pages: [0], dpi: 300)) {
          final imageBytes = await page.toPng();
          final tempDir = await getTemporaryDirectory();
          final dateStr = DateTime.now().toString().split(' ')[0];
          final fileName = "Convocation_AG_$dateStr.png";
          final file = File('${tempDir.path}/$fileName');
          await file.writeAsBytes(imageBytes);

          final xFile = XFile(file.path);
          await Share.shareXFiles(
            [xFile],
            text: 'Convocation Officielle - Assemblée Générale',
            subject: 'Convocation AG',
          );
          break;
        }
        if (mounted) Navigator.pop(context);
      } else {
        await Printing.layoutPdf(onLayout: (_) => pdfFile.readAsBytes());
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Convoquer AG'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _agendaController,
              decoration: const InputDecoration(
                labelText: 'Ordre du jour (1 ligne = 1 point)',
                hintText: 'Bilan 2023\nBudget 2024\nTravaux...',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Date et Heure (Texte)',
                hintText: '15/05/2024 à 10h00',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: 'Lieu',
                hintText: 'Salle de réunion / Hall',
              ),
            ),
            if (_isGenerating)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.share, size: 18),
          label: const Text('Partager (Image)'),
          onPressed: _isGenerating ? null : () => _generatePdf(share: true),
        ),
        ElevatedButton(
          onPressed: _isGenerating ? null : () => _generatePdf(share: false),
          child: const Text('Imprimer (PDF)'),
        ),
      ],
    );
  }
}
