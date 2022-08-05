import 'package:flutter/material.dart';
import 'package:movil/view/licenses.dart';

import 'view/about.dart';
import 'view/devices.dart';
import 'view/help_center.dart';
import 'view/help_view.dart';
import 'view/home.dart';
import 'view/login_fogot.dart';
import 'view/patient_all_intakes.dart';
import 'view/patient_details.dart';
import 'view/patient_taken.dart';
import 'view/patient_untaken.dart';
import 'view/patients.dart';
import 'view/profile.dart';
import 'view/splash.dart';
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
        '/about/licenses': (context) => const Licenses(),
        '/help': (context) => const Help(),
        'help/help-view': (context) => const HelpView(),
      },
    );
  }
}
