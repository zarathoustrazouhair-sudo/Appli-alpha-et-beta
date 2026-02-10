import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('À Propos')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Icon(Icons.security, size: 80, color: AppTheme.accentColor),
              const SizedBox(height: 24),

              Text(
                "L'ARCHITECTE DES OMBRES",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Serif',
                  letterSpacing: 2.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Conçu pour la Résidence L'Amandier B.\nVersion Prestige 2.0.\n\nOptimisation. Sécurité. Transparence.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, height: 1.5),
                ),
              ),

              const SizedBox(height: 60),

              const Divider(
                color: AppTheme.accentColor,
                indent: 100,
                endIndent: 100,
              ),
              const SizedBox(height: 16),

              const Text(
                "© 2026 Zouhair",
                style: TextStyle(color: Colors.white30, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
