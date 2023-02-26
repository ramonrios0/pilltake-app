import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/app_colors.dart';
import '../widgets/card_shimmer.dart';
import '../widgets/drawer.dart';
import '../widgets/generic_header.dart';

class DeviceConfig extends StatefulWidget {
  const DeviceConfig({super.key});

  @override
  State<DeviceConfig> createState() => _DeviceConfigState();
}

class _DeviceConfigState extends State<DeviceConfig> {
  bool _hide = true;
  final _formKey = GlobalKey<FormState>();
  final ssidController = TextEditingController();
  final passwordController = TextEditingController();

  void _toogleHide() {
    setState(() {
      _hide = !_hide;
    });
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
                height: MediaQuery.of(context).size.height * .1,
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
                        Text('CONECTADO',
                            style: GoogleFonts.mukta(
                                color: AppColors.blue,
                                fontSize: 25,
                                height: 1,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400]),
                            onPressed: () {
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
                height: MediaQuery.of(context).size.height * .3,
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
                            //if (_formKey.currentState!.validate()) { _sendData( ssidController.text, passwordController.text);}
                            showMessage('Enviando...');
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
