import 'package:flutter/material.dart';

class LegalHelpIcon extends StatelessWidget {
  final String contextKey;

  const LegalHelpIcon({super.key, required this.contextKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showHelpSheet(context),
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: const Icon(Icons.question_mark, size: 14, color: Colors.grey),
      ),
    );
  }

  void _showHelpSheet(BuildContext context) {
    final info = _getLegalInfo(contextKey);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.gavel, color: Color(0xFFD4AF37)),
                  SizedBox(width: 10),
                  Text(
                    "ASSISTANCE JURIDIQUE & TECHNIQUE",
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSection("DÉFINITION", info['def']!),
              _buildSection("SOURCE LÉGALE", info['law']!, isItalic: true),
              if (info['ex'] != null) _buildSection("EXEMPLE", info['ex']!),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, String content, {bool isItalic = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _getLegalInfo(String key) {
    switch (key) {
      case 'tantiemes':
        return {
          'def': "La quote-part de copropriété (ex: 85/10000).",
          'law': "Obligatoire pour le calcul des charges (Art 10 Loi 18-00).",
          'ex': "Entrez 85 pour un appartement de 85m² (selon règlement).",
        };
      case 'budget':
        return {
          'def':
              "Le montant total annuel voté en AG pour les charges courantes.",
          'law': "Art 24 Loi 18-00.",
          'ex': "Ne pas inclure le fonds de travaux ici.",
        };
      case 'cin':
        return {
          'def': "Numéro de Carte Nationale d'Identité.",
          'law': "Requis pour la déclaration CNSS et le contrat de travail.",
          'ex': "Erreur = Risque Prud'hommes.",
        };
      case 'montant':
        return {
          'def': "Somme exacte de la transaction.",
          'law': "Tout mouvement doit être justifié (Décret 2.23.700).",
          'ex': "Entrez le montant TTC de la facture.",
        };
      case 'compte':
        return {
          'def': "Classification comptable de l'opération.",
          'law': "Plan Comptable - Décret 2.23.700.",
          'ex': "601 pour Eau, 102 pour Fonds Travaux.",
        };
      default:
        return {
          'def': "Information requise pour la gestion.",
          'law': "Loi 18-00 / 43-20.",
          'ex': "Vérifiez vos documents.",
        };
    }
  }
}
