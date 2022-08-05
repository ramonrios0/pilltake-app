import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/utilities/app_colors.dart';
import 'package:movil/widgets/card_shimmer.dart';
import 'package:movil/widgets/drawer.dart';
import 'package:movil/widgets/generic_header.dart';

class Devices extends StatelessWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMain(4),
      appBar: AppBar(
          title: Text('Dispositivos',
              style: GoogleFonts.mukta(color: AppColors.white)),
          backgroundColor: AppColors.mainRed,
          elevation: 0),
      body: ListView(children: const [
        GenericHeader('Selecciona un dispositivo'),
        CardShimmer(),
        CardShimmer()
      ]),
    );
  }
}
