import 'package:flutter/material.dart';
import 'package:kossan/model/kamar.dart';

class FavoritesProvider with ChangeNotifier {
  List<Product> _favoriteRooms = [];

  List<Product> get favoriteRooms => _favoriteRooms;

  void addFavorite(Product kamar) {
    if (!_favoriteRooms.contains(kamar)) {
      _favoriteRooms.add(kamar);
      notifyListeners();
    }
  }

  void removeFavorite(Product kamar) {
    _favoriteRooms.remove(kamar);
    notifyListeners();
  }
}
