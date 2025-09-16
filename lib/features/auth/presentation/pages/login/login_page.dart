import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/util/validation.dart';
import 'package:online_groceries_app/features/auth/presentation/controller/auth_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/provider/state_provider.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

// Stream<int> getNumberStream() {
//   final StreamController<int> controller = StreamController<int>();
//   int counter = 0;
//   Timer.periodic(Duration(milliseconds: 1), (Timer timer) {
//     controller.add(counter);
//     counter++;
//   });
//   return controller.stream;
// }

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isFormFilled = false;

  void checkFormFilled() {
    final isFilled = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    if (isFormFilled != isFilled) {
      setState(() {
        isFormFilled = isFilled;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(checkFormFilled);
    passwordController.addListener(checkFormFilled);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = ref.watch(passwordVisibilityProvider);
    final loginState = ref.watch(authNotifierProvider);
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
                title: loc.login,
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
                      labelText: loc.password,
                      obscureText: !isVisible,
                      controller: passwordController,
                      validator: (value) =>
                          Validation.validPassword(loc, value),
                      suffixIcon: IconButton(
                        onPressed: () {
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
                isEnabled: isFormFilled && !loginState.isLoading,
                onPressed: loginState.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final user = await ref
                              .read(authNotifierProvider.notifier)
                              .signInWithEmail(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                          if (user != null) {
                            CustomSnackBar.show(context, loc.loginSuccess);
                            context.go(Path.home);
                          } else {
                            CustomSnackBar.show(
                              context,
                              loc.invalidCredentials,
                            );
                          }
                        }
                      },
                child: loginState.isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : null,
              ),

              SizedBox(height: 25.h),

              /// Sign-up Text
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
