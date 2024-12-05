import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kossan/model/kamar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesProvider with ChangeNotifier {
  List<Product> _favoriteRooms = [];

  List<Product> get favoriteRooms => _favoriteRooms;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a favorite room to Firestore
  Future<void> addFavorite(Product kamar) async {
    String userId = _auth.currentUser!.uid;
    DocumentReference userRef = _firestore.collection('users').doc(userId);

    // Add to Firestore
    await userRef.collection('favorites').add({
      'roomId': kamar.id,
      'roomTitle': kamar.title,
      'roomPrice': kamar.price,
      'roomImagePath': kamar.imagePath,
    });

    _favoriteRooms.add(kamar);
    notifyListeners();
  }

  // Remove a favorite room from Firestore
  Future<void> removeFavorite(Product kamar) async {
    String userId = _auth.currentUser!.uid;
    DocumentReference userRef = _firestore.collection('users').doc(userId);

    // Remove from Firestore
    var snapshot = await userRef.collection('favorites').get();
    for (var doc in snapshot.docs) {
      if (doc['roomId'] == kamar.id) {
        await doc.reference.delete();
        break;
      }
    }

    _favoriteRooms.remove(kamar);
    notifyListeners();
  }

  // Toggle favorite status and sync with Firestore
  Future<void> toggleFavorite(Product kamar) async {
    if (_favoriteRooms.contains(kamar)) {
      await removeFavorite(kamar);
    } else {
      await addFavorite(kamar);
    }
  }

  // Fetch all favorite rooms from Firestore
  Future<void> fetchFavorites(String userId) async {
    String userId = _auth.currentUser!.uid;
    DocumentReference userRef = _firestore.collection('users').doc(userId);

    // Get all favorite rooms from Firestore
    var snapshot = await userRef.collection('favorites').get();
    _favoriteRooms = snapshot.docs.map((doc) {
      return Product(
        id: doc['roomId'],
        title: doc['roomTitle'],
        price: doc['roomPrice'],
        imagePath: doc['roomImagePath'],
        description: '',
        image: '',
      );
    }).toList();

    notifyListeners();
  }
}
