import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/security/role_guards.dart';
import '../../data/local/database.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: UserRole.values.map((role) {
            return ElevatedButton(
              onPressed: () {
                ref.read(userRoleProvider.notifier).setRole(role);
              },
              child: Text('Login as ${role.name}'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
