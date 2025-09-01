import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class InputTextFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  const InputTextFormWidget({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.labelText,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty) ...[
          TextWidget(
            title: labelText!,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff7C7C7C),
            letterSpacing: 0,
          ),
          SizedBox(height: 8.h),
        ] else ...[
          SizedBox(height: 2.h),
        ],
        TextFormField(
          inputFormatters: inputFormatters,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            suffixIcon: suffixIcon,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE2E2E2), width: 1),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
