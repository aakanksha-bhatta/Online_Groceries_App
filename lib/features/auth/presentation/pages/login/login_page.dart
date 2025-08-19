import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/util/validation.dart';
// import 'package:online_groceries_app/features/auth/presentation/controller/user_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class LoginPage extends ConsumerWidget {
 LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? phoneError;
  String? passwordError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(
      passwordVisibilityProvider,
    ); //listen current state value
    final userList = ref.watch(userListProvider);
    final loc = AppLocalizations.of(context)!;
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
                title:loc.loging,
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181725),
                letterSpacing: 0,
                height: 1.0,
              ),
              SizedBox(height: 15.h),
              TextWidget(
                title: loc.enterYourEmailAndPassword,
                fontSize: 16.sp,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7C7C7C),
                letterSpacing: 0,
              ),
              SizedBox(height: 40.h),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    InputTextFormWidget(
                      labelText: loc.email,
                      controller: emailController,
                      validator: (value) => Validation.validEmail(loc, value),
                    ),

                    SizedBox(height: 30.h),
                    InputTextFormWidget(
                      labelText:loc.password,
                      obscureText: !isVisible,
                      controller: passwordController,
                      validator: (value) => Validation.validPassword(loc, value),
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
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 4.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                    title: loc.forgetPassword,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF181725),
                    letterSpacing: 0,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              CustomButtonWidget(
                buttonName: loc.login,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final useremail = emailController.text.trim();
                    final userpassword = passwordController.text.trim();

                    // Access the notifier, call login method
                    final isValid = ref
                        .read(userListProvider.notifier)
                        .loginUser(useremail, userpassword);

                    if (isValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.loginSuccess)),
                      );
                      context.go(Path.home);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.invalidCredentials)),
                      );
                    }
                  }
                },
              ),

              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    title: loc.dontHaveAccount,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1,
                    letterSpacing: 0.5,
                    spans: [
                      TextSpan(
                        text: loc.signUp,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF53B175),
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(Path.signup);
                          },
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
