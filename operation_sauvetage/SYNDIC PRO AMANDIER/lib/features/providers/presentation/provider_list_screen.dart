import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'providers_controller.dart';
import 'add_provider_modal.dart';

class ProviderListScreen extends ConsumerWidget {
  const ProviderListScreen({super.key});

  Future<void> _launchWhatsApp(String phone) async {
    // Basic normalization of phone number
    var p = phone.replaceAll(RegExp(r'\s+'), '');
    if (p.startsWith('0')) p = '+212${p.substring(1)}';

    final url = Uri.parse("https://wa.me/$p");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providersAsync = ref.watch(providersListProvider);
    // Unused: final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Carnet des Prestataires',
          style: TextStyle(color: Color(0xFFD4AF37), fontFamily: 'Serif'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const AddProviderModal(),
          );
        },
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Color(0xFF05101A)],
          ),
        ),
        child: providersAsync.when(
          data: (providers) {
            if (providers.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.engineering,
                      size: 80,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Aucun prestataire enregistré.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 100,
                bottom: 80,
                left: 16,
                right: 16,
              ),
              itemCount: providers.length,
              itemBuilder: (context, index) {
                final provider = providers[index];
                return Dismissible(
                  key: Key('provider_${provider.id}'),
                  background: Container(color: Colors.red),
                  onDismissed: (_) {
                    ref
                        .read(providersListProvider.notifier)
                        .deleteProvider(provider.id);
                  },
                  child: Card(
                    color: const Color(0xFF1A1A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Color(0xFF333333),
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF333333),
                        child: Icon(
                          _getIconForJob(provider.jobType),
                          color: const Color(0xFFD4AF37),
                        ),
                      ),
                      title: Text(
                        provider.name,
                        style: const TextStyle(
                          color: Color(0xFFE0E0E0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        provider.jobType,
                        style: const TextStyle(color: Color(0xFFAAAAAA)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.message,
                          color: Color(0xFF25D366),
                        ), // WhatsApp Green
                        onPressed: () => _launchWhatsApp(provider.phone),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
          ),
          error: (err, stack) => Center(
            child: Text(
              'Erreur: $err',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForJob(String job) {
    switch (job.toLowerCase()) {
      case 'plomberie':
        return Icons.plumbing;
      case 'électricité':
        return Icons.electrical_services;
      case 'ascenseur':
        return Icons.elevator;
      case 'jardinage':
        return Icons.park;
      case 'nettoyage':
        return Icons.cleaning_services;
      case 'sécurité':
        return Icons.security;
      case 'maçonnerie':
        return Icons.foundation;
      case 'peinture':
        return Icons.format_paint;
      default:
        return Icons.build;
    }
  }
}
