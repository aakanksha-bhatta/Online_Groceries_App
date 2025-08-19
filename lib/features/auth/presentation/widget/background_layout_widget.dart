import 'package:flutter/material.dart';
import 'package:online_groceries_app/config/constants/app_color.dart';
// import 'package:online_groceries_app/features/auth/presentation/widget/input_text_form_widget.dart';

class BackgroundLayoutWidget extends StatelessWidget {
  final Widget dynamicWidget;
  final Color? bgColor;

  const BackgroundLayoutWidget({
    super.key,
    required this.dynamicWidget,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: bgColor ?? AppColor.white,
              image: DecorationImage(
                image: AssetImage('assets/images/mask_group.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          dynamicWidget,
        ],
      ),
    );
  }
}
