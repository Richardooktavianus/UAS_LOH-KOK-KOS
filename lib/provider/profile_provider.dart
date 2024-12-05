import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _name = 'John Doe';
  String _email = 'johndoe@example.com';

  String get name => _name;
  String get email => _email;

  void updateProfile(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }
}
