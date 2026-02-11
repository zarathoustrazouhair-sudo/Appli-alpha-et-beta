import 'package:flutter/material.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';
import 'package:residence_lamandier_b/core/theme/widgets/luxury_card.dart';
import 'package:residence_lamandier_b/features/blog/data/post_entity.dart';

class BlogFeedScreen extends StatelessWidget {
  const BlogFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<PostEntity> posts = [
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

    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: LuxuryCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Placeholder (16:9)
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title.toUpperCase(),
                          style: const TextStyle(
                            color: AppTheme.gold,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.content,
                          style: const TextStyle(
                            color: AppTheme.offWhite,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              post.author,
                              style: TextStyle(
                                color: AppTheme.gold.withOpacity(0.7),
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "${post.createdAt.day}/${post.createdAt.month} ${post.createdAt.hour}h",
                              style: TextStyle(
                                color: AppTheme.offWhite.withOpacity(0.5),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // New Post Action
        },
        backgroundColor: AppTheme.gold,
        child: const Icon(Icons.add, color: AppTheme.darkNavy),
      ),
    );
  }
}
