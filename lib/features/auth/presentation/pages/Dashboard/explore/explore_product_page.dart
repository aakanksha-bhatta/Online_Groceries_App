import 'package:flutter/material.dart';
import 'package:online_groceries_app/features/auth/data/enum/product_enum.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/explore/category.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/search_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class ExploreProductPage extends StatelessWidget {
  const ExploreProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 56.93, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        title: 'Find Products',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.search, color: Colors.black, size: 24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Category()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SearchBarWidget(),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GridView.builder(
                  itemCount: ProductEnum.values.length,
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
                    final product = ProductEnum.values[index];
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
                              // child: Image.asset(product.pngAssetPath),
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
