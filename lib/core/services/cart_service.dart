import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addToCart({
    required String productId,
    required String productName,
    required String productImage,
    required double productPrice,
    required int productQuantity,
    int selectedQuantity = 1,
  }) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final cartItemRef = firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(productId);

    final cartData = {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'selectedQuantity': selectedQuantity,
      'totalPrice': productPrice * selectedQuantity,
      'addedAt': FieldValue.serverTimestamp(),
    };

    await cartItemRef.set(cartData);

    print('&&Product $productName added to cart for user ${user.uid}');
  }

  // to remove data from cart
  Future<void> removeFromCart(String productId) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final cartItemRef = firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(productId);

    await cartItemRef.delete();

    print('&&Product $productId removed from cart for user ${user.uid}');
  }
}
