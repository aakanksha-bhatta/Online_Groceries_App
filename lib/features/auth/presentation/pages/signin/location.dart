import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/app_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundLayoutWidget(
        dynamicWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(
              onTap: () {
                context.go(Path.verification);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 44.97.h, left: 94.96.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/location.svg'),
                  SizedBox(height: 40.5),
                  TextWidget(
                    title: 'Select Your Location',
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF181725),
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
