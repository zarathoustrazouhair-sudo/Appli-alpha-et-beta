import 'package:url_launcher/url_launcher.dart';
import '../utils/formatters.dart';

class WhatsappService {
  Future<void> sendRelance(String phone, int balance) async {
    // Sanitize phone using centralized utility
    final sanitizedPhone = Formatters.formatWhatsAppNumber(phone);

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
