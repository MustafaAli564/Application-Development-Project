import 'package:flutter/material.dart';

// class QtyProvider extends ChangeNotifier {
//   int _currentNumber = 1;
//   List<double> _baseIngredientAmount = [];
//   int get currentNumber => _currentNumber;
//   void setBaseIngredientAmounts(List<double> amounts) {
//     _baseIngredientAmount = amounts;
//     notifyListeners();
//   }

//   List<String> get updateIngredientAmount {
//     return _baseIngredientAmount
//         .map<String>((amount) => (amount * _currentNumber).toStringAsFixed(1))
//         .toList();
//   }

//   void incQty() {
//     _currentNumber++;
//     notifyListeners();
//   }

//   void decQty() {
//     if (_currentNumber > 1) {
//       _currentNumber--;
//       notifyListeners();
//     }
//   }
// }

class QtyProvider with ChangeNotifier {
  int _currentNumber = 1;
  List<double> _baseAmounts = [];

  int get currentNumber => _currentNumber;

  List<double> get updateIngredientAmount => _baseAmounts
      .map((amount) => amount * _currentNumber)
      .toList();

  void incQty() {
    _currentNumber++;
    notifyListeners();
  }

  void decQty() {
    if (_currentNumber > 1) {
      _currentNumber--;
      notifyListeners();
    }
  }

  void setBaseIngredientAmounts(List<double> base) {
    _baseAmounts = base;
    notifyListeners();
  }
}

