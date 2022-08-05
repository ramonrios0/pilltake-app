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

import '../utilities/app_colors.dart';

class HelpCard extends StatelessWidget {
  final String text;
  final int type;
  double cardHeight = 50;

  HelpCard(this.text, this.type, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          color: AppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: cardHeight,
                child: InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed('help/help-view', arguments: {'type': type}),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            text,
                            style: GoogleFonts.mukta(
                              color: AppColors.black,
                              height: 1,
                              fontSize: 20,
                            ),
                          ),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
