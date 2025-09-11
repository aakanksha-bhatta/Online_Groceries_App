import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';
import 'package:online_groceries_app/core/services/cart_service.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/Dashboard/cart/error_order.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/background_layout_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_button_widget.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class OrderAccepted extends ConsumerWidget {
  const OrderAccepted({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: BackgroundLayoutWidget(
        dynamicWidget: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SvgPicture.asset(
                'assets/icons/bg_order.svg',
                height: 250,
                width: 250,
                fit: BoxFit.contain,
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  TextWidget(
                    title: 'Your Order has been',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff181725),
                    letterSpacing: 0,
                    textAlign: TextAlign.center,
                  ),
                  TextWidget(
                    title: 'accepted',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff181725),
                    letterSpacing: 0,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextWidget(
                    title: 'Your items have been placed and are on',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7C7C7C),
                    letterSpacing: 0,
                    textAlign: TextAlign.center,
                  ),
                  TextWidget(
                    title: 'their way to being processed',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7C7C7C),
                    letterSpacing: 0,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32,
              ),
              child: Column(
                children: [
                  CustomButtonWidget(
                    buttonName: 'Track Order',
                    onPressed: () async {
                      try {
                        await CartService().placeOrder();
                        context.go(Path.cart);
                      } catch (e) {
                        CustomSnackBar.show(
                          context,
                          'Failed to place order: $e',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomButtonWidget(
                    buttonName: 'Back to Home',
                    buttonColor: Colors.transparent,
                    textColor: Colors.black,
                    onPressed: () {
                      context.go(Path.cart);
                      Future.delayed(const Duration(milliseconds: 100), () {
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
