import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/add_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 248.51.h,
      width: 173.32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Color(0xffE2E2E2)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 33.39.w,
                vertical: 23.0.h,
              ),
              child: Container(
                height: 79.43.h,
                width: 99.89.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/banana.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            TextWidget(
              title: 'Organic Bananas',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff181725),
              letterSpacing: 0.1,
            ),
            TextWidget(
              title: '7pcs, Priceg',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff7C7C7C),
              letterSpacing: 0.1,
            ),
            SizedBox(height: 18.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  title: '\$4.99',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff181725),
                  letterSpacing: 0.1,
                  height: 1.2,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: AddButtonWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
