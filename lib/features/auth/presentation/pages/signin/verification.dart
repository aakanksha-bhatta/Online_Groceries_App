import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/util/validation.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/app_bar_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class Verification extends ConsumerWidget {
  Verification({super.key});

  final maskFormatter = MaskTextInputFormatter(
    mask: '####',
    filter: {"#": RegExp(r'[0-9]')},
    initialText: '----',
  );

  final TextEditingController otpController =
      TextEditingController(); // <-- Add this

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    // final args = GoRouterState.of(context).extra as Map<String, dynamic>;
    // final String verificationId = args['verificationId'];
    // final String phoneNumber = args['phoneNumber'];

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      title: loc.enter4DigitCode,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF181725),
                      letterSpacing: 0,
                    ),
                    SizedBox(height: 27.h),
                    InputTextFormWidget(
                      controller: otpController,
                      validator: (value) => Validation.validOtp(loc, value),
                      inputFormatters: [maskFormatter],
                      hintText: '- - - -',
                      labelText: loc.code,
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 450),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            title: loc.resendCode,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff53b175),
                            letterSpacing: 0,
                          ),
                          Container(
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
                                onTap: () async {
                                  final smsCode = otpController.text.trim();
                                  if (smsCode.length < 4) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(loc.enter4DigitCode),
                                      ),
                                    );
                                    return;
                                  }

                                  // final auth = AuthService();

                                  // await auth.signInWithOtp(
                                  //   context: context,
                                  //   verificationId: verificationId,
                                  //   smsCode: smsCode,
                                  // );

                                  // if (auth.getCurrentUser() != null) {
                                  //   context.go(Path.location);
                                  // }
                                  context.go(Path.location);
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFFFFFFFF),
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
            ],
          ),
        ),
      ),
    );
  }
}
