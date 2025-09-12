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
    required int selectedQuantity,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final cartItemRef = firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(productId);

      final cartDoc = await cartItemRef.get();

      if (cartDoc.exists) {
        final existingData = cartDoc.data()!;
        final currentQty = existingData['selectedQuantity'] ?? 0;
        final updatedQty = currentQty + selectedQuantity;

        await cartItemRef.update({
          'selectedQuantity': updatedQty,
          'totalPrice': productPrice * updatedQty,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        await cartItemRef.set({
          'productId': productId,
          'productName': productName,
          'productImage': productImage,
          'productPrice': productPrice,
          'productQuantity': productQuantity,
          'selectedQuantity': selectedQuantity,
          'totalPrice': productPrice * selectedQuantity,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      rethrow;
    }
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

  Future<void> placeOrder() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart');

    final orderRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .doc();

    final cartSnapshot = await cartRef.get();

    if (cartSnapshot.docs.isEmpty) {
      throw Exception("Cart is empty");
    }

    final orderItems = cartSnapshot.docs.map((doc) => doc.data()).toList();

    // Save order
    await orderRef.set({
      'orderId': orderRef.id,
      'createdAt': FieldValue.serverTimestamp(),
      'items': orderItems,
      'status': 'pending',
      // 'total': orderItems.fold(
      //   // 0,
      //   // (sum, item) => sum + (item['productPrice'] * item['selectedQuantity']),
      // ),
    });

    // Clear the cart
    for (final doc in cartSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
