import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/features/auth/data/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Create a Fake SupabaseClient that throws UnimplementedError if any method/getter is called.
// This confirms that validation checks happen BEFORE client usage.
class FakeSupabaseClient extends Fake implements SupabaseClient {}

void main() {
  group('AuthRepository Security Tests', () {
    late AuthRepository authRepository;
    late FakeSupabaseClient fakeClient;

    setUp(() {
      fakeClient = FakeSupabaseClient();
      authRepository = AuthRepository(fakeClient);
    });

    test('signIn throws exception for invalid email format', () async {
      expect(
        () => authRepository.signIn('invalid-email', 'password123'),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains("Format d'email invalide"),
          ),
        ),
      );
    });

    test('signIn throws exception for short password', () async {
      expect(
        () => authRepository.signIn('valid@email.com', '1234567'), // 7 chars
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains(
                  "Le mot de passe doit contenir au moins 8 caractères, une lettre et un chiffre",
                ),
          ),
        ),
      );
    });

    test('signIn throws exception for password without number', () async {
      expect(
        () => authRepository.signIn(
          'valid@email.com',
          'password',
        ), // 8 chars, no number
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains(
                  "Le mot de passe doit contenir au moins 8 caractères, une lettre et un chiffre",
                ),
          ),
        ),
      );
    });

    test('signIn throws exception for password without letter', () async {
      expect(
        () => authRepository.signIn(
          'valid@email.com',
          '12345678',
        ), // 8 chars, no letter
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains(
                  "Le mot de passe doit contenir au moins 8 caractères, une lettre et un chiffre",
                ),
          ),
        ),
      );
    });

    test(
      'signIn passes validation and attempts to use client with valid inputs',
      () async {
        // Since we provided a FakeSupabaseClient, accessing .auth will throw UnimplementedError.
        // This UnimplementedError is caught by the repository's generic catch block
        // and rethrown as "Une erreur est survenue lors de la connexion".
        // Receiving this specific error means we passed the validation checks.
        expect(
          () => authRepository.signIn('valid@email.com', 'password123'),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains(
                    "Une erreur est survenue lors de la connexion",
                  ),
            ),
          ),
        );
      },
    );

    test('signIn passes validation for hyphenated domain', () async {
      expect(
        () => authRepository.signIn('user@my-company.com', 'password123'),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains(
                  "Une erreur est survenue lors de la connexion",
                ),
          ),
        ),
      );
    });

    test('signIn throws exception for email with XSS attempt', () async {
      expect(
        () => authRepository.signIn(
          'user@domain.com<script>alert(1)</script>',
          'password123',
        ),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains("Format d'email invalide"),
          ),
        ),
      );
    });
  });
}
