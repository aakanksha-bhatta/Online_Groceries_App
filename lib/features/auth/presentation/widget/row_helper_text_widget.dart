import 'package:flutter/material.dart';
import 'package:online_groceries_app/features/auth/presentation/widget/text_widget.dart';

class RowHelperTextWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const RowHelperTextWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title: title,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 0,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: const Color.fromARGB(255, 231, 230, 230),
            onTap: onTap,
            child: Text(
              'See All',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}
