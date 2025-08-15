import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class CustomButtonWidget extends StatelessWidget{
  final void Function()? onPressed;
  final String buttonName;
  
  
  const CustomButtonWidget({super.key, this.onPressed, required this.buttonName});

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        height: 67.h, width: 353.w,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(19.r)
        ),
        child: Center(
          child: TextWidget(
            title: buttonName,
           fontSize: 18.sp,
            fontWeight: FontWeight.w600,
             color:theme.textTheme.displayMedium!.color!,
              letterSpacing: 0),
        ),

      ));
  }
}