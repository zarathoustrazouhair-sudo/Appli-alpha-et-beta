import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/currency_fmt.dart';
import '../../data/db/app_db.dart';
import '../../data/repositories/financial_repo.dart';

class ApartmentCard extends ConsumerWidget {
  final Apartment apartment;
  final VoidCallback? onTap;

  const ApartmentCard({
    super.key,
    required this.apartment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(apartmentBalanceProvider(apartment.id));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Text(
            apartment.number,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          apartment.ownerName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Cotisation: ${CurrencyFormatter.format(apartment.monthlyFee)}/mois'),
        trailing: balanceAsync.when(
          data: (balance) {
            final isLate = balance < -0.01; // Tolerance for float precision
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isLate ? 'EN RETARD' : 'À JOUR',
                  style: TextStyle(
                    fontSize: 10,
                    color: isLate ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  CurrencyFormatter.format(balance),
                  style: TextStyle(
                    fontSize: 16,
                    color: isLate ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
          loading: () => const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (e, s) => const Icon(Icons.error, color: Colors.red),
        ),
        onTap: onTap,
      ),
    );
  }
}
