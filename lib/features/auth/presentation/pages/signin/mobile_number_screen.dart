import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/app_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/intl_phone_input_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

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
                  context.go(Path.signin);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 25.07.w,
                  top: 65.19.h,
                  right: 24.76,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: loc.enterYourMobileNumber,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF181725),
                      letterSpacing: 0,
                    ),
                    SizedBox(height: 27.h),
                    IntlPhoneInputWidget(labelText: loc.mobileNumber),

                    SizedBox(height: 450),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 67.h,
                        width: 67.w,
                        decoration: BoxDecoration(
                          color: Color(0xFF53B175),
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            splashColor: Color(0xFF7BC48B),
                            onTap: () {
                              context.go(Path.verification);
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
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
