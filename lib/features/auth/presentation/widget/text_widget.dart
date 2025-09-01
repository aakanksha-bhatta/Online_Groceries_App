import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String? fontFamily;
  final double letterSpacing;
  final double? height;
  final void Function()? onTap;
  final List<InlineSpan>? spans;

  const TextWidget({
    super.key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.fontFamily,
    required this.letterSpacing,
    this.height,
    this.spans,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (spans != null && spans!.isNotEmpty) {
      return RichText(
        text: TextSpan(
          text: title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            fontFamily: fontFamily ?? 'OpenSans',
            letterSpacing: letterSpacing,
            height: height,
          ),
          children: spans,
        ),
      );
    }
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily ?? 'OpenSans',
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
