import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String? fontFamily;
  final double letterSpacing;
  final double? height;
  final TextOverflow? overflow;
  final void Function()? onTap;
  final List<InlineSpan>? spans;
  final TextAlign? textAlign;

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
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily ?? 'OpenSans',
      letterSpacing: letterSpacing,
      height: height,
    );

    if (spans != null && spans!.isNotEmpty) {
      return RichText(
        text: TextSpan(
          text: title,
          style: style,
          children: spans,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: style,
        overflow: overflow ?? TextOverflow.ellipsis,
        textAlign: textAlign,
      ),
    );
  }
}
