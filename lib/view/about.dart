import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/widgets/drawer.dart';

import '../forms/form_login.dart';
import '../utilities/app_colors.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainRed,
        drawer: const DrawerMain(6),
        appBar: AppBar(backgroundColor: AppColors.secondaryRed, elevation: 0),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Align(
            alignment: const AlignmentDirectional(0.05, 0),
            child: ClipPath(
              clipper: LoginForm(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(color: AppColors.secondaryRed),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/images/PillTakeLogo.png',
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.5,
                        )
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Center(
              child: Column(children: [
            Text('Versión:',
                style: GoogleFonts.mukta(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            Text('Pre-Release 0.4.8',
                style: GoogleFonts.mukta(
                    color: AppColors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic))
          ]))
        ]));
  }
}
