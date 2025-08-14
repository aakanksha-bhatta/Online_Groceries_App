import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String? fontFamily;
  final double letterSpacing;

  const TextWidget({
    super.key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.fontFamily,
    required this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        // fontFamily: 'Gilroy',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
