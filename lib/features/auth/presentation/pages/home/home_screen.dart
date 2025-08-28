import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/card_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_navigation_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/search_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 63.70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/carrot_color.svg',
                width: 37.72.w,
                height: 36.97.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xff393636),
                    size: 18,
                    weight: 20,
                  ),
                  TextWidget(
                    title: "Dhaka, Banassre",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff393636),
                    letterSpacing: 0,
                  ),
                ],
              ),
              SearchBarWidget(),
              Container(
                height: 114.99.h,
                width: 368.2.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: AssetImage('assets/images/signin_bg.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.29.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: 'Exclusive Offer',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff181725),
                      letterSpacing: 0,
                    ),
                    TextWidget(
                      title: 'See all',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff53B175),
                      letterSpacing: 0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CardWidget(),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.29.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: 'Best Selling',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff181725),
                      letterSpacing: 0,
                    ),
                    TextWidget(
                      title: 'See all',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff53B175),
                      letterSpacing: 0,
                    ),
                  ],
                ),
              ),
              CardWidget(),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.29.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: 'Groceries',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff181725),
                      letterSpacing: 0,
                    ),
                    TextWidget(
                      title: 'See all',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff53B175),
                      letterSpacing: 0,
                    ),
                  ],
                ),
              ),
              CardWidget(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomSheet: CustomNavigationBar(),
    );
  }
}
