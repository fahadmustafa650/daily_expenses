import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expenses",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20.0),
            onPressed: () {},
          ),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
