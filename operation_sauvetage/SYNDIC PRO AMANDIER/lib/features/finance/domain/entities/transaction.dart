enum TransactionType { debit, credit }

class Transaction {
  final String id;
  final String residentId;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String description;

  const Transaction({
    required this.id,
    required this.residentId,
    required this.amount,
    required this.type,
    required this.date,
    required this.description,
  });
}
