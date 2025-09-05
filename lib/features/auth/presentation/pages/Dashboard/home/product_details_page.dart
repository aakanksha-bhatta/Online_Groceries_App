import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/cart_service.dart';
import 'package:online_groceries_app/core/services/favorite_service.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/add_minus_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class ProductDetailsPage extends ConsumerWidget {
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final int productQuantity;

  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(currentRatingProvider);
    final isNutritionDetailsVisible = ref.watch(
      nutritionDetailsVisibleProvider,
    );
    final isProductDetailsVisible = ref.watch(productDetailsVisibleProvider);

    // Watch favorite status
    final favoriteMap = ref.watch(favoriteStatusProvider);
    final isFavorite = favoriteMap[productId] ?? false;
    final favoriteNotifier = ref.read(favoriteStatusProvider.notifier);

    // Check on build
    favoriteNotifier.checkFavorite(productId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 371.44.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r),
                  ),
                  color: const Color(0xffF2F3F2),
                ),
                child: Center(
                  child: Image.asset(
                    productImage,
                    height: 199.18.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 56.93.h,
                  left: 25.01.w,
                  right: 25.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.go(Path.home);
                      },
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(Icons.file_upload_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.01, top: 30.5, right: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          title: productName,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff181725),
                          letterSpacing: 0.1,
                        ),
                        InkWell(
                          onTap: () async {
                            if (isFavorite) {
                              await FavoritesService().removeFromFavorites(
                                productId,
                              );
                              favoriteNotifier.setFavorite(productId, false);
                            } else {
                              await FavoritesService().addToFavorites(
                                productId: productId,
                                productName: productName,
                                productImage: productImage,
                                productQuantity: productQuantity,
                                productPrice: productPrice,
                              );
                              favoriteNotifier.setFavorite(productId, true);
                            }
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : const Color(0xFF7C7C7C),
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                    TextWidget(
                      title: '${productQuantity}kg, price',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff7C7C7C),
                      letterSpacing: 0.1,
                    ),
                    SizedBox(height: 30.14.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AddMinusButtonWidget(),
                        SizedBox(width: 10.w),
                        TextWidget(
                          title: '\$${productPrice.toStringAsFixed(2)}',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff181725),
                          letterSpacing: 0.1,
                          height: 1.8,
                        ),
                      ],
                    ),
                    Divider(
                      color: const Color(0xffE2E2E2),
                      thickness: 1,
                      height: 50.h,
                    ),
                    _buildToggleSection(
                      title: 'Product Details',
                      isVisible: isProductDetailsVisible,
                      onToggle: () {
                        ref.read(productDetailsVisibleProvider.notifier).state =
                            !isProductDetailsVisible;
                      },
                      content: 'Product details go here...',
                    ),
                    Divider(
                      color: const Color(0xffE2E2E2),
                      thickness: 1,
                      height: 50.h,
                    ),
                    _buildToggleSection(
                      title: 'Nutrition',
                      isVisible: isNutritionDetailsVisible,
                      onToggle: () {
                        ref
                                .read(nutritionDetailsVisibleProvider.notifier)
                                .state =
                            !isNutritionDetailsVisible;
                      },
                      content: 'Nutrition details go here...',
                    ),
                    Divider(
                      color: const Color(0xffE2E2E2),
                      thickness: 1,
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          title: 'Review',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff181725),
                          letterSpacing: 0.1,
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return InkWell(
                              onTap: () {
                                ref.read(currentRatingProvider.notifier).state =
                                    index + 1;
                              },
                              child: Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: const Color(0xffF3603F),
                                size: 18,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.14.h),
                    CustomButtonWidget(
                      buttonName: 'Add to Basket',
                      padding: const EdgeInsets.only(left: 110),
                      onPressed: () async {
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSection({
    required String title,
    required bool isVisible,
    required VoidCallback onToggle,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              title: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff181725),
              letterSpacing: 0.1,
            ),
            InkWell(
              onTap: onToggle,
              child: Icon(
                isVisible
                    ? Icons.keyboard_arrow_down_outlined
                    : Icons.keyboard_arrow_right,
                color: const Color(0xff181725),
              ),
            ),
          ],
        ),
        if (isVisible)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextWidget(
              title: content,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff7C7C7C),
              letterSpacing: 0.1,
            ),
          ),
      ],
    );
  }
}
