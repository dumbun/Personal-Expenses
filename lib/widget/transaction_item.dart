import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(
      {super.key, required this.transaction, required this.deleteTransaction});
  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
              child: Text(
                '${transaction.amount}/-',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat().format(
            transaction.date,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteTransaction(
                    transaction.id,
                  );
                },
                label: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                  size: 35,
                ),
                onPressed: () => deleteTransaction(
                  transaction.id,
                ),
              ),
      ),
    );
  }
}
