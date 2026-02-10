import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../transactions/data/transaction_repository.dart';
import '../../residents/presentation/residents_controller.dart';
import '../../incidents/data/incident_repository.dart';
import '../../incidents/domain/incident_model.dart';
import '../../incidents/presentation/incidents_screen.dart';
import '../../residents/presentation/resident_detail_screen.dart';
import '../../transactions/presentation/transaction_entry_screen.dart'; // For "Nouveau Reçu"
import '../../sync/data/sync_service.dart';
import '../../dashboard/presentation/global_situation_screen.dart'; // For "Imprimer État" (Global Report)

// PROVIDERS (LOCAL CALCS)
final incidentsListStreamProvider =
    StreamProvider.autoDispose<List<IncidentModel>>((ref) {
      final repo = ref.watch(incidentRepositoryProvider);
      return repo.watchIncidents();
    });

final treasuryRunwayProvider = Provider.autoDispose<String>((ref) {
  final balance = ref.watch(totalClass5Stream).valueOrNull ?? 0;
  final balanceDH = balance / 100.0;
  // Avg monthly expense assumption: ~5000 DH
  if (balanceDH <= 0) return "0 Mois";
  final months = (balanceDH / 5000).toStringAsFixed(1);
  return "$months Mois";
});

class DashboardScreenOptimized extends ConsumerWidget {
  const DashboardScreenOptimized({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(totalClass5Stream);
    final runway = ref.watch(treasuryRunwayProvider);
    final incidentsAsync = ref.watch(incidentsListStreamProvider);

    return Scaffold(
      backgroundColor: AppTheme.scaffoldColor,
      appBar: AppBar(
        title: const Text(
          'COCKPIT L\'AMANDIER B',
          style: TextStyle(
            color: AppTheme.primaryColor,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.scaffoldColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppTheme.textSubtitleColor),
            onPressed: () {
              // Manual Sync Trigger
              ref.read(syncServiceProvider).uploadResidentStatus();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Synchronisation Cloud lancée..."),
                  backgroundColor: AppTheme.surfaceColor,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. TOP CARDS (Financial Health)
              Row(
                children: [
                  Expanded(
                    child: _CockpitCard(
                      title: "SOLDE GLOBAL",
                      icon: Icons.account_balance_wallet,
                      color: AppTheme.primaryColor,
                      content: balanceAsync.when(
                        data: (cents) =>
                            "${(cents / 100).toStringAsFixed(0)} DH",
                        loading: () => "...",
                        error: (_, __) => "ERR",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _CockpitCard(
                      title: "TRÉSORERIE",
                      icon: Icons.hourglass_bottom,
                      color: AppTheme.secondaryColor,
                      content: runway, // "X.X Mois"
                      subtitle: "Survie estimée",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. REAL-TIME FEED (Incidents Stream)
              const _SectionHeader(title: "FEED TEMPS RÉEL (CLOUD)"),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const IncidentsScreen()),
                ),
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: incidentsAsync.when(
                    data: (incidents) {
                      if (incidents.isEmpty) {
                        return const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.greenAccent),
                            SizedBox(width: 12),
                            Text(
                              "R.A.S - Tout est calme.",
                              style: TextStyle(color: AppTheme.textSubtitleColor),
                            ),
                          ],
                        );
                      }
                      final last = incidents.first;
                      return Row(
                        children: [
                          Icon(
                            last.isUrgent
                                ? Icons.warning_amber
                                : Icons.info_outline,
                            color: last.isUrgent ? AppTheme.errorColor : AppTheme.primaryColor,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  last.title.toUpperCase(),
                                  style: const TextStyle(
                                    color: AppTheme.textTitleColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  last.displayName,
                                  style: const TextStyle(
                                    color: AppTheme.textSubtitleColor,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${incidents.length}",
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppTheme.primaryColor),
                    ),
                    error: (e, __) => const Row(
                      children: [
                        Icon(Icons.error_outline, color: AppTheme.errorColor),
                        SizedBox(width: 8),
                        Text(
                          "Erreur connexion Supabase",
                          style: TextStyle(color: AppTheme.errorColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. THE MATRIX (15 Apts)
              const _SectionHeader(title: "LA MATRICE (ÉTAT RÉSIDENTS)"),
              const SizedBox(height: 12),
              const _CockpitMatrix(),
              const SizedBox(height: 24),

              // 4. BOTTOM ACTIONS & RECOVERY
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TAUX DE RECOUVREMENT",
                              style: TextStyle(
                                color: AppTheme.textTitleColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Global sur l'année",
                              style: TextStyle(
                                color: AppTheme.textSubtitleColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        _RecoveryRateWidget(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text("NOUVEAU REÇU"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 4,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const TransactionEntryScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.print),
                            label: const Text("IMPRIMER ÉTAT"),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.textSubtitleColor),
                              foregroundColor: AppTheme.textSubtitleColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const GlobalSituationScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.textSubtitleColor,
        fontSize: 12,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _CockpitCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;
  final String? subtitle;

  const _CockpitCard({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.05),
            AppTheme.cardColor,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textSubtitleColor,
              fontSize: 11,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              content,
              style: const TextStyle(
                color: AppTheme.textTitleColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
              ),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CockpitMatrix extends ConsumerWidget {
  const _CockpitMatrix();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final residentsAsync = ref.watch(residentsListProvider);

    return residentsAsync.when(
      data: (residents) {
        if (residents.isEmpty) {
          return const Center(
            child: Text("Base vide.", style: TextStyle(color: AppTheme.textSubtitleColor)),
          );
        }

        // Sort by ID to ensure order 1-15
        final sorted = List.of(residents)..sort((a, b) => a.id.compareTo(b.id));

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: sorted.length,
          itemBuilder: (context, index) {
            final resident = sorted[index];
            final balanceAsync = ref.watch(residentBalanceProvider(resident));

            return balanceAsync.when(
              data: (balance) {
                final isDebt = balance < 0;

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResidentDetailScreen(resident: resident),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDebt
                          ? AppTheme.errorColor.withValues(alpha: 0.1)
                          : AppTheme.primaryColor.withValues(alpha: 0.05),
                      border: Border.all(
                        color: isDebt ? AppTheme.errorColor : AppTheme.primaryColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        resident.apartment,
                        style: TextStyle(
                          color: isDebt ? AppTheme.errorColor : AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
              loading: () => Container(
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              error: (_, __) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
      error: (_, __) => const SizedBox(),
    );
  }
}

class _RecoveryRateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30.0,
      lineWidth: 6.0,
      percent: 0.75, // Placeholder
      center: const Text(
        "75%",
        style: TextStyle(
          color: AppTheme.textTitleColor,
          fontSize: 12,
          fontWeight: FontWeight.bold
        ),
      ),
      progressColor: AppTheme.primaryColor,
      backgroundColor: Colors.white10,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
