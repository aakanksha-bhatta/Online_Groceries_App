import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMinusButtonWidget extends StatelessWidget {
  final String productId;

  const AddMinusButtonWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId);

    return StreamBuilder<DocumentSnapshot>(
      stream: docRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final quantity = data['selectedQuantity'] ?? 1;

        return Row(
          children: [
            // Decrease Button
            IconButton(
              onPressed: () async {
                if (quantity > 1) {
                  await docRef.update({'selectedQuantity': quantity - 1});
                }
              },
              icon: const Icon(Icons.remove),
            ),

            // Quantity Display
            Container(
              height: 45.67.h,
              width: 45.67.w,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE2E2E2)),
                borderRadius: BorderRadius.circular(17.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Center(
                child: Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff181725),
                  ),
                ),
              ),
            ),

            // Increase Button
            IconButton(
              onPressed: () async {
                await docRef.update({'selectedQuantity': quantity + 1});
              },
              icon: const Icon(Icons.add, color: Colors.green),
            ),
          ],
        );
      },
    );
  }
}
