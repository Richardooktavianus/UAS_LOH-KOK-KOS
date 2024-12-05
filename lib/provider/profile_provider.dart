import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Getters for user's name and email
  String get name => _auth.currentUser?.displayName ?? '';
  String get email => _auth.currentUser?.email ?? '';

  // Update user's display name and email
  Future<void> updateProfile(String name, String email, String password) async {
    try {
      User? user = _auth.currentUser;

      // Update the user's profile data (name and email)
      if (name.isNotEmpty) {
        await user?.updateDisplayName(name);
      }
      if (email.isNotEmpty) {
        await user?.updateEmail(email);
      }

      // Re-authenticate the user if email is updated
      if (password.isNotEmpty && email.isNotEmpty) {
        await user?.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: user.email!,
            password: password,
          ),
        );
      }

      // Notify listeners to update UI
      notifyListeners();
    } catch (e) {
      // Handle errors, for example, if the user doesn't have permission to change email
      print('Error updating profile: $e');
    }
  }
}

