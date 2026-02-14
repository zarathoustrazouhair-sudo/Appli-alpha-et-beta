import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/features/blog/data/blog_repository.dart';
import 'package:residence_lamandier_b/core/router/role_guards.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FakeSupabaseClient extends Fake implements SupabaseClient {}

void main() {
  group('BlogRepository Security Tests', () {
    late BlogRepository blogRepository;
    late FakeSupabaseClient fakeClient;

    setUp(() {
      fakeClient = FakeSupabaseClient();
      blogRepository = BlogRepository(fakeClient);
    });

    test('createPost throws exception for excessively long title', () async {
      final longTitle = 'A' * 101; // 101 chars
      expect(
        () => blogRepository.createPost(
          title: longTitle,
          content: 'Valid content',
          userRole: UserRole.resident,
        ),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains("Le titre est trop long"),
          ),
        ),
      );
    });

    test('createPost throws exception for excessively long content', () async {
      final longContent = 'A' * 5001; // 5001 chars
      expect(
        () => blogRepository.createPost(
          title: 'Valid Title',
          content: longContent,
          userRole: UserRole.resident,
        ),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains("Le contenu est trop long"),
          ),
        ),
      );
    });

    test('createPost throws exception for empty title', () async {
      expect(
        () => blogRepository.createPost(
          title: '',
          content: 'Valid content',
          userRole: UserRole.resident,
        ),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains("Le titre ne peut pas être vide"),
          ),
        ),
      );
    });

    test('createPost throws exception for empty content', () async {
      expect(
        () => blogRepository.createPost(
          title: 'Valid Title',
          content: '',
          userRole: UserRole.resident,
        ),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains("Le contenu ne peut pas être vide"),
          ),
        ),
      );
    });

    test(
      'createPost proceeds (throws UnimplementedError) for valid input',
      () async {
        // This test ensures that if inputs are valid, the code proceeds to call the client
        // Since client is Fake, it throws UnimplementedError (or specific error if we mock it differently)
        // We expect UnimplementedError here, meaning validation PASSED.
        expect(
          () => blogRepository.createPost(
            title: 'Valid Title',
            content: 'Valid Content',
            userRole: UserRole.resident,
          ),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );
  });
}
