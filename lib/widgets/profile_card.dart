import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/utilities/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final String _mail, _phone;

  const ProfileCard(this._mail, this._phone, {Key? key}) : super(key: key);

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
                        child: Text('Correo: $_mail',
                            style: GoogleFonts.mukta(
                                fontSize: 18,
                                color: AppColors.black,
                                height: 1.5)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Telefono: $_phone',
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
