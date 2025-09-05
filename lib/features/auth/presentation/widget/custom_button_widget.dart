import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonName;
  final Color? textColor;
  final Color? buttonColor;
  final Color? splashColor;
  final String? buttonIcon;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonName,
    this.buttonColor,
    this.splashColor,
    this.buttonIcon,
    this.child,
    this.textColor,
    this.padding,
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
          child: child != null
              ? child!
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    if (buttonIcon != null)
                      Padding(
                        padding:
                            padding ??
                            EdgeInsets.only(left: 35.39, right: 40.22.w),
                        child: SvgPicture.asset(buttonIcon!),
                      ),
                    Padding(
                      padding: padding ?? EdgeInsets.all(0),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          title: buttonName,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              textColor ??
                              theme.textTheme.displayMedium?.color ??
                              Colors.white,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
