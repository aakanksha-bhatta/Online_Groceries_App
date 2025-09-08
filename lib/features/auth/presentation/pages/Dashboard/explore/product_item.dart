import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/product_service.dart';
import 'package:online_groceries_app/features/auth/data/enum/product_enum.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/card_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class ProductListPage extends StatelessWidget {
  final ProductEnum category;
  const ProductListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top bar
          Padding(
            padding: const EdgeInsets.only(
              top: 56.93,
              bottom: 10,
              left: 17,
              right: 16,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => context.go(Path.explore),
                    child: Icon(Icons.arrow_back_ios, size: 18),
                  ),
                ),
                Center(
                  child: TextWidget(
                    title: category.name,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    child: SvgPicture.asset(
                      'assets/icons/category.svg',
                      color: Colors.black,
                    ),
                    onTap: () => context.push(Path.category),
                  ),
                ),
              ],
            ),
          ),

          // Product list
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: productService.loadProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final allProducts = snapshot.data ?? [];

                final filtered = allProducts
                    .where((p) => p.category == category.name)
                    .toList();

                if (filtered.isEmpty) {
                  return Center(child: Text('No products in this category.'));
                }

                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10, // Spacing between columns
                    mainAxisSpacing: 20, // Spacing between rows
                    childAspectRatio: 0.7, // Aspect ratio of each grid item
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    return CardWidget(
                      productId: product.productId,
                      productName: product.productName,
                      productImage: product.productImage,
                      productPrice: product.productPrice,
                      productQuantity: product.productQuantity,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
