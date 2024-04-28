import 'package:bloc_database_app/blocs/cubit/counter_cubit.dart';
import 'package:bloc_database_app/blocs/expenses_cubit/expenses_cubit.dart';
import 'package:bloc_database_app/screens/expenses_screen.dart';
import 'package:bloc_database_app/screens/isolates_example_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpensesCubit>(
      create: (context) => ExpensesCubit(),
      child: MaterialApp(
        localizationsDelegates: const [
          MonthYearPickerLocalizations.delegate,
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StartScreen(),
      ),
    );
  }
}
