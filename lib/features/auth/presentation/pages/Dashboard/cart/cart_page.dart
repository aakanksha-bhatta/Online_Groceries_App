import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
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
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final List<Map<String, dynamic>> checkoutOptions = [
    {'title': 'Delivery', 'value': 'Selected Method'},
    {'title': 'Payment', 'value': ''},
    {'title': 'Promo code', 'value': 'Pick discount'},
    {'title': 'Total Cost', 'value': '\$0.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          final docs = snapshot.data!.docs;
          final products = docs.map((doc) {
            final data = doc.data()! as Map<String, dynamic>;
            return Product.fromJson(data);
          }).toList();

          double totalCost = products.fold(
            0,
            (sum, item) => sum + (item.productPrice * (item.selectedQuantity)),
          );

          checkoutOptions[3]['value'] = '\$${totalCost.toStringAsFixed(2)}';

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55.82, bottom: 20),
                child: Center(
                  child: TextWidget(
                    title: 'My Cart',
                    letterSpacing: 0,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff181725),
                  ),
                ),
              ),

              const Divider(color: Color(0xffE2E2E2), thickness: 1),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          product.productImage,
                          height: 60.h,
                          width: 60.w,
                        ),
                        title: TextWidget(
                          title: product.productName,
                          letterSpacing: 0,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff181725),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: '${product.productQuantity}kg, Price',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: const Color(0xff7C7C7C),
                            ),
                            AddMinusButtonWidget(productId: product.productId),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                await CartService().removeFromCart(
                                  product.productId,
                                );
                                CustomSnackBar.show(
                                  context,
                                  'Product removed from cart',
                                );
                              },
                              child: Icon(
                                Icons.close,
                                color: const Color(0xff7C7C7C),
                                size: 16.sp,
                              ),
                            ),
                            TextWidget(
                              title: '\$${product.productPrice}',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff181725),
                              letterSpacing: 0,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const Divider(color: Color(0xffE2E2E2), thickness: 1),
                  ),
                ),
              ),

              // Checkout Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20.5),
                child: CustomButtonWidget(
                  buttonName: 'Go to Checkout',
                  padding: EdgeInsets.only(left: 112),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        ),
                      ),
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          builder: (context, scrollController) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        title: 'Checkout',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff181725),
                                        letterSpacing: 0,
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 1),
                                  Expanded(
                                    child: ListView.separated(
                                      controller: scrollController,
                                      itemCount: checkoutOptions.length,
                                      itemBuilder: (context, index) {
                                        final item = checkoutOptions[index];
                                        return ListTile(
                                          title: TextWidget(
                                            title: item['title'],
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff7C7C7C),
                                            letterSpacing: 0,
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextWidget(
                                                title: item['value'],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff181725),
                                                letterSpacing: 0,
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (_, __) =>
                                          const Divider(),
                                    ),
                                  ),
                                  TextWidget(
                                    title:
                                        'By placing an order you agree to our ',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    spans: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Handle T&C click
                                            debugPrint(
                                              'Terms and Conditions tapped',
                                            );
                                          },
                                      ),
                                    ],
                                    letterSpacing: 0,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 25.0,
                                    ),
                                    child: CustomButtonWidget(
                                      buttonName: 'Place Order',
                                      padding: EdgeInsets.only(left: 120),
                                      onPressed: () {
                                        context.go(Path.order);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
