/*
 * widgets/patient_header.dart
 * 
 * Esta cabecera se utiliza dentro del menú de detalles del paciente para mostrar
 * el nombre del paciente y las fechas de inicio y final de la receta.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../forms/form_patient.dart';
import '../utilities/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String _username;

  const ProfileHeader(this._username, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipPath(
        clipper: FormPatient(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .15,
          decoration: const BoxDecoration(color: AppColors.secondaryRed),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  _username,
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
