import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../features/residents/domain/entities/resident.dart';
import 'residents_controller.dart';
// For residentBalanceProvider

part 'bulk_relaunch_screen.g.dart';

@riverpod
class BulkSelection extends _$BulkSelection {
  @override
  Map<int, bool> build() => {};

  void toggle(int id) {
    state = {...state, id: !(state[id] ?? false)};
  }
}

class BulkRelaunchScreen extends ConsumerWidget {
  const BulkRelaunchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is problematic because we can't easily iterate an AsyncValue list and filter by another AsyncValue (balance)
    // inside a build method efficiently.
    // Ideally, we need a provider that returns List<Debtor>.
    // For MVP Fix: Just iterate residents and show only those with debt.

    final residentsAsync = ref.watch(residentsListProvider);
    // selection is local state for now, but we can't really do bulk send easily.

    return Scaffold(
      appBar: AppBar(title: const Text('Mode Rafale (Dettes)')),
      body: residentsAsync.when(
        data: (residents) {
          if (residents.isEmpty)
            return const Center(child: Text('Aucun résident.'));

          return ListView.builder(
            itemCount: residents.length,
            itemBuilder: (context, index) {
              final resident = residents[index];
              // We need balance.
              final balanceAsync = ref.watch(residentBalanceProvider(resident));

              return balanceAsync.when(
                data: (balance) {
                  if (balance >= 0)
                    return const SizedBox.shrink(); // Hide positives

                  return Card(
                    color: Colors.red.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.warning, color: Colors.red),
                      title: Text(resident.name),
                      subtitle: Text(
                        'Dette: ${(-balance).toStringAsFixed(2)} DH',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.send, color: Colors.green),
                        onPressed: () => _sendWhatsApp(resident, balance),
                        tooltip: 'Relancer sur WhatsApp',
                      ),
                    ),
                  );
                },
                loading: () =>
                    const SizedBox.shrink(), // Don't show loading placeholders to avoid jitter
                error: (_, __) => const SizedBox.shrink(),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur: $e')),
      ),
    );
  }

  Future<void> _sendWhatsApp(Resident resident, double balance) async {
    if (resident.phone.isEmpty) return;

    var number = resident.phone.replaceAll(' ', '').replaceAll('-', '');
    if (number.startsWith('0')) number = number.substring(1);
    if (!number.startsWith('212')) number = '212$number';

    final message =
        "Bonjour M/Mme ${resident.name}, sauf erreur, votre solde est débiteur de ${(-balance).toStringAsFixed(2)} DH. Merci de régulariser pour le bon fonctionnement de la résidence.";
    final encodedMessage = Uri.encodeComponent(message);
    final uri = Uri.parse("https://wa.me/$number?text=$encodedMessage");

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Error
    }
  }
}
