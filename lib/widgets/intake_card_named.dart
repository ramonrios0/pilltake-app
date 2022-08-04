// ignore_for_file: must_be_immutable

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

class IntakeNamed extends StatelessWidget {
  final int type;
  final String patient, medicine, hour, date;
  String message = '';
  int color = 0;
  double cardHeight = 0;

  IntakeNamed(this.type, this.patient, this.medicine, this.hour, this.date,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 1:
        color = 0xFF1FA8FF;
        message = "TOMADO";
        cardHeight = 120;
        break;
      case 2:
        color = 0xFFFF3838;
        message = "NO TOMADO";
        cardHeight = 120;
        break;
      case 3:
        color = 0xFFF0F0F0;
        cardHeight = 100;
        break;
      default:
        color = 0xFFFCFCFC;
        cardHeight = 110;
    }

    return Column(
      children: [
        Card(
          elevation: 5,
          color: const Color(0xFFF0F0F0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: cardHeight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          patient,
                          style: GoogleFonts.mukta(
                              color: Colors.black,
                              fontSize: 20,
                              height: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          medicine,
                          style: GoogleFonts.mukta(
                            color: Colors.black,
                            height: 1,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$hour  $date",
                          style: GoogleFonts.mukta(
                            color: Colors.black,
                            height: 1,
                            fontSize: 20,
                          ),
                        ),
                        if (type < 3)
                          Text(
                            message,
                            style: GoogleFonts.mukta(
                                color: Color(color),
                                fontSize: 20,
                                height: 1.5,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          )
                      ]),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
