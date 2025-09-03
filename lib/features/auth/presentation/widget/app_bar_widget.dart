import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final Widget? icon;
  const AppBarWidget({super.key, this.title, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.83.h, left: 25.01.w),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Color(0xFF828282),
              onTap: onTap,
              child: icon ?? Icon(Icons.arrow_back_ios),
            ),
          ),
          SizedBox(width: 20.w),
          TextWidget(
            title: title ?? '',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 0,
          ),
        ],
      ),
    );
  }
}
