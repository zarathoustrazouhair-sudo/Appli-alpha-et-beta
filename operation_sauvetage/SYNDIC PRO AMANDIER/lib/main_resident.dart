import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/resident_app/presentation/login/login_screen.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://sphxyfpgqppikdwcflet.supabase.co',
    anonKey: 'sb_publishable_IvN_jwysgRsIFImElOMRqw_IeBHvc91',
  );

  runApp(const ProviderScope(child: ResidentApp()));
}

class ResidentApp extends StatelessWidget {
  const ResidentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amandier Life', // REBRANDING
      theme: AppTheme.darkTheme,
      home: const ResidentLoginScreen(),
    );
  }
}
