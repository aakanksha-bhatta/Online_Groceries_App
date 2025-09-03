import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_notifier.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.71.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF2F3F2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: TextField(
          onChanged: (value) =>
              ref.read(searchProvider.notifier).updateQuery(value),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search Store',
            prefixIcon: const Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 14),
            hintStyle: TextStyle(
              color: const Color(0xff7C7C7C),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
