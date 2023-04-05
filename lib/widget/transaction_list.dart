import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

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
        : ListView.builder(
            itemBuilder: (context, index) => Card(
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
                        '${transactions[index].amount}/-',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: const TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  DateFormat().format(
                    transactions[index].date,
                  ),
                ),
                trailing: MediaQuery.of(context).size.width > 460
                    ? TextButton.icon(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTransaction(
                            transactions[index].id,
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
                        onPressed: () => _deleteTransaction(
                          transactions[index].id,
                        ),
                      ),
              ),
            ),
            itemCount: transactions.length,
          );
  }
}
