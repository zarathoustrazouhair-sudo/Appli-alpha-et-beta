import 'package:flutter/material.dart';

class MyApartmentScreen extends StatelessWidget {
  const MyApartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Appartement'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildSOSButton(context),
              const SizedBox(height: 20),
              _buildBlogList(context),
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

  Widget _buildHeader(BuildContext context) {
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

  Widget _buildSOSButton(BuildContext context) {
    return Semantics(
      label: "Bouton d'urgence SOS",
      hint: "Glisser vers la droite pour activer",
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(children: const [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('ALERTE SOS ENVOYÉE - Secours en route')),
              ]),
              backgroundColor: Colors.red.shade800,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
            ),
          );
          return false; // Snap back
        },
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(Icons.notifications_active, color: Colors.white, size: 30),
        ),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Veuillez glisser pour activer SOS'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: Container(
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
          ),
        ),
      ),
    );
  }

  Widget _buildBlogList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Derniers Articles',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.article),
                title: Text('Article Blog ${index + 1}'),
                subtitle: const Text('Résumé de l\'article...'),
              ),
            );
          },
        ),
      ],
    );
  }
}
