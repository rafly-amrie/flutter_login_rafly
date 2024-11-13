import 'package:flutter/material.dart';

class HomeProv with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Notify all listeners that the value has changed
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}
