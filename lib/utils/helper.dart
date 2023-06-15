import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message, Color color) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color,
    duration: const Duration(seconds: 2),
  ).show(context);
}
