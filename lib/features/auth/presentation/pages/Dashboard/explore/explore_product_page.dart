import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_groceries_app/features/auth/data/enum/product_enum.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/explore/category.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/search_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class ExploreProductPage extends StatefulWidget {
  const ExploreProductPage({super.key});

  @override
  State<ExploreProductPage> createState() => _ExploreProductPageState();
}

class _ExploreProductPageState extends State<ExploreProductPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter product list
    final filteredProducts = ProductEnum.values.where((product) {
      return product.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with search bar
          Column(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Category(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔍 Search bar
              SearchBarWidget(
                // onChanged: (value) {
                //   setState(() {
                //     _searchQuery = value;
                //   });
                // },
              ),
            ],
          ),

          // Products Grid
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: product.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: product.color.withOpacity(0.7),
                          ),
                        ),
                        padding: EdgeInsets.all(12),
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
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: TextWidget(
                                title: product.name,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff181725),
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
