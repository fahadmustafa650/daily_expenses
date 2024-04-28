import 'dart:isolate';
import 'package:bloc_database_app/common_widgets/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IsolateExampleScreen extends StatefulWidget {
  const IsolateExampleScreen({Key? key}) : super(key: key);

  @override
  State<IsolateExampleScreen> createState() => _IsolateExampleScreenState();
}

class _IsolateExampleScreenState extends State<IsolateExampleScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomCenteredLoader(
      isLoading: isLoading,
      progressIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/gifs/giphy.gif',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                  "Running loop from  1 to 1 Billion with and without Isolates"),
              const SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () async {
                  final receiverPort = ReceivePort();
                  await Isolate.spawn(complexTask2, receiverPort.sendPort);
                  receiverPort.listen((message) {
                    if (kDebugMode) {
                      print("value:$message");
                    }
                  });
                },
                child: Container(
                  width: 200.0,
                  height: 40.0,
                  color: Colors.red,
                  child: const Center(
                    child: Text("COmplex Task with Isolates"),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  final total = complexTask();
                  if (kDebugMode) {
                    print("total:$total");
                  }
                },
                child: Container(
                  width: 200.0,
                  height: 40.0,
                  color: Colors.red,
                  child: const Center(
                    child: Text("COmplex Task without Isolates"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  //-----------------------------------------------
  double complexTask() {
    double value = 0.0;
    for (double i = 0; i < 1000000000; i++) {
      value = i;
    }
    return value;
  }
}

//-----------------------------------------------
complexTask2(SendPort sendPort) {
  double total = 0.0;
  for (double i = 0; i < 1000000000; i++) {
    total = i;
  }
  sendPort.send(total);
}
