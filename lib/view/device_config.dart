// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';

class DeviceConfig extends StatefulWidget {
  const DeviceConfig(
      {super.key, required this.title, required this.deviceAdress});

  final String title;
  final String deviceAdress;
  @override
  State<DeviceConfig> createState() => _DeviceConfigState();
}

class _DeviceConfigState extends State<DeviceConfig> {
  //Variables del bluetooth
  late BluetoothConnection conn;
  String _waitStatus = "CONECTANDO...";
  Color _waitColor = Colors.black;
  _DeviceConfigState();
  bool get isConnected => (conn.isConnected);
  //Variables del formulario
  bool _hide = true;
  final _formKey = GlobalKey<FormState>();
  final ssidController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _connect() async {
    try {
      conn = await BluetoothConnection.toAddress(widget.deviceAdress);
      const SnackBar(content: Text('Conectado'));
      setState(() {
        _waitStatus = "CONECTADO";
        _waitColor = AppColors.blue;
      });
    } catch (exception) {
      try {
        if (isConnected) {
          const SnackBar(content: Text('Ya estas conectado'));
          setState(() {
            _waitStatus = "CONECTADO";
            _waitColor = AppColors.blue;
          });
        } else {
          const SnackBar(content: Text('No se pudo conectar'));
          setState(() {
            _waitStatus = "SIN CONEXIÓN";
            _waitColor = AppColors.mainRed;
          });
        }
      } catch (e) {
        //Inicializando Conexión
      }
    }
  }

  void waitLoading() {
    setState(() {
      _waitStatus = "CONECTANDO...";
      _waitColor = Colors.black;
    });
  }

  void _reloadOrCheck() {
    waitLoading();
    _connect();
  }

  void _toogleHide() {
    setState(() {
      _hide = !_hide;
    });
  }

  Future<void> _sendData(String ssid, String password) async {
    Map<String, String> data = {'ssid': ssid, 'password': password};
    String jsonData = jsonEncode(data);
    conn.output.add(Uint8List.fromList(utf8.encode(jsonData)));
    await conn.output.allSent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Configuración',
              style: GoogleFonts.mukta(color: AppColors.white)),
          backgroundColor: AppColors.mainRed,
          elevation: 0),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: 90,
                decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 3))
                    ]),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Estado de conexión',
                        style: GoogleFonts.mukta(
                            color: Colors.black,
                            fontSize: 18,
                            height: 1,
                            fontWeight: FontWeight.w600)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(_waitStatus,
                            style: GoogleFonts.mukta(
                                color: _waitColor,
                                fontSize: 25,
                                height: 1,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400]),
                            onPressed: () {
                              _reloadOrCheck();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Conectando...')));
                            },
                            child: const Text('Reconectar')),
                      ],
                    )
                  ],
                ),
              ),
            ),

            ///
            ///Formulario de conexión a internet
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: 250,
                decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 3))
                    ]),
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Conectar a la red WiFi',
                          style: GoogleFonts.mukta(
                              color: Colors.black,
                              fontSize: 18,
                              height: 1,
                              fontWeight: FontWeight.w600)),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, rellene el campo';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Nombre de la red / SSID',
                            border: OutlineInputBorder()),
                        controller: ssidController,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, rellene el campo';
                          }
                          return null;
                        },
                        obscureText: _hide,
                        decoration: InputDecoration(
                            labelText: 'Contraseña',
                            border: const OutlineInputBorder(),
                            suffix: InkWell(
                              onTap: _toogleHide,
                              child: const Icon(Icons.visibility),
                            )),
                        controller: passwordController,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400]),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _sendData(
                                  ssidController.text, passwordController.text);
                              showMessage('Enviando...');
                            }
                          },
                          child: const Text('Conectar a WiFi')),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
