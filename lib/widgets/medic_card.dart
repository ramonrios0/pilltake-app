import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';

class MedicCard extends StatelessWidget {
  final String name, mail, phone;

  const MedicCard(this.name, this.mail, this.phone, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: 5,
            color: AppColors.cardBackground,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Nombre: $name',
                            style: GoogleFonts.mukta(
                                fontSize: 18,
                                color: AppColors.black,
                                height: 1.5)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Correo: $mail',
                            style: GoogleFonts.mukta(
                                fontSize: 18,
                                color: AppColors.black,
                                height: 1.5)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Telefono: $phone',
                            style: GoogleFonts.mukta(
                                fontSize: 18,
                                color: AppColors.black,
                                height: 1.5)),
                      ),
                    ],
                  ),
                ))),
      ],
    );
  }
}
