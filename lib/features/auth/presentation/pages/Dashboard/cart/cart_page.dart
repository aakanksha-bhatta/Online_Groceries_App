import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/core/services/cart_service.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/add_minus_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 55.82, bottom: 20),
            child: Center(
              child: TextWidget(
                title: 'My Cart',
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff181725),
                letterSpacing: 0,
              ),
            ),
          ),

          Divider(color: Color(0xffE2E2E2), thickness: 1, height: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.27, right: 25.27),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: TextWidget(
                        title: 'No data found',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 19, 19, 19),
                        letterSpacing: 0,
                      ),
                    );
                  }
                  final docs = snapshot.data!.docs;
                  final products = docs.map((doc) {
                    final data = doc.data()! as Map<String, dynamic>;
                    return Product.fromJson(data);
                  }).toList();
                  return ListView.separated(
                    padding: EdgeInsets.only(top: 15, bottom: 25),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          product.productImage,
                          alignment: Alignment.topCenter,
                          height: 60.h,
                          width: 60.w,
                        ),
                        title: TextWidget(
                          title: product.productName,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff181725),
                          letterSpacing: 0,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: '${product.productQuantity}kg, Price',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7C7C7C),
                              letterSpacing: 0,
                            ),
                            AddMinusButtonWidget(),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                await CartService().removeFromCart(
                                  product.productId,
                                );
                                CustomSnackBar.show(
                                  context,
                                  'Product removed from basket',
                                );
                              },
                              child: Icon(
                                Icons.close,
                                color: Color(0xff7C7C7C),
                                size: 16.sp,
                              ),
                            ),
                            TextWidget(
                              title: '\$${product.productPrice}',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff181725),
                              letterSpacing: 0.1,
                            ),
                          ],
                        ),
                      );
                    },

                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Color(0xffE2E2E2), thickness: 1);
                    },
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 24.39,
              right: 25.27,
              bottom: 21.25,
              top: 5.23,
            ),
            child: CustomButtonWidget(buttonName: 'Go to Checkout'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
