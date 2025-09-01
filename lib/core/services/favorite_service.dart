import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Add to favorites
  Future<void> addToFavorites({
    required String productId,
    required String productName,
    required String productImage,
    required int productQuantity,
    required double productPrice,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(productId)
        .set({
          'productId': productId,
          'productName': productName,
          'productImage': productImage,
          'productQuantity': productQuantity,
          'productPrice': productPrice,
          'addedAt': FieldValue.serverTimestamp(),
        });
  }

  // Remove from favorites
  Future<void> removeFromFavorites(String productId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(productId)
        .delete();
  }

  // Check if product is in favorites
  Future<bool> isFavorite(String productId) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(productId)
        .get();

    return doc.exists;
  }
}
