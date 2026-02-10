import 'package:url_launcher/url_launcher.dart';

class WhatsappService {
  Future<void> sendRelance(String phone, int balance) async {
    // Sanitize phone: remove spaces, ensure it starts with appropriate code if needed.
    // For this context, assuming +212 is standard but users might enter 06...
    var sanitizedPhone = phone.replaceAll(' ', '').replaceAll('-', '');

    // Auto-replace leading 0 with 212 (Morocco specific context usually implied by 'DH' currency)
    if (sanitizedPhone.startsWith('0')) {
      sanitizedPhone = '212${sanitizedPhone.substring(1)}';
    }

    // Fallback if no country code (simplified logic)
    if (!sanitizedPhone.startsWith('+') && !sanitizedPhone.startsWith('212')) {
      sanitizedPhone = '212$sanitizedPhone';
    }

    final message =
        "Bonjour, sauf erreur de notre part, vous avez un solde impayé de $balance DH concernant vos frais de syndic. Merci de régulariser la situation.";
    final uri = Uri.parse(
      "whatsapp://send?phone=$sanitizedPhone&text=${Uri.encodeComponent(message)}",
    );

    // We try to launch. If whatsapp:// fails (no app), we might fallback to https://wa.me
    if (!await launchUrl(uri)) {
      // Fallback to web
      final webUri = Uri.parse(
        "https://wa.me/$sanitizedPhone?text=${Uri.encodeComponent(message)}",
      );
      if (!await launchUrl(webUri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch WhatsApp');
      }
    }
  }
}
