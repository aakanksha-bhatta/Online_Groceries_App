import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/product_service.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/card_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class FilteredProductPage extends StatelessWidget {
  final List<String> selectedCategories;

  const FilteredProductPage({super.key, required this.selectedCategories});

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
                    onTap: () => context.go(Path.category),
                    child: const Icon(Icons.arrow_back_ios, size: 18),
                  ),
                ),
                Center(
                  child: TextWidget(
                    title: "Products",
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 0.5,
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
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final allProducts = snapshot.data ?? [];

                final filtered = allProducts.where((p) {
                  return selectedCategories.any(
                    (selected) =>
                        p.category.trim().toLowerCase() ==
                        selected.trim().toLowerCase(),
                  );
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text('No products match your filters.'),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.7,
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
