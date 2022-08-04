// ignore_for_file: use_key_in_widget_constructors

/*
 * widgets/intake_card_named.dart
 * 
 * Esta tarjeta se usa para informar al administrador si el paciente ha tomado 
 * o no algún medicamento. Esta se usa en el menú de inicio y lleva el nombre
 * del paciente en ella.
 *
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientCard extends StatelessWidget {
  final String patientName, initDate, finalDate, patientID;

  const PatientCard(
      this.patientName, this.initDate, this.finalDate, this.patientID);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Card(
            elevation: 5,
            color: const Color(0xFFF0F0F0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/patients/details', arguments: {
                          'name': patientName,
                          'initDate': initDate,
                          'finalDate': finalDate,
                          'patientID': patientID
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              patientName,
                              style: GoogleFonts.mukta(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Inició: $initDate",
                              style: GoogleFonts.mukta(
                                  color: Colors.black, fontSize: 20, height: 1),
                            ),
                            Text(
                              "Finaliza: $finalDate",
                              style: GoogleFonts.mukta(
                                  color: Colors.black, fontSize: 20, height: 1),
                            )
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
