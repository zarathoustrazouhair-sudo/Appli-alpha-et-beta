import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:residence_lamandier_b/core/design/app_theme.dart';
import 'package:residence_lamandier_b/features/onboarding/presentation/wizard_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Résidence L\'Amandier B',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.luxuryTheme,
      home: const WizardScreen(),
    );
  }
}
