import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../models/config_message_model.dart' as config_message_model;
import '../models/patients_model.dart';
import '../utilities/app_colors.dart';
import '../variables.dart' as globals;

class PatientRFIDConfig extends StatefulWidget {
  const PatientRFIDConfig({super.key});

  @override
  State<PatientRFIDConfig> createState() => _PatientRFIDConfigState();
}

class _PatientRFIDConfigState extends State<PatientRFIDConfig> {
  TextStyle textStyle = GoogleFonts.mukta(
    color: AppColors.black,
    height: 1,
    fontSize: 17.5,
  );
  TextStyle hintStyle = GoogleFonts.mukta(
    height: 1,
    fontSize: 17.5,
  );
  Radius radius = const Radius.circular(10);
  final _formKey = GlobalKey<FormState>();
  final _rfid = TextEditingController();
  String _patient = 'Seleccionar';

  List<String> patientList = ['Seleccionar'];

  Future<PatientResponse> _getPatients() async {
    final url =
        Uri.parse('${globals.url}/patients.php?type=3&id=${globals.userID}');
    final response = await http.get(url);
    return patientResponseFromJson(response.body);
  }

  List<DropdownMenuItem<String>>? _convert(patients) {
    if (patients.isNotEmpty) {
      List<DropdownMenuItem<String>> dropdownList = patients
          .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList();
      return dropdownList;
    } else {
      return null;
    }
  }

  Future<List<DropdownMenuItem<String>>?> _setPatientsList() async {
    try {
      final result = await _getPatients();
      List<Patient> patients = result.patients;
      for (int i = 0; i < patients.length; i++) {
        if (!patientList.contains('${patients[i].id} - ${patients[i].name}')) {
          patientList.add('${patients[i].id} - ${patients[i].name}');
        }
      }
      return _convert(patientList);
    } catch (e) {
      return null;
    }
  }

  Future<String> _setIdentifier() async {
    List<String> verification = _rfid.text.split('-');
    if (verification.length < 4) {
      return 'Ingresa un rfid valido';
    } else {
      if (_patient == 'Seleccionar') {
        return 'Selecciona un paciente';
      } else {
        List<String> extractID = _patient.split(' - ');
        final Map body = {'id': extractID[0], 'rfid': _rfid.text};
        final url = Uri.parse('${globals.url}/patients.php');
        final response = await http.post(url,
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: body);
        final List<config_message_model.Result> configMessage =
            config_message_model.configmessageFromJson(response.body).result;
        switch (configMessage[0].message) {
          case 'done':
            return 'Identificador vinculado exitosamente.';
          case 'error':
            return 'Ocurrió un error al vincular el identificador';
          default:
            return 'Ocurrió un error inesperado';
        }
      }
    }
  }

  void showMessage(text, duration) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(text), duration: Duration(milliseconds: duration)));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.all(radius),
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: AppColors.secondaryRed,
                borderRadius:
                    BorderRadius.only(topLeft: radius, topRight: radius)),
            child: Center(
              child: Text(
                "Vincular identificador",
                style: GoogleFonts.mukta(
                    color: Colors.white, height: 1, fontSize: 20),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Text(
                    'Selecciona un paciente',
                    style: textStyle,
                  ),
                  FutureBuilder(
                      future: _setPatientsList(),
                      builder: (context,
                          AsyncSnapshot<List<DropdownMenuItem<String>>?>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const _Shimmer();
                        } else if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                            style: textStyle,
                            isExpanded: true,
                            items: snapshot.data,
                            onChanged: (String? value) {
                              setState(() {
                                _patient = value!;
                              });
                            },
                            value: _patient,
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Error al recuperar pacientes',
                              style: textStyle,
                            ),
                          );
                        }
                      }),
                  const Divider(
                    height: 5,
                    color: AppColors.cardBackground,
                  ),
                  TextFormField(
                    controller: _rfid,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, rellene el campo';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelStyle: hintStyle,
                        labelText: 'Identificador con guiones',
                        border: const OutlineInputBorder()),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_patient == 'Seleccionar') {
                  showMessage('Selecciona un paciente', 1000);
                } else if (_formKey.currentState!.validate()) {
                  showMessage('Asignando...', 500);
                  _setIdentifier().then((value) => showMessage(value, 1000));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
              child: Text("Vincular",
                  style: GoogleFonts.mukta(color: Colors.white, fontSize: 16))),
        ],
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.white,
      highlightColor: AppColors.loading,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
