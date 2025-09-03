import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/app_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/check_box.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            title: 'Filters',
            
            onTap: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            height: 791.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F3F2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF181725),
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CheckBox(categoryName: 'Fresh Fruits & Vegetable'),
                      CheckBox(categoryName: 'Meat & Fish'),
                      CheckBox(categoryName: 'Cooking Oil & Ghee'),
                      CheckBox(categoryName: 'Bakery & Snack'),
                      CheckBox(categoryName: 'Dairy & Egg'),
                      CheckBox(categoryName: 'Beverages'),

                      SizedBox(height: 250),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButtonWidget(buttonName: 'Apply Filter'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
