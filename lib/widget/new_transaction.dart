import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // NewTransaction({super.key});
  const NewTransaction(this.addTx, {super.key});
  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitDate() {
    final enteredTitle = _titleController.text;
    final enteredAmout = double.parse(_amountController.text);
    if (_amountController.text.isEmpty) {
      return;
    }
    if (enteredTitle.isEmpty ||
        enteredAmout <= 0 ||
        _selectedDate == null ||
        _amountController.text.isEmpty) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmout, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  void dispose() {
    _amountController;
    _titleController;
    _selectedDate;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //// INPUT FIELDS

            TextField(
              controller: _titleController,
              cursorColor: Colors.red,
              decoration: const InputDecoration(labelText: "Title"),
              onSubmitted: (value) => _submitDate(),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: _amountController,
              cursorColor: Colors.red,
              decoration: const InputDecoration(labelText: "Amount"),
              onSubmitted: (value) => _submitDate(),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            //// DATE PICKER

            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen !'
                          : 'PickedDate: ${DateFormat().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.calendar_month_rounded),
                    onPressed: () {
                      _presentDatePicker();
                    },
                    label: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //// ADD TRANSACTION BUTTON
            Platform.isIOS
                ? CupertinoButton(
                    color: Colors.blue,
                    onPressed: _submitDate,
                    child: const Text("Add Transaction"),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: _submitDate,
                    child: const Text(
                      "Add Transaction",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
