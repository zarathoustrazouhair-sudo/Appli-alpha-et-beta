import 'package:residence_lamandier_b/features/blog/data/post_entity.dart';

class BlogRepository {
  Future<List<PostEntity>> getPosts({required String userRole}) async {
    // STRICT SECURITY: Concierge CANNOT see the blog
    if (userRole == 'CONCIERGE') {
      throw Exception("ACCESS_DENIED: Concierge cannot access resident blog.");
    }

    // Mock Data for allowed roles
    return [
      PostEntity(
        id: '1',
        title: 'Rénovation Façade',
        content: 'Les travaux de peinture débuteront ce Lundi. Merci de libérer les balcons.',
        author: 'Syndic',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      PostEntity(
        id: '2',
        title: 'Nouveau Jardinier',
        content: 'Bienvenue à M. Ahmed qui s\'occupera désormais de nos espaces verts.',
        author: 'Adjoint',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}
