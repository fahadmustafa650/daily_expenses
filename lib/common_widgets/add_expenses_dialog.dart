import 'package:bloc_database_app/blocs/expenses_cubit/expenses_cubit.dart';
import 'package:bloc_database_app/db/expenses_db.dart';
import 'package:bloc_database_app/models/expenses.dart';
import 'package:bloc_database_app/utils/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensesDialog extends StatefulWidget {
  const AddExpensesDialog({
    super.key,
    required this.afterSubmit,
  });
  final void Function()? afterSubmit;

  @override
  State<AddExpensesDialog> createState() => _AddExpensesDialogState();
}

class _AddExpensesDialogState extends State<AddExpensesDialog> {
  DateTime? _selectedDate;

  final _amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _amountController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }
                    if (int.parse(value) <= 0) {
                      return "amount can't be less or equal to zero";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      hintText: 'Enter Amount',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await _displayDatePicker(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.grey)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(_selectedDate == null
                            ? "Click To Pick a Date"
                            : DateFormat.yMMMEd().format(_selectedDate!))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      _addExpenses(context).then((value) {
                        widget.afterSubmit!.call();
                      });
                    },
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-----------------------------------------------------------
  Future<void> _addExpenses(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final expense = Expenses(
      id: DateTime.now().millisecondsSinceEpoch,
      amount: (int.parse(_amountController.text)),
      createdTime: _selectedDate ?? DateTime.now(),
    );
    context.read<ExpensesCubit>().insertData(expense);
    // await ExpensesDatabase.instance.insertExpenses(expense);
  }

  //-----------------------------------------------------------
  Future<void> _displayDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1971, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _selectedDate = picked;
      setState(() {});
    }
  }
}
