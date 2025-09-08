import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/card_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/row_helper_text_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/search_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productListProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 63.70),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/carrot_color.svg',

                  width: 37.72.w,
                  height: 36.97.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xff393636),
                      size: 18,
                      weight: 20,
                    ),
                    TextWidget(
                      title: "Dhaka, Banassre",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff393636),
                      letterSpacing: 0,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SearchBarWidget(),
                Container(
                  height: 114.99.h,
                  width: 368.2.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                      image: AssetImage('assets/images/signin_bg.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: productAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (products) {
                final searchQuery = ref.watch(searchProvider);

                final filteredProducts = searchQuery.isEmpty
                    ? products
                    : products
                          .where(
                            (product) => product.productName
                                .toLowerCase()
                                .contains(searchQuery),
                          )
                          .toList();

                if (filteredProducts.isEmpty) {
                  return Center(child: Text('No products found.'));
                }
                final exclusiveProducts = [...filteredProducts]..shuffle();
                final bestSellerProducts = [...filteredProducts]..shuffle();
                final groceryProducts = [...filteredProducts]..shuffle();

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.41),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // Exclusive Offer Section
                        RowHelperTextWidget(
                          title: "Exclusive Offer",
                          onTap: () {
                            context.go(Path.see);
                          },
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: exclusiveProducts.length,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              final product = exclusiveProducts[index];
                              return CardWidget(
                                productId: product.productId,
                                productName: product.productName,
                                productImage: product.productImage,
                                productPrice: product.productPrice,
                                productQuantity: product.productQuantity,
                              );
                            },
                          ),
                        ),

                        // Best Sellers Section
                        RowHelperTextWidget(title: "Best Sellers"),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: bestSellerProducts.length,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              final product = bestSellerProducts[index];
                              return CardWidget(
                                productId: product.productId,
                                productName: product.productName,
                                productImage: product.productImage,
                                productPrice: product.productPrice,
                                productQuantity: product.productQuantity,
                              );
                            },
                          ),
                        ),

                        // Grocery Section
                        RowHelperTextWidget(title: "Grocery"),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: groceryProducts.length,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              final product = groceryProducts[index];
                              return CardWidget(
                                productId: product.productId,
                                productName: product.productName,
                                productImage: product.productImage,
                                productPrice: product.productPrice,
                                productQuantity: product.productQuantity,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
