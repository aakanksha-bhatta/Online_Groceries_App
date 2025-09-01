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
      body: Column(
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
              padding: const EdgeInsets.only(left: 25.27, right: 25.27),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 15, bottom: 25),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset(
                      'assets/images/banana.png',
                      alignment: Alignment.topCenter,
                      height: 60.h,
                      width: 60.w,
                    ),
                    title: TextWidget(
                      title: 'Original Banana',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff181725),
                      letterSpacing: 0,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: '1kg, Price',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7C7C7C),
                          letterSpacing: 0,
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 62.39990234375.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextWidget(
                            title: '\$4.99',
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
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Color(0xffE2E2E2), thickness: 1);
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 24.39,
              right: 25.27,
              bottom: 21.25,
              top: 5.23,
            ),
            child: CustomButtonWidget(buttonName: 'Add All to Cart'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
