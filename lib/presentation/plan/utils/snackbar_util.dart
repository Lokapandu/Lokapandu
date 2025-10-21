import 'package:flutter/material.dart';

SnackBar snackbar(String text) {
  return SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 2),
  );
}
