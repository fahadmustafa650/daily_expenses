import 'package:bloc/bloc.dart';
import 'package:bloc_database_app/db/expenses_db.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../models/expenses.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());
  DateTime currentSelectedTime = DateTime.now();
  //---------------------------------------------------------------------
  Future<void> fetchAllExpenses(DateTime dateTime) async {
    try {
      currentSelectedTime = dateTime;
      emit(LoadingExpensesInitial());

      final fetchedExpensesList =
          await ExpensesDatabase.instance.readAllExpenses(dateTime);

      emit(ResponsesExpensesInitial(expensesList: fetchedExpensesList));
    } catch (error) {
      emit(ErrorExpensesInitial(errorText: error.toString()));
    }
  }

  //---------------------------------------------------------------------
  Future<void> insertData(Expenses expenses) async {
    try {
      if (kDebugMode) {
        print("insertData:currentSelectedTime:$currentSelectedTime");
      }
      await ExpensesDatabase.instance.insertExpenses(expenses);
      fetchAllExpenses(currentSelectedTime);
    } catch (error) {
      emit(ErrorExpensesInitial(errorText: error.toString()));
    }
  }

  //---------------------------------------------------------------------
  Future<void> removeData(Expenses expenses) async {
    try {
      await ExpensesDatabase.instance.removeExpenses(expenses);
      fetchAllExpenses(currentSelectedTime);
    } catch (error) {
      emit(ErrorExpensesInitial(errorText: error.toString()));
    }
  }
}
