// ignore_for_file: must_be_immutable

/*
 * widgets/device_card.dart
 * 
 * Esta tarjeta se usa para informar al administrador si el paciente ha tomado 
 * o no algún medicamento. Esta se usa en el menú de detalles del paciente.
 *
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';

class DeviceCard extends StatelessWidget {
  final String text;
  double cardHeight = 80;

  DeviceCard(this.text, {Key? key}) : super(key: key);
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
                  onTap: () =>
                      Navigator.of(context).pushNamed('devices/config'),
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
