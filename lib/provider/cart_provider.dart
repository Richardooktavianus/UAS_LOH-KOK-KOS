import 'package:flutter/material.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/model/kamar_item.dart';


class CartProvider with ChangeNotifier {
  final List<KamarItem> _cartItems = [];

  List<KamarItem> get cartItems => _cartItems;

  void addToCart(Product product, int quantity) {
    final index = _cartItems.indexWhere((item) => item.kamar.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity += quantity;
    } else {
      _cartItems.add(KamarItem(kamar: product, quantity: quantity));
    }
    notifyListeners();
  }

  double totalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.kamar.price * item.quantity;
    }
    return total;
  }

   void removeFromCart(KamarItem kamarItem) {
    _cartItems.remove(kamarItem);
    notifyListeners();
  }
}