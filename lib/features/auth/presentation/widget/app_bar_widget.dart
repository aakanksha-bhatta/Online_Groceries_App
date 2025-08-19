import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  const AppBarWidget({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.83.h, left: 25.01.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Color(0xFF828282),
          onTap: onTap,
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}
