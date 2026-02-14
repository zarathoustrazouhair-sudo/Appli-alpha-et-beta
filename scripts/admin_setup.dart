import 'dart:io';
import 'package:supabase/supabase.dart';
import 'package:dotenv/dotenv.dart';

// !! SECURITY WARNING !!
// This script is for ADMIN USE ONLY.
// It uses the SERVICE ROLE KEY which bypasses RLS.
// DO NOT include this file in the client application build.

const supabaseUrl = 'https://kxvgkjkjlswpmgqwiuft.supabase.co';

void main() async {
  print('--- AMANDIER B ADMIN SETUP ---');

  // Load environment variables
  var env = DotEnv(includePlatformEnvironment: true)..load();
  final serviceRoleKey = env['SUPABASE_SERVICE_ROLE_KEY'];

  if (serviceRoleKey == null || serviceRoleKey.isEmpty) {
    print('❌ ERROR: SUPABASE_SERVICE_ROLE_KEY not found in .env file.');
    print(
      'Please create a .env file with SUPABASE_SERVICE_ROLE_KEY=your_secret_key',
    );
    exit(1);
  }

  print('Connecting to Supabase...');

  final client = SupabaseClient(supabaseUrl, serviceRoleKey);

  // 1. EXECUTE SCHEMA (Optional/Simulated)
  // Since the Dart client doesn't support raw SQL execution for DDL without a specific RPC,
  // we assume the user has run `supabase/schema.sql` in the dashboard.
  print(
    'INFO: Please ensure you have executed "supabase/schema.sql" in the Supabase SQL Editor.',
  );

  // 2. SEED DATA (Users & Profiles)
  print('Seeding initial data...');

  try {
    // Creating users via Auth Admin API is strictly server-side.
    // The dart `supabase` package supports auth admin via `client.auth.admin`.

    // Create SYNDIC
    await _createUser(
      client,
      'syndic@amandier.ma',
      'password123',
      'syndic',
      'Syndic',
      'Amandier',
    );

    // Create ADJOINT
    await _createUser(
      client,
      'adjoint@amandier.ma',
      'password123',
      'adjoint',
      'Adjoint',
      'Chef',
    );

    // Create CONCIERGE
    await _createUser(
      client,
      'concierge@amandier.ma',
      'password123',
      'concierge',
      'Concierge',
      'Gardien',
    );

    // Create 15 RESIDENTS
    for (int i = 1; i <= 15; i++) {
      await _createUser(
        client,
        'apt$i@amandier.ma',
        'password123',
        'resident',
        'Resident',
        'Apt $i',
        floor: (i - 1) ~/ 5 + 1,
        apt: i,
      );
    }

    print('SUCCESS: Data seeding complete.');
  } catch (e) {
    print('ERROR during seeding: $e');
  }
}

Future<void> _createUser(
  SupabaseClient client,
  String email,
  String password,
  String role,
  String firstName,
  String lastName, {
  int? floor,
  int? apt,
}) async {
  try {
    // 1. Create Auth User
    final authResponse = await client.auth.admin.createUser(
      AdminUserAttributes(
        email: email,
        password: password,
        emailConfirmed: true,
      ),
    );

    final userId = authResponse.user?.id;
    if (userId == null) throw Exception("Failed to create user $email");

    // 2. Create Profile
    await client.from('profiles').insert({
      'id': userId,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'floor': floor,
      'apartment_number': apt,
    });

    print('Created user: $email ($role)');
  } catch (e) {
    // Ignore "User already registered" errors for idempotency
    if (e.toString().contains('already registered')) {
      print('User $email already exists. Skipping.');
    } else {
      print('Failed to create $email: $e');
    }
  }
}
