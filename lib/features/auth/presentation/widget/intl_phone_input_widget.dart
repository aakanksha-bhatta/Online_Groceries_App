import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntlPhoneInputWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final String? initialCountryCode;
  final String? labelText;
  final bool? isEnable;

  const IntlPhoneInputWidget({
    super.key,
    this.onChanged,
    this.initialCountryCode = 'NP',
    this.labelText,
    this.isEnable,
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
              color: const Color(0xffE2E2E2),
            ),
          ),
          SizedBox(height: 8.h),
        ],
        IntlPhoneField(
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
              borderSide: BorderSide(color: Color(0xFFE2E2E2), width: 1),
            ),
          ),
          onChanged: (phone) {},
        ),
      ],
    );
  }
}
