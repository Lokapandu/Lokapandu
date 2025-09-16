import 'package:flutter/material.dart';

class CounterNotifier extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }
}
