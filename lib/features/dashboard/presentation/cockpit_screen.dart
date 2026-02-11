import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:residence_lamandier_b/core/design/app_theme.dart';
import 'package:residence_lamandier_b/features/dashboard/presentation/widgets/apartment_grid.dart';
import 'package:residence_lamandier_b/features/dashboard/presentation/widgets/charts/cashflow_curve.dart';
import 'package:residence_lamandier_b/features/dashboard/presentation/widgets/charts/recovery_disk.dart';
import 'package:residence_lamandier_b/features/dashboard/presentation/widgets/kpi_cards.dart';

class CockpitScreen extends ConsumerWidget {
  const CockpitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      appBar: AppBar(
        title: Text(
          'COCKPIT',
          style: AppTheme.luxuryTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.gold,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. KPI Cards
            const KpiCards(),
            const SizedBox(height: 24),

            // 2. Matrix
            Text(
              "STATUS RÉSIDENTS",
              style: AppTheme.luxuryTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.offWhite.withOpacity(0.7),
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            const ApartmentGrid(),
            const SizedBox(height: 24),

            // 3. Charts
             Text(
              "ANALYSE FINANCIÈRE",
              style: AppTheme.luxuryTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.offWhite.withOpacity(0.7),
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            const RecoveryDisk(),
            const SizedBox(height: 16),
            const CashflowCurve(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
