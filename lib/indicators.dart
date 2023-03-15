import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.size = 15,
    this.textColor = AppColors.black,
  });
  final Color color;
  final String text;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: GoogleFonts.mukta(
              fontSize: 16,
              color: AppColors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
