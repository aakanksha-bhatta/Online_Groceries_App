import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<int> getRating(String productId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('ratings')
        .doc(productId)
        .get();

    if (doc.exists && doc.data() != null) {
      return doc.data()!['rating'] ?? 0;
    }
    return 0;
  }

  Future<void> saveRating(String productId, int rating) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('ratings')
        .doc(productId)
        .set({'rating': rating, 'updatedAt': FieldValue.serverTimestamp()});
  }
}
