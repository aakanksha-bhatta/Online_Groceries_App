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
  final Icon? icon;
  final bool isEnabled;
  final Color? iconColor;
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
    this.isEnabled = true,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: isEnabled
          ? (buttonColor ?? theme.primaryColor)
          : Colors.green.shade200,
      borderRadius: BorderRadius.circular(19.r),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        splashColor: splashColor ?? AppColor.splashColor,
        borderRadius: BorderRadius.circular(19.r),
        child: Container(
          height: 67.h,
          width: 353.w,
          alignment: Alignment.center,
          child: child != null
              ? child!
              : Row(
                  mainAxisAlignment: buttonIcon != null
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    if (buttonIcon != null || icon != null)
                      Padding(
                        padding:
                            padding ??
                            EdgeInsets.only(left: 35.39.w, right: 40.22.w),
                        child: buttonIcon != null
                            ? SvgPicture.asset(
                                buttonIcon!,
                                color: iconColor ?? Colors.white,
                              )
                            : icon,
                      ),

                    Padding(
                      padding: padding ?? EdgeInsets.zero,
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
