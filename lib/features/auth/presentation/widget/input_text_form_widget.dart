import 'package:flutter/material.dart';

class InputTextFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  

  const InputTextFormWidget({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.8),
      // if (labelTxt != null && labelTxt!.isNotEmpty) ...[
      //       TextWidget(
      //         txt: labelTxt!,
      //         fontWeight: FontWeight.w600,
      //         fontSize: 12.sp,
      //         txtColor: Color(0xFF979797),
      //       ),
      //       SizedBox(height: 8.h),
      //     ] else ...[
      //       SizedBox(height: 2.h),
      // ],
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
