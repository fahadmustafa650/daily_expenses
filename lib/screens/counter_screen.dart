import 'package:bloc_database_app/blocs/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  "Counter Value: ${BlocProvider.of<CounterCubit>(context).state.counterValue}",
                  style: TextStyle(fontSize: 20.0),
                );
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                    child: Center(
                      child: Icon(Icons.remove),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
