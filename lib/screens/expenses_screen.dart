import 'package:bloc_database_app/blocs/expenses_cubit/expenses_cubit.dart';
import 'package:bloc_database_app/common_widgets/add_expenses_dialog.dart';
import 'package:bloc_database_app/db/expenses_db.dart';
import 'package:bloc_database_app/utils/common_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  BuildContext? ctx;
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ctx == null) {
        return;
      }
      ctx!.read<ExpensesCubit>().fetchAllExpenses(DateTime.now());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ExpensesDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: GestureDetector(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2015, 8),
              lastDate: DateTime(2101),
            );
            print("pickedDate:${pickedDate}");
          },
          child: Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<ExpensesCubit, ExpensesState>(
          builder: (context, state) {
            if (state is LoadingExpensesInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ErrorExpensesInitial) {
              return const Center(child: Text("Error Occured"));
            }
            if (state is ResponsesExpensesInitial) {
              return ListView.builder(
                  itemCount: state.expensesList.length,
                  // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                  // crossAxisCount: 2,
                  // mainAxisSpacing: 2,
                  // crossAxisSpacing: 2,

                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        // await Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => NoteDetailPage(noteId: note.id!),
                        // ));

                        // refreshExpenses();
                      },
                      title: Text("${state.expensesList[index].amount} Rs"),
                      subtitle: Text(DateFormat('yyyy-MM-dd')
                          .format(state.expensesList[index].createdTime!)),
                    );
                  });
            }
            // print("state:${state.runtimeType}");
            return Container(
              child: Text("Empty"),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            CommonMethods.showMyDialog(context, AddExpensesDialog(
              afterSubmit: () {
                // refreshExpenses();
                context
                    .read<ExpensesCubit>()
                    .fetchAllExpenses(selectedDate ?? DateTime.now());
                Navigator.pop(context);
              },
            ));

            // refreshExpenses();
          }),
    ));
  }

  //---------------------------------------------------------
  Widget buildExpenses(ResponsesExpensesInitial state) => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        state.expensesList.length,
        (index) {
          //final note = expenses[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                // await Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => NoteDetailPage(noteId: note.id!),
                // ));

                // refreshExpenses();
              },
              child: Container(
                child: Text("expenses: ${state.expensesList[index].amount}"),
              ),
            ),
          );
        },
      ));
}
