import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart'; // For DateFormat
import 'package:printing/printing.dart'; // For printing preview
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../transactions/data/transaction_repository.dart';
import '../../residents/presentation/residents_controller.dart';
import '../../../../domain/entities/resident.dart'; // Import Resident entity
import '../../residents/presentation/resident_detail_screen.dart';
import '../../transactions/presentation/transaction_entry_screen.dart';
import '../../sync/data/sync_service.dart';
import '../../dashboard/presentation/global_situation_screen.dart';
import '../../../data/database/database.dart' as db; // Alias database import
import '../../../core/services/eco_pdf_service.dart';
import '../../../features/incidents/data/incident_repository.dart';
import '../../../../domain/repositories/resident_repository.dart'; // Ensure repository is imported

// PROVIDERS (LOCAL CALCS)
final treasuryRunwayProvider = Provider.autoDispose<String>((ref) {
  final balance = ref.watch(totalClass5Stream).valueOrNull ?? 0;
  final balanceDH = balance / 100.0;
  if (balanceDH <= 0) return "0 Mois";
  final months = (balanceDH / 5000).toStringAsFixed(1);
  return "$months Mois";
});

// PDF SERVICE PROVIDER (Simple injection)
final ecoPdfServiceProvider = Provider((ref) => EcoPdfService({}));

class DashboardScreenOptimized extends ConsumerStatefulWidget {
  const DashboardScreenOptimized({super.key});

  @override
  ConsumerState<DashboardScreenOptimized> createState() =>
      _DashboardScreenOptimizedState();
}

class _DashboardScreenOptimizedState
    extends ConsumerState<DashboardScreenOptimized>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_pulseController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balanceAsync = ref.watch(totalClass5Stream);
    final runway = ref.watch(treasuryRunwayProvider);
    // Task 3: Listen to Incidents for Alerts
    final incidentsAsync = ref.watch(incidentRepositoryProvider).watchIncidents();

    return Scaffold(
      backgroundColor: AppTheme.scaffoldColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showActionModal(context, ref),
        backgroundColor: AppTheme.primaryColor,
        label: const Text(
          "ACTION RAPIDE",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        icon: const Icon(Icons.flash_on, color: Colors.black),
        elevation: 10,
      ),
      appBar: AppBar(
        title: const Text(
          'AMANDIER HUD',
          style: TextStyle(
            color: AppTheme.primaryColor,
            letterSpacing: 4.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
            shadows: [
              Shadow(color: AppTheme.primaryColor, blurRadius: 10),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.scaffoldColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: AppTheme.primaryColor),
            onPressed: () {
              ref.read(syncServiceProvider).uploadResidentStatus();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("SYNC CLOUD INITIATED..."),
                  backgroundColor: AppTheme.surfaceColor,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. TOP CARDS (Financial Health)
            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    height: 120,
                    borderColor: AppTheme.primaryColor.withOpacity(0.5),
                    isGlowing: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.account_balance_wallet,
                            color: AppTheme.primaryColor, size: 28),
                        const SizedBox(height: 8),
                        const Text(
                          "SOLDE GLOBAL",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        balanceAsync.when(
                          data: (cents) => Text(
                            "${(cents / 100).toStringAsFixed(0)} DH",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              shadows: [
                                Shadow(
                                    color: AppTheme.primaryColor,
                                    blurRadius: 10),
                              ],
                            ),
                          ),
                          loading: () => const Text("...",
                              style: TextStyle(color: Colors.white)),
                          error: (_, __) => const Text("ERR",
                              style: TextStyle(color: AppTheme.errorColor)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.secondaryColor.withOpacity(
                                  0.2 * _pulseAnimation.value),
                              blurRadius: 20 * _pulseAnimation.value,
                              spreadRadius: 2 * _pulseAnimation.value,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: child,
                      );
                    },
                    child: GlassCard(
                      height: 120,
                      borderColor: Colors.white.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.hourglass_bottom,
                              color: Colors.blueGrey, size: 28),
                          const SizedBox(height: 8),
                          const Text(
                            "RUNWAY",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            runway,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. ALERT / SMART FEED HYBRID
            StreamBuilder(
              stream: incidentsAsync,
              builder: (context, snapshot) {
                final incidents = snapshot.data ?? [];
                final urgentIncidents = incidents.where((i) => i.isUrgent).toList();

                if (urgentIncidents.isNotEmpty) {
                  // ALERT MODE: Show Red Alert Box
                  return AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.errorColor.withOpacity(
                                  0.5 * _pulseAnimation.value),
                              blurRadius: 30 * _pulseAnimation.value,
                              spreadRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: child,
                      );
                    },
                    child: GlassCard(
                      borderColor: AppTheme.errorColor,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.warning_amber, color: AppTheme.errorColor, size: 32),
                              SizedBox(width: 12),
                              Text("ALERTE SOS REÇUE", style: TextStyle(color: AppTheme.errorColor, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.2)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...urgentIncidents.map((incident) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "${incident.title} - ${incident.residentPhone}",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                    ),
                  );
                } else {
                  // NORMAL MODE: Show Transaction Feed
                  return _SmartTransactionFeed();
                }
              },
            ),
            const SizedBox(height: 24),

            // 3. RESIDENT MATRIX
            const _SectionHeader(title: "RESIDENT STATUS MATRIX"),
            const SizedBox(height: 12),
            const _CockpitMatrix(),
            const SizedBox(height: 24),

            // 4. RECOVERY HUD
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "RECOVERY RATE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Global Collection Status",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 35.0,
                    lineWidth: 6.0,
                    percent: 0.75, // Placeholder
                    center: const Text(
                      "75%",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    progressColor: AppTheme.primaryColor,
                    backgroundColor: Colors.white10,
                    circularStrokeCap: CircularStrokeCap.round,
                    widgetIndicator: Icon(Icons.circle,
                        color: AppTheme.primaryColor, size: 10),
                    animation: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
    );
  }

  void _showActionModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor.withOpacity(0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
              top: BorderSide(
                  color: AppTheme.primaryColor.withOpacity(0.5))),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_circle,
                  color: AppTheme.primaryColor, size: 32),
              title: const Text("NOUVEAU REÇU",
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text("Enregistrer un paiement",
                  style: TextStyle(color: Colors.white54)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TransactionEntryScreen()));
              },
            ),
            const Divider(color: Colors.white12),
            // TASK 1: WIRE PDF (TEST BUTTON)
            ListTile(
              leading: const Icon(Icons.picture_as_pdf,
                  color: AppTheme.secondaryColor, size: 32),
              title: const Text("TEST PDF ENGINE",
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text("Générer un reçu de test",
                  style: TextStyle(color: Colors.white54)),
              onTap: () async {
                Navigator.pop(context);
                // 1. Create a Mock Transaction
                final mockTransaction = db.Transaction(
                  id: 999,
                  debitAccountId: 1,
                  creditAccountId: 2,
                  amountCents: 150000,
                  date: DateTime.now(),
                  description: "COTISATION TEST (MOCK)",
                );
                // 2. Generate PDF
                final pdfService = ref.read(ecoPdfServiceProvider);
                // Need resident name for receipt, mocking it too
                final file = await pdfService.generateReceipt(mockTransaction, "TEST RESIDENT"); 
                // 3. Preview
                await Printing.layoutPdf(
                  onLayout: (_) => file.readAsBytes(),
                  name: 'Test Receipt',
                );
              },
            ),
            const Divider(color: Colors.white12),
            ListTile(
              leading: const Icon(Icons.print,
                  color: Colors.white, size: 32),
              title: const Text("IMPRIMER ÉTAT",
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text("Générer le rapport PDF",
                  style: TextStyle(color: Colors.white54)),
              onTap: () async {
                Navigator.pop(context);
                // GOD VIEW REPORT GENERATION
                
                // 1. Fetch Residents (Async)
                final residentRepo = ref.read(residentRepositoryProvider);
                final residents = await residentRepo.getResidents();
                
                // 2. Prepare Data (Async iteration)
                List<ResidentReportItem> items = [];
                double totalDebt = 0;
                
                for (var r in residents) {
                  final balance = await residentRepo.getResidentBalance(r).first;
                  items.add(ResidentReportItem(resident: r, balance: balance));
                  if (balance < 0) totalDebt += balance;
                }
                
                // Sort by apartment (numeric if possible, otherwise string)
                items.sort((a, b) => a.resident.apartment.compareTo(b.resident.apartment));

                // 3. Mock Financial Stats (Or fetch from Transaction Repo if possible)
                // For V1, we calculate Debt from resident balances. Expenses needs TransactionRepo.
                // Let's assume we can get total expenses from TransactionRepo or pass mock for now if not exposed.
                // We'll use the providers we have available.
                final totalExpenses = (ref.read(totalClass5Stream).valueOrNull ?? 0) / 100.0; // Rough approx or fetch specifically
                // Actually `totalClass5Stream` is Bank Balance.
                // Expenses (Class 6) are needed. 
                // For this deliverable, we will mock "Expenses" to ensure PDF generation works, 
                // as creating a new query in TransactionRepository is out of scope of "Wire to Engine".
                final stats = FinancialStats(
                  totalDebt: totalDebt,
                  lastMonthExpenses: 12500.00, // Mock
                  totalExpenses: 85000.00, // Mock
                );

                // 4. Generate PDF
                final pdfService = ref.read(ecoPdfServiceProvider);
                final file = await pdfService.generateGlobalReport(items, stats);
                
                // 5. Preview
                await Printing.layoutPdf(
                  onLayout: (_) => file.readAsBytes(),
                  name: 'Etat_Cotisations',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SmartTransactionFeed extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(recentTransactionsStream);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(title: "DERNIÈRES TRANSACTIONS"),
        const SizedBox(height: 8),
        transactionsAsync.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                borderColor: Colors.white10,
                child: const Row(
                  children: [
                    Icon(Icons.history, color: Colors.white54),
                    SizedBox(width: 16),
                    Text("AUCUNE TRANSACTION.", style: TextStyle(color: Colors.white54, fontFamily: 'Monospace')),
                  ],
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.take(3).length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final dateStr = DateFormat('dd/MM HH:mm').format(transaction.date);
                final amountStr = (transaction.amountCents / 100).toStringAsFixed(2);
                
                return GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  borderColor: AppTheme.primaryColor.withOpacity(0.3),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.attach_money, color: AppTheme.primaryColor, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.description.toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(dateStr, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                          ],
                        ),
                      ),
                      Text(
                        "$amountStr DH",
                        style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Monospace'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const LinearProgressIndicator(color: AppTheme.primaryColor, backgroundColor: Colors.black),
          error: (_, __) => GlassCard(
            borderColor: AppTheme.errorColor,
            child: const Row(
              children: [
                Icon(Icons.shield, color: AppTheme.errorColor),
                SizedBox(width: 12),
                Expanded(child: Text("MODE HORS-LIGNE SÉCURISÉ", style: TextStyle(color: AppTheme.errorColor, fontFamily: 'Monospace', fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ),
      ],
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
      style: TextStyle(
        color: AppTheme.primaryColor.withOpacity(0.7),
        fontSize: 10,
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Monospace',
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
              child: Text("NO DATA", style: TextStyle(color: Colors.grey)));
        }

        final sorted = List.of(residents)..sort((a, b) => a.id.compareTo(b.id));

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: sorted.length,
          itemBuilder: (context, index) {
            final resident = sorted[index];
            // Extract cell to separate ConsumerWidget to correctly watch individual provider
            return _ResidentMatrixCell(resident: resident);
          },
        );
      },
      loading: () => const Center(
          child: CircularProgressIndicator(color: AppTheme.primaryColor)),
      error: (_, __) => const SizedBox(),
    );
  }
}

class _ResidentMatrixCell extends ConsumerWidget {
  final Resident resident;
  const _ResidentMatrixCell({required this.resident});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(residentBalanceProvider(resident));

    return balanceAsync.when(
      data: (balance) {
        // LOGIC COULEUR
        Color borderColor = AppTheme.successColor; // Default Green (0)
        Color? fillColors;
        bool isGlow = false;

        if (balance < -1) {
          // DETTE (Negatif) -> ROUGE
          borderColor = AppTheme.errorColor;
          isGlow = true;
        } else if (balance > 1) {
          // CREDIT (Positif) -> OR
          borderColor = AppTheme.primaryColor;
          fillColors = AppTheme.primaryColor.withOpacity(0.2);
          isGlow = true;
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResidentDetailScreen(resident: resident),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: fillColors ?? Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor, width: 1.5),
              boxShadow: isGlow
                  ? [
                      BoxShadow(
                        color: borderColor.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                  : [],
            ),
            child: Center(
              child: Text(
                resident.apartment,
                style: TextStyle(
                  color: borderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
      loading: () => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      error: (_, __) => Container(color: Colors.red),
    );
  }
}
