import 'package:aexpences/services/utilitis.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == 'expense';
    final formattedDate = DateFormat.yMMMd().format(transaction.date);

    return ListTile(
      leading: Icon(
        isExpense ? Icons.arrow_upward : Icons.arrow_downward,
        color: isExpense ? Colors.red : Colors.green,
      ),
      title: Text(globalCategories[transaction.categoryId].toString()),
      subtitle: Text("${transaction.description}\n$formattedDate"),
      isThreeLine: true,
      trailing: SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: isExpense ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
