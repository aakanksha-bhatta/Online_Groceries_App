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
    int limit = 3;
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
                final exclusiveProducts = [...filteredProducts.take(limit)]
                  ..shuffle();
                final bestSellerProducts = [...filteredProducts.take(limit)]
                  ..shuffle();
                final groceryProducts = [...filteredProducts.take(limit)]
                  ..shuffle();

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.41),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

                        SizedBox(height: 20.h),

                        // Exclusive Offer Section
                        RowHelperTextWidget(
                          title: "Exclusive Offer",
                          onTap: () {
                            context.go(Path.see);
                          },
                        ),
                        SizedBox(height: 15.h),
                        SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              if (index < 3 &&
                                  index < exclusiveProducts.length) {
                                final product = exclusiveProducts[index];
                                return CardWidget(
                                  productId: product.productId,
                                  productName: product.productName,
                                  productImage: product.productImage,
                                  productPrice: product.productPrice,
                                  productQuantity: product.productQuantity,
                                );
                              } else {
                                // "See More" card
                                return GestureDetector(
                                  onTap: () {
                                    context.go(Path.see);
                                  },
                                  child: Container(
                                    height: 248.51.h,
                                    width: 173.32.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.r),
                                      border: Border.all(
                                        color: Color(0xffE2E2E2),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 32,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 10.h),
                                          TextWidget(
                                            title: 'See more',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        SizedBox(height: 25),
                        // Best Sellers Section
                        RowHelperTextWidget(
                          title: "Best Sellers",
                          onTap: () {
                            context.go(Path.see);
                          },
                        ),
                        SizedBox(height: 15.h),
                        SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              if (index < 3 &&
                                  index < exclusiveProducts.length) {
                                final product = bestSellerProducts[index];
                                return CardWidget(
                                  productId: product.productId,
                                  productName: product.productName,
                                  productImage: product.productImage,
                                  productPrice: product.productPrice,
                                  productQuantity: product.productQuantity,
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    context.go(Path.see);
                                  },
                                  child: Container(
                                    height: 248.51.h,
                                    width: 173.32.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.r),
                                      border: Border.all(
                                        color: Color(0xffE2E2E2),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 32,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 10.h),
                                          TextWidget(
                                            title: 'See more',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 25),
                        // Grocery Section
                        RowHelperTextWidget(
                          title: "Grocery",
                          onTap: () {
                            context.go(Path.see);
                          },
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            height: 250.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,

                              itemCount: groceryProducts.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: 12.w),
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
