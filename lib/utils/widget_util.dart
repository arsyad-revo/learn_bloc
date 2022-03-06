import 'package:flutter/material.dart';

class WidgetUtil {
  snackbarAlert(String textAlert, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(textAlert),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
