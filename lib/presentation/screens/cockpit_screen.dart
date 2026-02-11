import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/security/role_guards.dart';
import '../../data/local/database.dart';

class CockpitScreen extends ConsumerWidget {
  const CockpitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    final canEdit = RoleGuards.canEditFinance(role);

    return Scaffold(
      appBar: AppBar(title: const Text('Cockpit Syndic')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Role: ${role.name}'),
            Text('Can Edit Finance: $canEdit'),
            if (canEdit)
              ElevatedButton(onPressed: () {}, child: const Text('Edit Finance')),
          ],
        ),
      ),
    );
  }
}
