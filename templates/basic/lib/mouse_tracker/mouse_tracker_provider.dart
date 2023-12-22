import 'package:flutter/material.dart';

class MouseTrackerProvider extends ChangeNotifier {
  double get xPosition => _xPosition;
  double get yPosition => _yPosition;

  double _xPosition = 0;
  double _yPosition = 0;

  void setCoordinates(double x, double y) {
    _xPosition = x;
    _yPosition = y;
    notifyListeners();
  }
}
