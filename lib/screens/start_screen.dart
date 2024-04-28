import 'package:bloc_database_app/screens/expenses_screen.dart';
import 'package:bloc_database_app/screens/isolates_example_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpensesScreen()),
                  );
                  // Get.to(() => MainScreen());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: const Center(
                  child: Text(
                    "Expenses Screen",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IsolateExampleScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlue),
                ),
                child: const Center(
                  child: Text(
                    "Isolate Example",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
