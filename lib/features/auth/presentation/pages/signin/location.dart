import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/app_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: BackgroundLayoutWidget(
        dynamicWidget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(
                onTap: () {
                  context.go(Path.verification);
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 44.97.h, left: 44.49.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/location.svg'),
                    SizedBox(height: 40.5),
                    TextWidget(
                      title: loc.selectYourLocation,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF181725),
                      letterSpacing: 0,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: 329.w,
                      child: TextWidget(
                        title: loc.locationSubtitleLine1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7C7C7C),
                        letterSpacing: 0,
                      ),
                    ),
                    TextWidget(
                      title: loc.locationSubtitleLine2,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7C7C7C),
                      letterSpacing: 0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 89.35.h,
                  horizontal: 25.8.w,
                ),
                child: Column(
                  children: [
                    InputTextFormWidget(
                      labelText: loc.yourZone,
                      hintText: loc.enterYourZone,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 30.h),
                    InputTextFormWidget(
                      labelText: loc.yourZone,
                      hintText: loc.enterYourZone,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 40.35.h),
                    CustomButtonWidget(
                      buttonName: loc.submit,
                      onPressed: () {
                        context.go(Path.login);
                      },
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
