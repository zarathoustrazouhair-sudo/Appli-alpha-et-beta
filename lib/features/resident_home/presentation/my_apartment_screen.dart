import 'package:flutter/material.dart';

class MyApartmentScreen extends StatelessWidget {
  const MyApartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Appartement'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverToBoxAdapter(
              child: ApartmentHeader(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: SOSButton(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: BlogListTitle(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const BlogList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to incident report
        },
        label: const Text('Signaler Incident'),
        icon: const Icon(Icons.report_problem),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

class ApartmentHeader extends StatelessWidget {
  const ApartmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Bonjour M. Résident',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Solde à payer',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Text(
              '0.00 MAD',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SOSButton extends StatelessWidget {
  const SOSButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.chevron_right, color: Colors.red),
          SizedBox(width: 10),
          Text(
            'GLISSER POUR SOS',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BlogListTitle extends StatelessWidget {
  const BlogListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Derniers Articles',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class BlogList extends StatelessWidget {
  const BlogList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.article),
                title: Text('Article Blog ${index + 1}'),
                subtitle: const Text('Résumé de l\'article...'),
              ),
            );
          },
          childCount: 3,
        ),
      ),
    );
  }
}
