import 'dart:io';
import 'dart:typed_data';

import 'package:bloc_database_app/common_widgets/loading_widget.dart';
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
      progressIndicator: Center(
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    ));
  }
}

//-------------------------------------------------------
class ResizedImageScreen extends StatelessWidget {
  final Uint8List image;
  const ResizedImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Image.memory(image),
      ),
    ));
  }
}
