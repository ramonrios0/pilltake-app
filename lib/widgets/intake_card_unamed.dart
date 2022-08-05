// ignore_for_file: must_be_immutable

/*
 * widgets/intake_card_named.dart
 * 
 * Esta tarjeta se usa para informar al administrador si el paciente ha tomado 
 * o no algún medicamento. Esta se usa en el menú de detalles del paciente.
 *
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/utilities/app_colors.dart';

class IntakeUnamed extends StatelessWidget {
  int color = 0;
  final int type;
  double cardHeight = 0;
  final String medicine, hour, date;
  String message = '';

  IntakeUnamed(this.type, this.medicine, this.hour, this.date, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 1:
        color = 0xFF1FA8FF;
        message = "TOMADO";
        cardHeight = 90;
        break;
      case 2:
        color = 0xFFFF3838;
        message = "NO TOMADO";
        cardHeight = 90;
        break;
      case 3:
        color = 0xFFF0F0F0;
        cardHeight = 80;
        break;
      default:
        color = 0xFFFCFCFC;
        cardHeight = 110;
    }

    return Column(
      children: [
        Card(
          elevation: 5,
          color: AppColors.cardBackground,
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
                          medicine,
                          style: GoogleFonts.mukta(
                            color: AppColors.black,
                            height: 1,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$hour  $date",
                          style: GoogleFonts.mukta(
                            color: AppColors.black,
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
