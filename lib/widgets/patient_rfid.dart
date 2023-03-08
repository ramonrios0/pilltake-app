import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';

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

  List<String> patients = <String>['Seleccionar'];

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

  void showMessage(text, duration) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(text), duration: Duration(milliseconds: duration)));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
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
                  DropdownButton(
                      style: textStyle,
                      isExpanded: true,
                      value: _patient,
                      items: _convert(patients),
                      onChanged: (String? value) {
                        setState(() {
                          _patient = value!;
                        });
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
                        border: OutlineInputBorder()),
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
                  showMessage('Asignando...', 1000);
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
