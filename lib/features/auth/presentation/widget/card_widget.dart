import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/cart_service.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/add_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class CardWidget extends ConsumerWidget {
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final int productQuantity;

  const CardWidget({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 248.51.h,
      width: 173.32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Color(0xffE2E2E2)),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push(
              Path.productDetails,
              extra: {
                'productId': productId,
                'productName': productName,
                'productImage': productImage,
                'productPrice': productPrice,
                'productQuantity': productQuantity,
              },
            );
          },

          splashColor: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25.r),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 33.39.w,
                    vertical: 23.0.h,
                  ),
                  child: Container(
                    height: 79.43.h,
                    width: 99.89.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(productImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                    // child: Image.asset(
                    //   'assets/images/item/pasta.png',
                    //   fit: BoxFit.contain,
                    //   height: 79.43.h,
                    //   width: 99.89.w,
                    // ),
                  ),
                ),
                TextWidget(
                  title: productName,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff181725),
                  letterSpacing: 0.1,
                ),
                TextWidget(
                  title: '${productQuantity}pcs, Priceg',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff7C7C7C),
                  letterSpacing: 0.1,
                ),
                SizedBox(height: 18.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: '\$${productPrice.toStringAsFixed(2)}',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff181725),
                      letterSpacing: 0.1,
                      height: 1.2,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AddButtonWidget(
                        onTap: () async {
                          final selectedQuantity = ref.watch(
                            selectedQuantityProvider,
                          );
                          try {
                            await CartService().addToCart(
                              productId: productId,
                              productName: productName,
                              productImage: productImage,
                              productPrice: productPrice,
                              productQuantity: productQuantity,
                              selectedQuantity: selectedQuantity,
                            );
                            CustomSnackBar.show(
                              context,
                              '$productName added to basket',
                            );
                            context.go(Path.cart);
                          } catch (e) {
                            CustomSnackBar.show(
                              context,
                              'Failed to add $productName to basket',
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
