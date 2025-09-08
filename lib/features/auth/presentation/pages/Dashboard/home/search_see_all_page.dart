import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/core/services/product_service.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/card_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/search_bar_widget.dart';

class SearchSeeAllPage extends ConsumerStatefulWidget {
  const SearchSeeAllPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SearchSeeAllPageState();
  }
}

class _SearchSeeAllPageState extends ConsumerState<SearchSeeAllPage> {
  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 48),
          Row(children: [SearchBarWidget()]),

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

                if (allProducts.isEmpty) {
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
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) {
                    final product = allProducts[index];
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
