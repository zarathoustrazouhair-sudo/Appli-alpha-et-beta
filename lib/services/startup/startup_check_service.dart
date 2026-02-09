import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/settings_repo.dart';
import '../../ui/screens/dashboard.dart';
import '../../ui/screens/setup_folder_screen.dart';

class StartupCheckService extends ConsumerStatefulWidget {
  const StartupCheckService({super.key});

  @override
  ConsumerState<StartupCheckService> createState() => _StartupCheckServiceState();
}

class _StartupCheckServiceState extends ConsumerState<StartupCheckService> {
  @override
  void initState() {
    super.initState();
    _checkRootFolder();
  }

  Future<void> _checkRootFolder() async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final rootPath = await settingsRepo.getRootFolderPath();

    if (mounted) {
      if (rootPath != null && rootPath.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SetupFolderScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
