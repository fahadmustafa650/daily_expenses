import 'package:bloc_database_app/models/expenses.dart';
import 'package:flutter/material.dart';

class CommonMethods {
  //-------------------------------------------------
  static Future<void> showMyDialog(BuildContext context, Widget widget,
      [barrierDismissible = true]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext ctx) {
        return widget;
      },
    );
  }

  //-------------------------------------------------
  static int totalExpenses(List<Expenses> expensesList) {
    return expensesList.fold(0, (sum, item) => sum + (item.amount ?? 0));
  }
}
