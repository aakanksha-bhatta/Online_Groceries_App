import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String? fontFamily;
  final double letterSpacing;
  final double? height;

  const TextWidget({
    super.key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.fontFamily,
    required this.letterSpacing, 
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
