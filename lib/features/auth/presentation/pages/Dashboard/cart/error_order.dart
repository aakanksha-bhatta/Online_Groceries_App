import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_app/config/route/path.dart';

class ErrorOrder extends StatelessWidget {
  const ErrorOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Order Error'),
      content: const Text('There was a problem with your order.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.go(Path.cart);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
