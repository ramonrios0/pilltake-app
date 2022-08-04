import 'package:flutter/material.dart';
import 'package:movil/view/about.dart';
import 'package:movil/view/devices.dart';
import 'package:movil/view/help_center.dart';
import 'package:movil/view/help_view.dart';
import 'package:movil/view/home.dart';
import 'package:movil/view/login_fogot.dart';
import 'package:movil/view/patient_all_intakes.dart';
import 'package:movil/view/patient_details.dart';
import 'package:movil/view/patient_taken.dart';
import 'package:movil/view/patient_untaken.dart';
import 'package:movil/view/patients.dart';
import 'package:movil/view/profile.dart';
import 'package:movil/view/splash.dart';

import 'view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main',
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(1),
        '/login': (context) => const LogIn(),
        '/fogot-password': (context) => const LoginForgot(),
        '/home': (context) => const Home(),
        '/patients': (context) => const Patients(),
        '/patients/details': (context) => const PatientDetails(),
        '/patients/details/taken': (context) => const PatientTaken(),
        '/patients/details/untaken': (context) => const PatientUntaken(),
        '/patients/details/all-intakes': (context) => const PatientAllIntakes(),
        '/devices': (context) => const Devices(),
        '/profile': (context) => const Profile(),
        '/about': (context) => const About(),
        '/help': (context) => const Help(),
        'help/help-view': (context) => const HelpView(),
      },
    );
  }
}
