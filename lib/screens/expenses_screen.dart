import 'package:bloc_database_app/blocs/expenses_cubit/expenses_cubit.dart';
import 'package:bloc_database_app/common_widgets/add_expenses_dialog.dart';
import 'package:bloc_database_app/utils/common_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

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
    // ExpensesDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () {
            _pickedDateAndFilterData(context);
          },
          child: const Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
        ),
        title: Text(
          DateFormat.yMMMM().format(selectedDate ?? DateTime.now()),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          BlocBuilder<ExpensesCubit, ExpensesState>(builder: (context, state) {
            if (state is ResponsesExpensesInitial) {
              return Text(
                "Total: ${CommonMethods.totalExpenses(state.expensesList)} Rs",
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
              );
            }
            return const SizedBox();
          }),
        ],
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
              if (state.expensesList.isEmpty) {
                return const Center(
                  child: Text("No Expenses"),
                );
              }
              return ListView.separated(
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
                    title: Text(
                      "${state.expensesList[index].amount} Rs",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('dd MMM yyyy')
                          .format(state.expensesList[index].createdTime!),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          ctx!
                              .read<ExpensesCubit>()
                              .removeData(state.expensesList[index]);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20.0,
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            }
            // print("state:${state.runtimeType}");
            return const SizedBox();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              CommonMethods.showMyDialog(
                context,
                AddExpensesDialog(
                  afterSubmit: () {
                    // refreshExpenses();
                    context
                        .read<ExpensesCubit>()
                        .fetchAllExpenses(selectedDate ?? DateTime.now());
                    Navigator.pop(context);
                  },
                ),
              );

              // refreshExpenses();
            }),
      ),
    ));
  }

  //---------------------------------------------------------
  Future<void> _pickedDateAndFilterData(BuildContext context) async {
    final pickedDate = await showMonthYearPicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    // if (kDebugMode) {
    //   print("pickedDate:${pickedDate}");
    // }
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        context.read<ExpensesCubit>().fetchAllExpenses(pickedDate);
      });
    }
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
              child: Text("expenses: ${state.expensesList[index].amount}"),
            ),
          );
        },
      ));
}
