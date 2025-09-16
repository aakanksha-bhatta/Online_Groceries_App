import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/controller/auth_notifier.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
import 'package:online_groceries_app/l10n/app_localizations.dart';

class SigninScreen extends ConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final state = ref.watch(authNotifierProvider);
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
                        title: 'Get your groceries with nectar',
                        overflow: TextOverflow.fade,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomButtonWidget(
                      buttonName: 'Login',
                      icon: Icon(Icons.login, color: Colors.white),
                      padding: EdgeInsets.only(right: 77),
                      buttonColor: Color(0xFF53B175),
                      splashColor: Color(0xFF7BC48B),
                      // buttonIcon: 'assets/icons/account.svg',
                      onPressed: () {
                        context.go(Path.login);
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomButtonWidget(
                      buttonName: 'SignUp',
                      buttonColor: Color(0xFF53B175),
                      splashColor: Color(0xFF7BC48B),
                      padding: EdgeInsets.only(left: 72),
                      buttonIcon: 'assets/icons/account.svg',
                      onPressed: () {
                        context.go(Path.signup);
                      },
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     context.go(Path.mobile);
                    //   },
                    //   child: IntlPhoneInputWidget(isEnable: false),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 82.w, top: 30.h),
                      child: TextWidget(
                        title: 'or connect with social media',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondaryTextColor,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 30.8.h),
                    CustomButtonWidget(
                      buttonName: loc.continueWithGoogle,
                      buttonColor: Color(0xFF5383EC),
                      splashColor: Color(0xFFB3C7F3),
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              final user = await ref
                                  .read(authNotifierProvider.notifier)
                                  .signInWithGoogle();

                              // if (user != null) {
                              //   final user = user.userCredential?.user;

                              // final displayName = user?.displayName;
                              // final email = user?.email;
                              // final photoURL = user?.photoURL;
                              // final uid = user?.uid;

                              // print('Name: $displayName');
                              // print('Email: $email');
                              // print('Photo: $photoURL');

                              if (user != null) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .set(
                                      {
                                        'username': user.displayName,
                                        'email': user.email,
                                        'photoURL': user.photoURL,
                                        'uid': user.uid,
                                        'createdAt':
                                            FieldValue.serverTimestamp(),
                                      },
                                      SetOptions(merge: true),
                                    ); // merge keeps existing fields
                              }

                              if (user != null) {
                                context.go(Path.home);
                                CustomSnackBar.show(
                                  context,
                                  "Google Sign-In successful",
                                );
                              } else {
                                CustomSnackBar.show(
                                  context,
                                  "Google Sign-In failed",
                                );
                              }
                            },

                      // },
                      buttonIcon: 'assets/icons/google.svg',

                      child: state.isLoading
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
