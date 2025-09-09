import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 441.97.h,
              width: 414.w,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Padding(
                padding: EdgeInsets.only(top: 31.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/carrot.svg',
                      height: 56.36.h,
                      width: 48.47.w,
                    ),
                    SizedBox(height: 12.66.h),
                    TextWidget(
                      title: loc.welcome,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.displayMedium!.color!,
                      letterSpacing: 0,
                    ),
                    TextWidget(
                      title: loc.toOurStore,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.displayMedium!.color!,
                      letterSpacing: 0,
                    ),
                    TextWidget(
                      title: loc.gerYourGroceriesInAsFastAsOneHour,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: theme.textTheme.displayMedium!.color!,
                      letterSpacing: 0,
                    ),
                    SizedBox(height: 40.88.h),
                    CustomButtonWidget(
                      buttonName: loc.getStarted,
<<<<<<< HEAD
                      padding: EdgeInsets.symmetric(horizontal: 120.96),
=======
>>>>>>> master
                      onPressed: () => context.go(Path.signin),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
