import 'package:flutter/material.dart';
import 'package:personal_expenses/widget/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;
  const TransactionList(
    this.transactions,
    this._deleteTransaction, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constrains) {
            return Column(
              children: [
                const Text(
                  "No Transaction Found",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: transactions
                .map(
                  (tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    transaction: tx,
                    deleteTransaction: _deleteTransaction,
                  ),
                )
                .toList(),
          );
  }
}
