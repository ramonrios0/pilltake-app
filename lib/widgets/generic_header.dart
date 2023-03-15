/*
 * widgets/home_header.dart
 * 
 * Esta cabecera se utiliza dentro del menu de inico, incluye el nombre
 * del usuario.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../forms/form_generic.dart';
import '../utilities/app_colors.dart';

class GenericHeader extends StatelessWidget {
  final String text;

  const GenericHeader(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipPath(
        clipper: FormGeneric(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(color: AppColors.secondaryRed),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  text,
                  style: GoogleFonts.mukta(
                    color: AppColors.white,
                    fontSize: 25,
                    height: 1,
                  ),
                ),
              ),
            )
          ]),
        ),
      );
}
