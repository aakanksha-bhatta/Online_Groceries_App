import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonName;

  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.primaryColor,
      borderRadius: BorderRadius.circular(19.r),
      child: InkWell(
        onTap: onPressed,
        splashColor: AppColor.splashColor,
        borderRadius: BorderRadius.circular(19.r),
        child: Container(
          height: 67.h,
          width: 353.w,
          alignment: Alignment.center,
          child: TextWidget(
            title: buttonName,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.displayMedium?.color ?? Colors.white,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
