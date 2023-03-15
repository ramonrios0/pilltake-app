import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/config_message_model.dart' as config_message_model;
import '../models/device_medicines_model.dart';
import '../models/medicines_model.dart';
import '../utilities/app_colors.dart';
import '../variables.dart' as globals;

class DeviceConfigMenu extends StatefulWidget {
  const DeviceConfigMenu({super.key});

  @override
  State<DeviceConfigMenu> createState() => _DeviceConfigMenuState();
}

class _DeviceConfigMenuState extends State<DeviceConfigMenu> {
  TextStyle textStyle = GoogleFonts.mukta(
    color: AppColors.black,
    height: 1,
    fontSize: 17.5,
  );
  TextStyle hintStyle = GoogleFonts.mukta(
    height: 1,
    fontSize: 17.5,
  );
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Radius radius = const Radius.circular(10);
  bool ignoreInput = true;
  bool visible = false;
  String medicineValue1 = 'Ninguna';
  String medicineValue2 = 'Ninguna';
  String medicineValue3 = 'Ninguna';
  String medicineValue4 = 'Ninguna';

  List<String> medicines = <String>['Ninguna'];

  List<DropdownMenuItem<String>>? _convert(medicinesList) {
    if (medicinesList.isNotEmpty) {
      List<DropdownMenuItem<String>> dropdownList = medicinesList
          .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList();
      return dropdownList;
    } else {
      return null;
    }
  }

  Future<DeviceMedicines> _getDeviceMedicines(serialNumber) async {
    final url = Uri.parse(
        '${globals.url}/dispenser.php?type=getMedicines&sn=$serialNumber');
    final response = await http.get(url);
    return deviceMedicinesFromJson(response.body);
  }

  Future<Medicines> _getMedicines() async {
    final url = Uri.parse('${globals.url}/medicines.php');
    final response = await http.get(url);
    return medicinesFromJson(response.body);
  }

  Future<String> _sendConfig() async {
    medicineValue1 == 'Ninguna' ? (medicineValue1 = ' ') : null;
    medicineValue2 == 'Ninguna' ? (medicineValue2 = ' ') : null;
    medicineValue3 == 'Ninguna' ? (medicineValue3 = ' ') : null;
    medicineValue4 == 'Ninguna' ? (medicineValue4 = ' ') : null;
    final Map body = {
      'sn': _controller.text,
      'medicine1': medicineValue1,
      'medicine2': medicineValue2,
      'medicine3': medicineValue3,
      'medicine4': medicineValue4
    };
    final url = Uri.parse('${globals.url}/dispenser.php');
    final response = await http.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body);
    final List<config_message_model.Result> configMessage =
        config_message_model.configmessageFromJson(response.body).result;
    switch (configMessage[0].message) {
      case 'done':
        return 'Configuración guardada';
      case 'error':
        return 'Ocurrió un error al guardar';
      default:
        return 'Ocurrió un error inesperado';
    }
  }

  Future<String> _setVariables(serialNumber) async {
    try {
      final deviceResult = await _getDeviceMedicines(serialNumber);
      final medicineResult = await _getMedicines();

      List<Medicine> medicineList = medicineResult.medicines;
      for (int i = 0; i < medicineList.length; i++) {
        medicines.add(medicineList[i].name);
      }
      List<Result> deviceMedicines = deviceResult.result;
      int index1 = medicines.indexOf(deviceMedicines[0].medicine1.toString());
      int index2 = medicines.indexOf(deviceMedicines[0].medicine2.toString());
      int index3 = medicines.indexOf(deviceMedicines[0].medicine3.toString());
      int index4 = medicines.indexOf(deviceMedicines[0].medicine4.toString());
      setState(() {
        medicineValue1 = medicines.elementAt(index1);
        medicineValue2 = medicines.elementAt(index2);
        medicineValue3 = medicines.elementAt(index3);
        medicineValue4 = medicines.elementAt(index4);
        ignoreInput = !ignoreInput;
        visible = true;
      });
      return "Esta es la configuración actual";
    } on FormatException {
      return "Revisa el numero de serie";
    } catch (e) {
      return "Ocurrió un error";
    }
  }

  void showMessage(text, duration) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(text), duration: Duration(milliseconds: duration)));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
          child: Form(
            key: _formKey,
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
                      "Configurar pastilleros",
                      style: GoogleFonts.mukta(
                          color: Colors.white, height: 1, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    style: textStyle,
                    enabled: ignoreInput,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, rellene el campo';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelStyle: hintStyle,
                        labelText: 'Número de serie del dispositivo',
                        border: const OutlineInputBorder()),
                    controller: _controller,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (visible == true) {
                        showMessage(
                            'Ya se esta configurando un dispositivo', 1000);
                      } else if (_formKey.currentState!.validate()) {
                        showMessage('Obteniendo configuración...', 500);
                        _setVariables(_controller.text).then((value) {
                          showMessage(value, 1000);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400]),
                    child: Text("Iniciar configuración",
                        style: GoogleFonts.mukta(
                            color: Colors.white, fontSize: 16))),
              ],
            ),
          ),
        ),
        Visibility(
          visible: visible,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 500),
            child: Container(
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
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColors.secondaryRed,
                        borderRadius: BorderRadius.only(
                            topLeft: radius, topRight: radius)),
                    child: Center(
                      child: Text(
                        "Configuración",
                        style: GoogleFonts.mukta(
                            color: Colors.white, height: 1, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(
                      children: [
                        Text(
                          'Pastillero 1',
                          style: textStyle,
                        ),
                        DropdownButton(
                            style: textStyle,
                            isExpanded: true,
                            value: medicineValue1,
                            items: _convert(medicines),
                            onChanged: (String? value) {
                              setState(() {
                                medicineValue1 = value!;
                              });
                            }),
                        Text(
                          'Pastillero 2',
                          style: textStyle,
                        ),
                        DropdownButton(
                            style: textStyle,
                            isExpanded: true,
                            value: medicineValue2,
                            items: _convert(medicines),
                            onChanged: (String? value) {
                              setState(() {
                                medicineValue2 = value!;
                              });
                            }),
                        Text(
                          'Pastillero 3',
                          style: textStyle,
                        ),
                        DropdownButton(
                            style: textStyle,
                            isExpanded: true,
                            value: medicineValue3,
                            items: _convert(medicines),
                            onChanged: (String? value) {
                              setState(() {
                                medicineValue3 = value!;
                              });
                            }),
                        Text(
                          'Pastillero 4',
                          style: textStyle,
                        ),
                        DropdownButton(
                            style: textStyle,
                            isExpanded: true,
                            value: medicineValue4,
                            items: _convert(medicines),
                            onChanged: (String? value) {
                              setState(() {
                                medicineValue4 = value!;
                              });
                            }),
                        ElevatedButton(
                            onPressed: () {
                              _sendConfig().then((value) {
                                showMessage(value, 1000);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400]),
                            child: Text("Aceptar",
                                style: GoogleFonts.mukta(
                                    color: Colors.white, fontSize: 16)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
