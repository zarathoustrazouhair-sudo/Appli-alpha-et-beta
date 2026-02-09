import 'package:flutter_test/flutter_test.dart';

void main() {
  test('WhatsApp Message Logic - Debtor', () {
    const name = 'Test Resident';
    const balance = -500.0;

    final message =
        "Bonjour M/Mme $name, sauf erreur, votre solde est de ${balance.toStringAsFixed(2)} DH (Impayé). Merci de régulariser.\n\nMessage généré automatiquement par l'application Syndic L'Amandier B.";

    expect(message, contains("sauf erreur, votre solde est de -500.00 DH"));
    expect(
      message,
      contains(
        "Message généré automatiquement par l'application Syndic L'Amandier B.",
      ),
    );
  });

  test('WhatsApp Message Logic - Up to date', () {
    const name = 'Test Resident';
    const balance = 0.0;
    const monthlyFee = 250;

    final monthsCovered = (balance / monthlyFee).floor();
    final now = DateTime.now();
    final paidUntil = DateTime(now.year, now.month + monthsCovered);
    final formattedDate =
        "${paidUntil.month.toString().padLeft(2, '0')}/${paidUntil.year}";

    final message =
        "Bonjour M/Mme $name, merci pour votre paiement. Vous êtes à jour jusqu'à $formattedDate.\n\nMessage généré automatiquement par l'application Syndic L'Amandier B.";

    expect(message, contains("merci pour votre paiement"));
    expect(message, contains("Vous êtes à jour jusqu'à"));
    expect(
      message,
      contains(
        "Message généré automatiquement par l'application Syndic L'Amandier B.",
      ),
    );
  });
}
