import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/pdf_generator/pdf_service.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapports & PDF'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ReportCard(
            title: 'État Global des Cotisations',
            subtitle: 'Liste de tous les appartements avec leurs soldes',
            icon: Icons.table_chart,
            onTap: () => _handlePdfAction(
              context,
              ref,
              'Etat_Cotisations.pdf',
              () => ref.read(pdfServiceProvider).generateGlobalStatusPdf(),
            ),
          ),
          const SizedBox(height: 16),
          _ReportCard(
            title: 'Bilan Financier',
            subtitle: 'Recettes vs Dépenses par catégorie',
            icon: Icons.pie_chart,
            onTap: () => _handlePdfAction(
              context,
              ref,
              'Bilan_Financier.pdf',
              () => ref.read(pdfServiceProvider).generateBilanPdf(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePdfAction(
    BuildContext context,
    WidgetRef ref,
    String fileName,
    Future<Uint8List> Function() generatePdf,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final bytes = await generatePdf();
      if (context.mounted) Navigator.pop(context); // Close loading

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(24),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Document généré : $fileName',
                    style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('ENREGISTRER'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, foregroundColor: Colors.white),
                        onPressed: () async {
                          try {
                            await ref.read(pdfServiceProvider).savePdfToRootFolder(fileName, bytes);
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fichier sauvegardé avec succès')),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.print),
                        label: const Text('IMPRIMER'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                          ref.read(pdfServiceProvider).printOrSharePdf(fileName, bytes);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context); // Close loading
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur génération: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ReportCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
