import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.71.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF2F3F2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search Store',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 14),
            hintStyle: TextStyle(
              color: Color(0xff7C7C7C),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
