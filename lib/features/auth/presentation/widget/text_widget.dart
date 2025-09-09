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
<<<<<<< HEAD
  final TextOverflow? overflow;
  final void Function()? onTap;
  final List<InlineSpan>? spans;
  final TextAlign? textAlign;
=======
  final void Function()? onTap;
  final List<InlineSpan>? spans;
>>>>>>> master

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
<<<<<<< HEAD
    this.overflow,
    this.textAlign,
=======
>>>>>>> master
  });

  @override
  Widget build(BuildContext context) {
    if (spans != null && spans!.isNotEmpty) {
      return RichText(
        text: TextSpan(
          text: title,
<<<<<<< HEAD

=======
>>>>>>> master
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
<<<<<<< HEAD
      
      textAlign: textAlign,
=======
>>>>>>> master
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
<<<<<<< HEAD
        overflow: overflow ?? TextOverflow.ellipsis,
=======
>>>>>>> master
        fontFamily: fontFamily ?? 'OpenSans',
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
