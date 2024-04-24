import 'package:bloc/bloc.dart';
import 'package:bloc_database_app/db/expenses_db.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../models/expenses.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());

  Future<void> fetchAllExpenses(DateTime dateTime) async {
    try {
      emit(LoadingExpensesInitial());

      final fetchedExpensesList =
          await ExpensesDatabase.instance.readAllExpenses(dateTime);

      emit(ResponsesExpensesInitial(expensesList: fetchedExpensesList));
    } catch (error) {
      emit(ErrorExpensesInitial(errorText: error.toString()));
    }
  }
}
