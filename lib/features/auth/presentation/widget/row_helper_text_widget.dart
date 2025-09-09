import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_screenutil/flutter_screenutil.dart';
>>>>>>> master
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class RowHelperTextWidget extends StatelessWidget {
  final String title;
<<<<<<< HEAD
  final VoidCallback? onTap;

  const RowHelperTextWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title: title,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 0,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: const Color.fromARGB(255, 231, 230, 230),
            onTap: onTap,
            child: Text(
              'See All',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ),
      ],
=======
  const RowHelperTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: title,
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
>>>>>>> master
    );
  }
}
