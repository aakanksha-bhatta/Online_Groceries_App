import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class ErrorOrder extends StatelessWidget {
  const ErrorOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(24),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  child: const Icon(Icons.close),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            Image.asset('assets/icons/error.png'),

            const SizedBox(height: 30),

            const TextWidget(
              title: 'Oops! Order Failed',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xff181725),
              letterSpacing: 0,
            ),

            const SizedBox(height: 16),

            const TextWidget(
              title: 'Something went terribly wrong.',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff7C7C7C),
              letterSpacing: 0,
            ),

            const SizedBox(height: 30),

            CustomButtonWidget(
              buttonName: 'Please Try Again',
              // padding: const EdgeInsets.only(left: 75),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            CustomButtonWidget(
              buttonName: 'Back to Home',
              buttonColor: Colors.transparent,
              textColor: Colors.black,
              // padding: const EdgeInsets.only(left: 80),
              onPressed: () {
                context.go(Path.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
