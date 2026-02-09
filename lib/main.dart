import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme.dart';
import 'services/startup/startup_check_service.dart';

void main() {
  runApp(const ProviderScope(child: AmandierApp()));
}

class AmandierApp extends StatelessWidget {
  const AmandierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amandier Manager V3',
      theme: AppTheme.lightTheme,
      home: const StartupCheckService(),
      debugShowCheckedModeBanner: false,
    );
  }
}
