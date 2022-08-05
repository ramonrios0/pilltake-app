/*
 * widgets/home_header.dart
 * 
 * Esta cabecera se utiliza dentro del menu de inico, incluye el nombre
 * del usuario.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';
import '../forms/form_home.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipPath(
        clipper: FormHome(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(color: AppColors.secondaryRed),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                child: Text(
                  '¡Bienvenido!',
                  maxLines: 3,
                  style: GoogleFonts.mukta(
                    color: AppColors.white,
                    fontSize: 30,
                    height: 1,
                  ),
                ),
              ),
            )
          ]),
        ),
      );
}
