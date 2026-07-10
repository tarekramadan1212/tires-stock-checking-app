import 'package:flutter/material.dart';
import '../../core/utilities/constants/app_colors.dart';
import '../../data/tires/stock_models/tires_model.dart';
import '../../data/tires/stock_models/transaction_model.dart';



class TransactionHistoryScreen extends StatelessWidget {
  final TireModel tire;
  final List<TransactionModel> transactions = [
    TransactionModel(type: TransactionType.purchase, date: DateTime.now(), quantity: 64, price: 99.5),
    TransactionModel(type: TransactionType.sale, date: DateTime.now(), quantity: 4, price: 107.5),
    TransactionModel(type: TransactionType.sale, date: DateTime.now(), quantity: 4, price: 99.5),
    TransactionModel(type: TransactionType.sale, date: DateTime.now(), quantity: 5, price: 133),
  ];
  TransactionHistoryScreen({
    super.key,
    required this.tire,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${tire.size} ${tire.brand} History'),
      ),
      body: transactions.isEmpty
          ? const Center(child: Text('No transactions found.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isSale = transaction.type == TransactionType.sale;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: isSale
                        ? AppColors.secondaryColor.withValues(alpha: 0.1)
                        : AppColors.success.withValues(alpha: 0.1),
                    child: Icon(
                      isSale ? Icons.remove_circle_outline : Icons.add_circle_outline,
                      color: isSale ? AppColors.secondaryColor : AppColors.success,
                    ),
                  ),
                  title: Text(
                    isSale ? 'Sale' : 'Purchase',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Date: ${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isSale ? "-" : "+"}${transaction.quantity} pcs',
                        style: TextStyle(
                          color: isSale ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${transaction.price.toStringAsFixed(2)} BD',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
