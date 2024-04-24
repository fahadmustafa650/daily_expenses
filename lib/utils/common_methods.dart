import 'package:flutter/material.dart';

class CommonMethods {
  //-------------------------------------------------
  static Future<void> showMyDialog(BuildContext context, Widget widget,
      [barrierDismissible = true]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext ctx) {
        return widget;
      },
    );
  }
}
