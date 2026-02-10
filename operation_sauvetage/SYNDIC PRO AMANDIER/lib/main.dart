import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/navigation/main_scaffold.dart';
import 'features/settings/presentation/setup_wizard_screen.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const ProviderScope(child: SyndicProApp()));
}

class SyndicProApp extends ConsumerWidget {
  const SyndicProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check Config asynchronously
    final configAsync = ref.watch(settingsControllerProvider);

    return MaterialApp(
      title: 'Amandier Manager', // REBRANDING
      theme: AppTheme.darkTheme,
      home: configAsync.when(
        data: (config) {
          final isSetup = config['IS_SETUP_COMPLETE'] == 'true';
          return isSetup ? const MainScaffold() : const SetupWizardScreen();
        },
        loading: () => const Scaffold(
          backgroundColor: Color(0xFF121212),
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(body: Center(child: Text('Erreur: $e'))),
      ),
    );
  }
}
