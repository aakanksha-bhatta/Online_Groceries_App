import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';

class AddMinusButtonWidget extends ConsumerWidget {
  const AddMinusButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider);
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (quantity > 1) {
              ref.read(quantityProvider.notifier).state = quantity - 1;
            }
          },
          icon: Icon(Icons.remove),
        ),
        Container(
          height: 45.67.h,
          width: 45.67.w,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffE2E2E2)),
            borderRadius: BorderRadius.circular(17.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Center(
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff181725),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            ref.read(quantityProvider.notifier).state = quantity + 1;
          },
          icon: Icon(Icons.add, color: Colors.green),
        ),
      ],
    );
  }
}
