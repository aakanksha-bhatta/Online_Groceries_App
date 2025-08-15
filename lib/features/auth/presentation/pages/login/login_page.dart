import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';
// import 'package:online_groceries_app/config/constants/app_color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundLayoutWidget(
        dynamicWidget: Stack(
          children: [
            Positioned(
              top: 89.92.h,
              left: 183.08.w,
              child: SvgPicture.asset('assets/icons/carrot_color.svg'),
            ),
            Positioned( 
              top: 233.1.h, left: 25.01.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: "Loging",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF181725),
                    letterSpacing: 0,
                    height: 1.0,
                  ),
                  TextWidget(
                    title: "Enter your emails and password",
                    fontSize: 16.sp,
                    height: 2.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7C7C7C),
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputTextFormWidget(),
                InputTextFormWidget(),
                Padding(
                  padding: EdgeInsets.only(right: 24.08.sp),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextWidget(title: 'forget Password?',
                     fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                       color: Color(0xFF181725), letterSpacing: 0),
                  ),
                ),
                SizedBox(height: 30.h,),
                CustomButtonWidget(buttonName: "Log In"),
                SizedBox(height: 25.h,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(title: "Don’t have an account?",
                     fontSize: 14.sp, 
                     fontWeight: FontWeight.w600, 
                     color: Colors.black, 
                     height: 1,
                     letterSpacing: 0.5,
                     spans: [
                      TextSpan(
                        text: ' SignUp',
                        style: TextStyle(
                          fontSize: 14.sp, 
                          fontWeight: FontWeight.w600, 
                          color: Color(0xFF53B175), 
                          height: 1,
                          letterSpacing: 0.5,
                        )
                      )
                     ],
                    ),
                  ],
                )
                ],
            ),
          ],
        ),
      ),
    );
  }
}
