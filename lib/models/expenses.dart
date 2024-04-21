const expensesDB = 'expenses';

class ExpensesFields {
  static final List<String> values = [
    /// Add all fields
    id, amount, date
  ];
  static const String id = "_id";
  static const String amount = "amount";
  static const String date = 'date';
}

class Expenses {
  final int? id;
  final int? amount;
  final DateTime? createdTime;

  const Expenses(
      {required this.id, required this.amount, required this.createdTime});
  //---------------------------------------------
  Map<String, Object?> toJson() => {
        ExpensesFields.id: id,
        ExpensesFields.amount: amount,
        ExpensesFields.date: createdTime,
      };
  //---------------------------------------------
  static Expenses fromJson(Map<String, Object?> json) => Expenses(
        id: json[ExpensesFields.id] as int?,
        createdTime: DateTime.parse(
          json[ExpensesFields.date] as String,
        ),
        amount: json[ExpensesFields.amount] as int?,
      );
  //---------------------------------------------
  Expenses copy({
    final int? id,
    final int? amount,
    final DateTime? createdTime,
  }) =>
      Expenses(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        createdTime: createdTime ?? this.createdTime,
      );
}
