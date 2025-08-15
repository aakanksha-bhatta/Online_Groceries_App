import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: theme.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/carrot.svg'),
            SizedBox(width: 18.36.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/nectar.svg'),
                TextWidget(
                  title: 'online groceriet',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  // height
                  color: theme.textTheme.displayMedium!.color!,
                  letterSpacing:5.8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
