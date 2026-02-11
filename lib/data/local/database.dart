import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/security/role_guards.dart';

class AppDatabase {
  Future<UserRole> getUserRole() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return UserRole.syndic;
  }
}

final appDatabaseProvider = Provider((ref) => AppDatabase());

class UserRoleNotifier extends Notifier<UserRole> {
  @override
  UserRole build() => UserRole.syndic;

  void setRole(UserRole role) {
    state = role;
  }
}

final userRoleProvider = NotifierProvider<UserRoleNotifier, UserRole>(UserRoleNotifier.new);
