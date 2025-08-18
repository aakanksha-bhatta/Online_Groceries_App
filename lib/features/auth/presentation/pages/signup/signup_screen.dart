import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(passwordVisibilityProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundLayoutWidget(
        dynamicWidget: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 77.25.h),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  'assets/icons/carrot_color.svg',
                  width: 37.72.w,
                  height: 42.97.h,
                ),
              ),
              SizedBox(height: 100.21.h),
              TextWidget(
                title: "Sign Up",
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181725),
                letterSpacing: 0,
                height: 1.0,
              ),
              SizedBox(height: 15.h),
              TextWidget(
                title: "Enter your credentials to continue",
                fontSize: 16.sp,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7C7C7C),
                letterSpacing: 0,
              ),
              SizedBox(height: 40.h),
              InputTextFormWidget(labelText: 'Username'),
              SizedBox(height: 30.h),
              InputTextFormWidget(labelText: 'Email'),
              SizedBox(height: 30.h),
              InputTextFormWidget(
                labelText: 'Password',
                obscureText: !isVisible,
                suffixIcon: IconButton(
                  onPressed: () {
                    // .notifier updating state
                    ref.read(passwordVisibilityProvider.notifier).state =
                        !isVisible;
                  },
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 4.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            title:
                                'By continuing you agree to our',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7C7C7C),
                            letterSpacing: 0,
                          ),
                          TextWidget(
                            title:
                                ' Terms of Service ',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF53B175),
                            letterSpacing: 0,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextWidget(
                            title:
                                'and',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7C7C7C),
                            letterSpacing: 0,
                          ),
                          TextWidget(
                            title:
                                ' Privacy Policy',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF53B175),
                            letterSpacing: 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              CustomButtonWidget(buttonName: "Sign Up"),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    onTap: () => SignupScreen(),
                    title: "Already have an account?",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1,
                    letterSpacing: 0.5,
                    spans: [
                      TextSpan(
                        text: ' SignIn',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF53B175),
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          context.go(Path.login);
                        } 
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
