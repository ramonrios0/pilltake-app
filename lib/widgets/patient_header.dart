// ignore_for_file: use_key_in_widget_constructors

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

class PatientHeader extends StatelessWidget {
  final String nombreUsuario, finalDate, initDate;

  const PatientHeader(this.nombreUsuario, this.initDate, this.finalDate);

  @override
  Widget build(BuildContext context) => ClipPath(
        clipper: FormPatient(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(color: AppColors.secondaryRed),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  nombreUsuario,
                  maxLines: 3,
                  style: GoogleFonts.mukta(
                    color: AppColors.white,
                    fontSize: 30,
                    height: 1,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      'Inició: $initDate',
                      style: GoogleFonts.mukta(
                          color: AppColors.white, fontSize: 20, height: 1),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      'Finaliza: $finalDate',
                      style: GoogleFonts.mukta(
                          color: AppColors.white, fontSize: 20, height: 1),
                    )),
              ],
            )
          ]),
        ),
      );
}
