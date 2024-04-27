import 'package:flutter/material.dart';

class CustomCenteredLoader extends StatelessWidget {
  final Widget child;
  final Widget progressIndicator;
  final bool? isLoading;
  const CustomCenteredLoader({
    super.key,
    required this.child,
    required this.isLoading,
    required this.progressIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: isLoading ?? false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }
}
