import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;

  const TextWidget({
    super.key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
