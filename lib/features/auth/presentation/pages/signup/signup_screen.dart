import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/auth_service.dart';
import 'package:online_groceries_app/core/util/validation.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String? usernameError;
  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(passwordVisibilityProvider);
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
                title: loc.signUp,
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181725),
                letterSpacing: 0,
                height: 1.0,
              ),
              SizedBox(height: 15.h),
              TextWidget(
                title: loc.enterCredentialsToContinue,
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
                      labelText: loc.username,
                      controller: usernameController,
                      validator: (value) =>
                          Validation.validUsername(loc, value),
                    ),
                    SizedBox(height: 30.h),
                    InputTextFormWidget(
                      labelText: loc.email,
                      controller: emailController,
                      validator: (value) => Validation.validEmail(loc, value),
                    ),
                    SizedBox(height: 30.h),
                    InputTextFormWidget(
                      labelText: loc.password,
                      controller: passwordController,
                      obscureText: !isVisible,
                      validator: (value) =>
                          Validation.validPassword(loc, value),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            title: loc.byContinuingYouAgree,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7C7C7C),
                            letterSpacing: 0,
                          ),
                          TextWidget(
                            title: loc.termsOfService,
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
                            title: loc.and,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7C7C7C),
                            letterSpacing: 0,
                          ),
                          TextWidget(
                            title: loc.privacyPolicy,
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
              CustomButtonWidget(
                buttonName: loc.signUp,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = await auth.createUserWithEmailPassword(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration Successfully')),
                      );
                      context.go(Path.login);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User registration failed')),
                      );
                    }
                  }

                  // final username = usernameController.text.trim();
                  // final useremail = emailController.text.trim();
                  // final userpassword = passwordController.text.trim();

                  // final user = User(
                  //   username: username,
                  //   useremail: useremail,
                  //   userpassword: userpassword
                  //   );
                  // ref.read(userListProvider.notifier).saveUsers(user);

                  // ScaffoldMessenger.of(
                  //   context,
                  // ).showSnackBar(SnackBar(content: Text('Registration successfully !')));
                },
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    onTap: () => SignupScreen(),
                    title: loc.alreadyHaveAccount,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1,
                    letterSpacing: 0.5,
                    spans: [
                      TextSpan(
                        text: loc.signIn,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF53B175),
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(Path.login);
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
