/*
 * patients.dart
 *
 * En esta pantalla se muestran los pacientes que están ligados a la cuenta del
 * encargado.
 * 
 */

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil/variables.dart' as globals;
import 'package:http/http.dart' as http;

import '../utilities/app_colors.dart';
import '../widgets/drawer.dart';
import '../widgets/generic_header.dart';
import '../widgets/patient_card.dart';
import '../models/patients_model.dart';
import '../widgets/card_shimmer.dart';

class Patients extends StatefulWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  void initState() {
    super.initState();
    _getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMain(2),
      appBar: AppBar(
        title: Text(
          'Pacientes',
          style: GoogleFonts.mukta(color: AppColors.white),
        ),
        backgroundColor: AppColors.mainRed,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          const GenericHeader('Selecciona un paciente'),
          Expanded(
            child: FutureBuilder<PatientResponse>(
              future: _getPatients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const _Shimmer();
                } else if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return _PatientsList(snapshot.data!.patient);
                } else {
                  return Center(
                    child: Text(
                      'Ocurrió un error, intentalo de nuevo más tarde.',
                      style: GoogleFonts.mukta(fontStyle: FontStyle.italic),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<PatientResponse> _getPatients() async {
    var url =
        Uri.parse('${globals.url}patients.php?type=2&id=${globals.userID}');

    final response = await http.get(url);

    return patientResponseFromJson(response.body);
  }
}

class _PatientsList extends StatelessWidget {
  final List<Patient> patients;
  const _PatientsList(this.patients);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (BuildContext context, int i) {
        final patient = patients[i];
        var splitStart = patient.start.toString().split(' ');
        var splitEnd = patient.end.toString().split(' ');
        splitStart = splitStart[0].split('-');
        splitEnd = splitEnd[0].split('-');
        final start = '${splitStart[2]}/${splitStart[1]}/${splitStart[0]}';
        final end = '${splitEnd[2]}/${splitEnd[1]}/${splitEnd[0]}';

        return FadeInLeft(
            delay: Duration(milliseconds: 50 * i),
            duration: const Duration(milliseconds: 250),
            child:
                PatientCard(patient.name, start, end, patient.id.toString()));
      },
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      CardShimmer(),
      CardShimmer(),
      CardShimmer(),
      CardShimmer(),
    ]);
  }
}
