import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/app_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/check_box.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<String> categories = [
    'Fresh Fruit & Vegetables',
    'Meat & Fish',
    'Cooking Oil & Ghee',
    'Bakery and Snacks',
    'Dairy & Eggs',
    'Beverages',
  ];

  final Map<String, bool> selectedCategories = {};

  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      selectedCategories[category] = false;
    }
  }

  void _applyFilter() {
    final filtered = selectedCategories.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (filtered.isNotEmpty) {
      context.go('/filtered-products', extra: filtered);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one category.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            title: 'Filters',
            onTap: () {
              context.go(Path.explore);
            },
            icon: const Icon(Icons.close),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F3F2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
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
                      ...categories.map(
                        (category) => CheckBox(
                          categoryName: category,
                          isChecked: selectedCategories[category]!,
                          onChanged: (value) {
                            setState(() {
                              selectedCategories[category] = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 250.h),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButtonWidget(
                          buttonName: 'Apply Filter',
                          onPressed: _applyFilter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
