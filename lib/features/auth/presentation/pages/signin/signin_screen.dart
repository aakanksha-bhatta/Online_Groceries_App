import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/auth_service.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/intl_phone_input_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundLayoutWidget(
        dynamicWidget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 374.15.h,
                width: 413.37.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/signin_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 230.w,
                      child: TextWidget(
                        title: loc.gerYourGroceriesInAsFastAsOneHour,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                        letterSpacing: 0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(Path.mobile);
                      },
                      child: IntlPhoneInputWidget(isEnable: false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 88.w, top: 40.h),
                      child: TextWidget(
                        title: loc.orConnectWithSocial,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondaryTextColor,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 37.8.h),
                    CustomButtonWidget(
                      buttonName: loc.continueWithGoogle,
                      buttonColor: Color(0xFF5383EC),
                      splashColor: Color(0xFFB3C7F3),
                      onPressed: () async {
                        final result = await AuthService().signInWithGoogle();

                        // if (result != null) {
                        //   // Navigate to Home Page
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomeScreen(),
                        //     ), // or use GoRouter
                        //   );
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text("Google Sign-In failed")),
                        //   );
                        // }
                      },

                      buttonIcon: 'assets/icons/google.svg',
                    ),
                    SizedBox(height: 20.h),
                    CustomButtonWidget(
                      buttonName: loc.continueWithFacebook,
                      buttonColor: Color(0xFF4A66AC),
                      splashColor: Color(0xFF8095C7),
                      buttonIcon: 'assets/icons/facebook.svg',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
