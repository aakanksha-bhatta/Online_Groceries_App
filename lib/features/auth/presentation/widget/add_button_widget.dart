import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.67.w,
      height: 45.67.h,
      decoration: BoxDecoration(
        color: Color(0xff53B175),
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: AppColor.splashColor,
          borderRadius: BorderRadius.circular(17.r),
          child: Icon(Icons.add, color: Colors.white, size: 28.sp),
        ),
      ),
    );
  }
}
