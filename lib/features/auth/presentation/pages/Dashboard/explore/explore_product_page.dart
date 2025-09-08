import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/data/enum/product_enum.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/search_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class ExploreProductPage extends ConsumerStatefulWidget {
  const ExploreProductPage({super.key});

  @override
  ConsumerState<ExploreProductPage> createState() => _ExploreProductPageState();
}

class _ExploreProductPageState extends ConsumerState<ExploreProductPage> {
  @override
  Widget build(BuildContext context) {
    final productAsyncValue = ref.watch(productListProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 56.93,
              bottom: 10,
              left: 16,
              right: 16,
            ),
            child: SizedBox(
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: TextWidget(
                      title: 'Find Products',
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
                      onTap: () {
                        context.push(Path.category);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SearchBarWidget(),

          //product grid
          Expanded(
            child: productAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (products) {
                final searchQuery = ref.watch(searchProvider);
                final filteredProducts = ProductEnum.values.where((product) {
                  return product.name.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  );
                }).toList();
                if (filteredProducts.isEmpty) {
                  return Center(child: Text('No products found.'));
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return InkWell(
                        onTap: () {
                          context.go(
                            '${Path.item}?category=${Uri.encodeComponent(product.name)}',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: product.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: product.color.withOpacity(0.7),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 74.90,
                                width: 111.37,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(product.pngAssetPath),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: TextWidget(
                                  title: product.name,
                                  overflow: TextOverflow.clip,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff181725),
                                  letterSpacing: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
