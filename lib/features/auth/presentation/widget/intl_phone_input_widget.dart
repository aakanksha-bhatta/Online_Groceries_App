import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntlPhoneInputWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final String? initialCountryCode;
  final String? labelText;
  final bool? isEnable;
  final TextEditingController? controller;
  final FutureOr<String?> Function(PhoneNumber?)? validator;

  const IntlPhoneInputWidget({
    super.key,
    this.onChanged,
    this.initialCountryCode = 'NP',
    this.labelText,
    this.isEnable,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty) ...[
          Text(
            labelText!,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF7C7C7C),
            ),
          ),
          SizedBox(height: 8.h),
        ],
        IntlPhoneField(
          controller: controller,
          validator: validator,
          showDropdownIcon: false,
          disableLengthCheck: true,
          initialCountryCode: initialCountryCode,
          enabled: isEnable ?? true,
          decoration: InputDecoration(
            // enabled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE2E2E2)),
            ),
          ),
          onChanged: (phone) {
            final fullPhoneNumber = phone.completeNumber;
            onChanged?.call(fullPhoneNumber);
          },
        ),
      ],
    );
  }
}
