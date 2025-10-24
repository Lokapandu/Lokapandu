import 'package:flutter/material.dart';

SnackBar snackbar(String text, {Color? backgroundColor}) {
  return SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 2),
    backgroundColor: backgroundColor,
  );
}
