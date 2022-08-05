import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';
import '../widgets/drawer.dart';
import '../widgets/generic_header.dart';
import '../widgets/help_card.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  static List<String> helpTitles = [
    'Ver datos de un paciente',
    'No aparecen pacientes',
    'Cerrar Sesión',
    'Conectar a dispositivo',
    'Configurar dispositivo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMain(5),
      appBar: AppBar(
          title: Text('Centro de ayuda',
              style: GoogleFonts.mukta(color: AppColors.white)),
          backgroundColor: AppColors.mainRed,
          elevation: 0),
      body: Column(
        children: [
          const GenericHeader('¿En que ocupas ayuda?'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: helpTitles.length,
            itemBuilder: (BuildContext context, int i) {
              return HelpCard(helpTitles[i], i);
            },
          ),
        ],
      ),
    );
  }
}
