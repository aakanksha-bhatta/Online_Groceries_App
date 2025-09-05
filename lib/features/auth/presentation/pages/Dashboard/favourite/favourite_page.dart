import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FavoritePageState();
  }
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No favorites found.'));
          }

          final favoriteDocs = snapshot.data!.docs;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55.82, bottom: 20),
                child: Center(
                  child: TextWidget(
                    title: 'Favorites',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff181725),
                    letterSpacing: 0,
                  ),
                ),
              ),
              Divider(color: Color(0xffE2E2E2), thickness: 1, height: 0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.27),
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 15, bottom: 25),
                    itemCount: favoriteDocs.length,
                    itemBuilder: (context, index) {
                      final data =
                          favoriteDocs[index].data() as Map<String, dynamic>;
                      final productName = data['productName'];
                      final productImage = data['productImage'];
                      final productQuantity =
                          data['productQuantity']?.toString() ?? '';

                      final productPrice = data['productPrice']?.toString();

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          productImage,
                          alignment: Alignment.topCenter,
                          height: 60.h,
                          width: 60.w,
                        ),

                        title: TextWidget(
                          title: productName,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff181725),
                          letterSpacing: 0,
                        ),
                        subtitle: TextWidget(
                          title: '$productQuantity kg, price',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7C7C7C),
                          letterSpacing: 0,
                        ),
                        trailing: SizedBox(
                          width: 62.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextWidget(
                                title: '\$$productPrice',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff181725),
                                letterSpacing: 0.1,
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xff7C7C7C),
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(color: Color(0xffE2E2E2), thickness: 1);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.27,
                ).copyWith(bottom: 21.25, top: 5.23),
                child: CustomButtonWidget(
                  buttonName: 'Add All to Cart',
                  padding: EdgeInsets.only(left: 115.96),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
