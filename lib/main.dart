import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:residence_lamandier_b/core/design/app_theme.dart';
import 'package:residence_lamandier_b/core/router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Résidence L\'Amandier B',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.luxuryTheme,
      routerConfig: router,
    );
  }
}
