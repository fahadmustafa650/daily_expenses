part of 'expenses_cubit.dart';

@immutable
abstract class ExpensesState {}

final class ExpensesInitial extends ExpensesState {}

final class LoadingExpensesInitial extends ExpensesState {}

final class ErrorExpensesInitial extends ExpensesState {
  final String errorText;
  ErrorExpensesInitial({required this.errorText});
}

final class ResponsesExpensesInitial extends ExpensesState {
  final List<Expenses> expensesList;
  ResponsesExpensesInitial({
    required this.expensesList,
  });
}
