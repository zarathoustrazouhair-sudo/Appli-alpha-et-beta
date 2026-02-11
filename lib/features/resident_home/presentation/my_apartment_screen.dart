import 'package:flutter/material.dart';

class MyApartmentScreen extends StatelessWidget {
  const MyApartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Appartement'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeaderWidget(),
              SizedBox(height: 20),
              _SOSButtonWidget(),
              SizedBox(height: 20),
              _BlogListWidget(),
            ],
          ),
        ),
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

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

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

class _SOSButtonWidget extends StatelessWidget {
  const _SOSButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.red),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

class _BlogListWidget extends StatelessWidget {
  const _BlogListWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Derniers Articles',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        // OPTIMIZATION: Replaced ListView.builder with Column + map to avoid overhead
        // of scroll machinery inside another ScrollView (SingleChildScrollView).
        ...List.generate(3, (index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.article),
              title: Text('Article Blog ${index + 1}'),
              subtitle: const Text('Résumé de l\'article...'),
            ),
          );
        }),
      ],
    );
  }
}
