import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PdfViewerScreen(
                    title: 'État des Cotisations',
                    buildPdf: (format) => ref.read(pdfServiceProvider).generateGlobalStatusPdf(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _ReportCard(
            title: 'Bilan Financier',
            subtitle: 'Recettes vs Dépenses par catégorie',
            icon: Icons.pie_chart,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PdfViewerScreen(
                    title: 'Bilan Financier',
                    buildPdf: (format) => ref.read(pdfServiceProvider).generateBilanPdf(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
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

class PdfViewerScreen extends StatelessWidget {
  final String title;
  final Future<Uint8List> Function(dynamic format) buildPdf;

  const PdfViewerScreen({
    super.key,
    required this.title,
    required this.buildPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PdfPreview(
        build: buildPdf,
        canChangeOrientation: false,
        canDebug: false,
      ),
    );
  }
}
