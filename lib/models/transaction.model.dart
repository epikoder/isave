enum TransactionSource { card, bank }

enum TransactionType { credit, debit }

class Transaction {
  Transaction({
    required this.amount,
    required this.source,
    required this.time,
    this.type = TransactionType.credit,
  });
  final int amount;
  final DateTime time;
  final TransactionSource source;
  final TransactionType type;
}
