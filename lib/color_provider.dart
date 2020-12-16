import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  var _index = 0;

  var count = 10;

  List<String> _colors = [
    'red',
    'yellow',
    'blue',
  ];

  String get currentColor => _colors[_index];

  void toNextColor() {
    _index = (_index + 1) % _colors.length;
    // count++;
    print('toNextColor:$currentColor');
    notifyListeners();
  }
}
