enum TransactionType { sale, purchase }

class TransactionModel {
  final TransactionType type;
  final DateTime date;
  final int quantity;
  final double price;

  TransactionModel({
    required this.type,
    required this.date,
    required this.quantity,
    required this.price,
  });
}
