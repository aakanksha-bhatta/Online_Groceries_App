import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/product_service.dart';
import 'package:online_groceries_app/features/auth/data/model/product.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_notifier.dart';
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
    final searchQuery = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.only(top: 24.7),
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.go(Path.home);
                },
              ),
              Expanded(
                child: SearchBarWidget(
                  padding: EdgeInsets.only(
                    top: 24.71,
                    right: 20,
                    bottom: 10.71,
                  ),
                ),
              ),
            ],
          ),

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

                final filteredProducts = searchQuery.isEmpty
                    ? allProducts
                    : allProducts
                          .where(
                            (product) => product.productName
                                .toLowerCase()
                                .contains(searchQuery),
                          )
                          .toList();

                if (filteredProducts.isEmpty) {
                  return Center(child: Text('No products found.'));
                }

                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
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
