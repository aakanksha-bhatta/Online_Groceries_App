import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonName;
  final Color? buttonColor;
  final Color? splashColor;
  final String? buttonIcon;

  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonName,
    this.buttonColor,
    this.splashColor,
    this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: buttonColor ?? theme.primaryColor,
      borderRadius: BorderRadius.circular(19.r),
      child: InkWell(
        onTap: onPressed,
        splashColor: splashColor ?? AppColor.splashColor,
        borderRadius: BorderRadius.circular(19.r),
        child: Container(
          height: 67.h,
          width: 353.w,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonIcon != null)
                Padding(
                  padding: EdgeInsets.only(right: 42.63.w),
                  child: SvgPicture.asset(buttonIcon!),
                ),
              TextWidget(
                title: buttonName,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.displayMedium?.color ?? Colors.white,
                letterSpacing: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
