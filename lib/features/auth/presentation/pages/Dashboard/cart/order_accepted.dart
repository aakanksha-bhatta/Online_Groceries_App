import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/cart/error_order.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class OrderAccepted extends StatelessWidget {
  const OrderAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundLayoutWidget(
        dynamicWidget: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 151.7, left: 58.38),
              child: SvgPicture.asset('assets/icons/bg_order.svg'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 458.76, left: 74.41),
              child: SizedBox(
                width: 290,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'Your Order has been',
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff181725),
                      letterSpacing: 0,
                      overflow: TextOverflow.clip,
                    ),
                    Center(
                      child: TextWidget(
                        title: 'accepted',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff181725),
                        letterSpacing: 0,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextWidget(
                      title: 'Your items has been placed and is on',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7C7C7C),
                      letterSpacing: 0,
                      overflow: TextOverflow.clip,
                    ),
                    Center(
                      child: TextWidget(
                        title: 'it’s way to being processed',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7C7C7C),
                        letterSpacing: 0,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 723.5, left: 24.56),
              child: Column(
                children: [
                  CustomButtonWidget(
                    buttonName: 'Track Order',
                    padding: EdgeInsets.only(left: 132),
                  ),
                  CustomButtonWidget(
                    buttonName: 'Back to Home',
                    buttonColor: Colors.transparent,
                    textColor: Colors.black,
                    padding: EdgeInsets.only(left: 120),
                    onPressed: () {
                      context.go(Path.cart);
                      Future.delayed(Duration(milliseconds: 100), () {
                        showDialog(
                          context: context,
                          builder: (context) => const ErrorOrder(),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
