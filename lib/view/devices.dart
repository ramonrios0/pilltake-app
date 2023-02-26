import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/widgets/device_card.dart';

import '../utilities/app_colors.dart';
import '../widgets/card_shimmer.dart';
import '../widgets/drawer.dart';
import '../widgets/generic_header.dart';

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
      body: ListView(children: [
        const GenericHeader('Selecciona un dispositivo'),
        DeviceCard('Dispositivo 1')
      ]),
    );
  }
}
