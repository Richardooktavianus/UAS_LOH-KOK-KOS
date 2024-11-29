import 'package:flutter/foundation.dart';
import 'package:kossan/model/kamar.dart';

class KamarProvider with ChangeNotifier {
  late Product _product;

  Product get product => _product;

  void setProduct(Product product) {
    _product = product;
    notifyListeners();
  }
}
